//
//  SpecialityInfo.swift
//  test app
//
//  Created by iosnuk on 25.05.2018.
//  Copyright © 2018 PlatinumKiller. All rights reserved.
//

import UIKit
import ObjectMapper
import Realm
import RealmSwift

class SpecialityInfo: Object, Mappable {
@objc dynamic var Id = 0
@objc dynamic var Name = ""
@objc dynamic var Alias = ""
@objc dynamic var NameGenitive = "Хирурга"
@objc dynamic var NamePlural = ""
@objc dynamic var NamePluralGenitive = ""
@objc dynamic var IsSimple = false
@objc dynamic var BranchName = ""
@objc dynamic var BranchAlias = ""
    
    
    required convenience init?(map: Map) {
        self.init()
//        Id <- map["Id"]
//        Name <- map["Name"]
//        NamePlural <- map["NamePlural"]
//        NamePluralGenitive <- map["NamePluralGenitive"]
//        IsSimple <- map["IsSimple"]
//        BranchName <- map["BranchName"]
//        BranchAlias <- map["BranchAlias"]
    }
    
//    required convenience init?(map: Map) {
//        self.init()
//    }
    
//    required init(realm: RLMRealm, schema: RLMObjectSchema) {
//        super.init(realm: realm, schema: schema)
//    }
//
//    required init(value: Any, schema: RLMSchema) {
//        super.init(value: value, schema: schema)
//    }
    
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
        Id <- (map["Id"], transform)
        Name <- map["Name"]
        NamePlural <- map["NamePlural"]
        NamePluralGenitive <- map["NamePluralGenitive"]
        IsSimple <- map["IsSimple"]
        BranchName <- map["BranchName"]
        BranchAlias <- map["BranchAlias"]
    }
}
