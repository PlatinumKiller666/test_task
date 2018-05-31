//
//  DoctorsService.swift
//  test app
//
//  Created by iosnuk on 29.05.2018.
//  Copyright © 2018 PlatinumKiller. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import Realm
import RealmSwift
import CoreLocation

class DoctorsService: NSObject {
    
    let locationManager = CLLocationManager()
    static let instance = DoctorsService()
    
    let realm:Realm
    
    private override init() {
        realm = try! Realm(configuration: Realm.Configuration())
        
        super.init()
    }
    
    func deleteAllFromDatabase()  {
        try!   realm.write {
            realm.deleteAll()
        }
    }
    
    var specialityValue: Int = 0
    var speciality: Int {
        get { return specialityValue }
        set {
            dataRequest?.cancel()
            dataRequest = nil
            specialityValue = newValue
            doctors.removeAll()
            totalCount = -1
        }
    }
    
//    func getData() -> Results<DoctorInfo> {
//        let results = realm.objects(CityInfo.self)
//        return results
//    }
    
        func getData() -> [DoctorInfo] {
            return doctors
        }
    
    var doctors = [DoctorInfo]()
    
    var dataRequest:DataRequest?
    
    //https://api.docdoc.ru/public/rest/1.0.9/doctor/list/start/1/count/10/city/1/speciality/4
    var totalCount = -1
    
    func getListOfDoctors(complection:@escaping () -> Void) -> Void {
        
        if (dataRequest != nil) || (doctors.count >= totalCount && totalCount != -1) {
            return
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        var fullRequest = BaseNetwork.baseURL+"doctor/list/start/\(doctors.count)/count/10/"
        if let cityID = UserDefaults.standard.string(forKey: "CityID") {
            fullRequest = fullRequest + "city/\(cityID)/"
        }
        fullRequest = fullRequest + "speciality/\(specialityValue)/"
        
        if let location = locationManager.location {
        fullRequest = fullRequest + "lat/\(location.coordinate.latitude)/lng/\(location.coordinate.longitude)"
        }
        
        dataRequest = Alamofire.request(fullRequest, method: .get, parameters: [:], encoding: JSONEncoding.default, headers: BaseNetwork.getHeaders())
        
        dataRequest?.responseJSON(completionHandler: { [weak self] (response) in
            switch response.result {
            case .success:
                if let JSON = response.result.value {
                    let json = JSON as! [String: Any]
                    let count = json["Total"] as? Int ?? -1
                    self?.totalCount = count
                }
                
            case .failure(let error):
                print(response.data)
                print(error)
            }
        })
        
        dataRequest?.responseArray(keyPath: "DoctorList", completionHandler:
            {[weak self] (response: DataResponse<[DoctorInfo]>) in
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self?.dataRequest = nil
                switch response.result {
                case .success:
                    let docs = response.result.value ?? []
                    self?.doctors.append(contentsOf: docs)
                    complection()
//                    for project in projects {
//                        do {
//                            try? self?.realm.write {
//                                self?.realm.create(DoctorInfo.self, value: project, update: true)
//                            }
//                        } catch let error{
//                            print("Could not write to database: ", error)
//                        }
//                    }
                    
                case .failure(let error):
                    print(response.data)
                    print(error)
                }
        })
    }
}
