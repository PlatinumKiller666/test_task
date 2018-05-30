//
//  SpecialistService.swift
//  test app
//
//  Created by iosnuk on 25.05.2018.
//  Copyright © 2018 PlatinumKiller. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import Realm
import RealmSwift

class SpecialistService {
    
    static let instance = SpecialistService()
    
    let realm:Realm
    
    private init() {
        realm = try! Realm(configuration: Realm.Configuration())
    }
    
    func deleteAllFromDatabase()  {
        try!   realm.write {
            realm.deleteAll()
        }
    }
    func getData() ->   Results<SpecialityInfo> {
        let results = realm.objects(SpecialityInfo.self)
        return results
    }
    
    func getListOfSpecialities() -> Void {

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        guard getData().count == 0 else {
            return
        }
        
        Alamofire.request(BaseNetwork.baseURL+"speciality", method: .get, parameters: [:], encoding: JSONEncoding.default, headers: BaseNetwork.getHeaders()).responseArray(keyPath: "SpecList", completionHandler:
            {[weak self] (response: DataResponse<[SpecialityInfo]>) in
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                switch response.result {
                case .success:
                    let projects = response.result.value ?? []
                    
                    for project in projects {
                        do {
                            try? self?.realm.write {
                                self?.realm.create(SpecialityInfo.self, value: project, update: false)
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
}
