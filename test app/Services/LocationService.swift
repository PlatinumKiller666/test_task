//
//  LocationService.swift
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

class LocationService:NSObject {

    static let instance = LocationService()
    
    let realm:Realm
    let locationManager = CLLocationManager()
    
    private override init() {
        realm = try! Realm(configuration: Realm.Configuration())
        
        super.init()
        guard let _ = UserDefaults.standard.string(forKey: "CityID") else {
            
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            return
        }
    }
    
    func deleteAllFromDatabase()  {
        try!   realm.write {
            realm.deleteAll()
        }
    }
    
    func getData() -> Results<CityInfo> {
        let results = realm.objects(CityInfo.self)
        return results
    }
    
    func getListOfCityes() -> Void {
        
        guard getData().count == 0 else {
            return
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        Alamofire.request(BaseNetwork.baseURL+"city", method: .get, parameters: [:], encoding: JSONEncoding.default, headers: BaseNetwork.getHeaders()).responseArray(keyPath: "CityList", completionHandler:
            {[weak self] (response: DataResponse<[CityInfo]>) in
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                switch response.result {
                case .success:
                    let projects = response.result.value ?? []
                    
                    for project in projects {
                        do {
                            try? self?.realm.write {
                                self?.realm.create(CityInfo.self, value: project, update: true)
                            }
                        } catch let error{
                            print("Could not write to database: ", error)
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                }
        })
    }
    var escapingHandler:(() -> Void)?
    func findCity() -> Void {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let location = locationManager.location!
        Alamofire.request(BaseNetwork.baseURL+"detectCity/lat/\(location.coordinate.latitude)/lng/\(location.coordinate.longitude)", method: .get, parameters: [:], encoding: JSONEncoding.default, headers: BaseNetwork.getHeaders()).responseObject(keyPath: "City", completionHandler:
            {[weak self] (response: DataResponse<CityInfo>) in
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                switch response.result {
                case .success:
                    
                    if let project = response.result.value {
                        let alert = UIAlertController(title: NSLocalizedString("In city", comment: ""), message: project.Name, preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: UIAlertActionStyle.default, handler: {[unowned alert, self] (action) in
                            UserDefaults.standard.setValue(project.Id, forKey: "CityID")
                            alert.dismiss(animated: true, completion: nil)
                            if let _ = self?.escapingHandler{
                                self?.escapingHandler!()
                            }
                        }))
                        
                        alert.addAction(UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertActionStyle.cancel, handler: {[unowned alert] (action) in
                            alert.dismiss(animated: true, completion: nil)
                        }))
                        let app = UIApplication.shared as! AppDelegate
                        app.window?.rootViewController?.present(alert, animated: true, completion: nil)
                    }
                    
                    
                case .failure(let error):
                    
                    let alert = UIAlertController(title: NSLocalizedString("Select city", comment: ""), message: "", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertActionStyle.default, handler: {[unowned alert] (action) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    
                    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                    print(error)
                }
        })
    }
}

extension LocationService: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        findCity()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .notDetermined, .restricted:
            print("error")
            break
        default:
            manager.startUpdatingLocation()
            print("\(status)")
        }
    }
}
