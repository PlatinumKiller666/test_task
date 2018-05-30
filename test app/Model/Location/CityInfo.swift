//
//  CityInfo.swift
//  test app
//
//  Created by iosnuk on 29.05.2018.
//  Copyright © 2018 PlatinumKiller. All rights reserved.
//

import UIKit
import ObjectMapper
import Realm
import RealmSwift


class CityInfo: Object, Mappable {
    @objc dynamic var Id = "0"
    @objc dynamic var Name = ""
    @objc dynamic var Alias = ""
    @objc dynamic var Phone = "Хирурга"
    @objc dynamic var Latitude = ""
    @objc dynamic var Longitude = ""
    @objc dynamic var SearchType = 0
    @objc dynamic var HasDiagnostic = true
    @objc dynamic var TimeZone = ""
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "Id"
    }
    
    let transform = TransformOf<Int, String>(fromJSON: { (value: String?) -> Int? in
        // transform value from String? to Int?
        return Int(value!)
    }, toJSON: { (value: Int?) -> String? in
        // transform value from Int? to String?
        if let value = value {
            return String(value)
        }
        return nil
    })
    
    func mapping(map: Map) {
        
        Id <- map["Id"]
        Name <- map["Name"]
        Alias <- map["Alias"]
        Phone <- map["Phone"]
        Latitude <- map["Latitude"]
        Longitude <- map["Longitude"]
        SearchType <- map["SearchType"]
        HasDiagnostic <- map["HasDiagnostic"]
        TimeZone <- map["TimeZone"]
    }
}
