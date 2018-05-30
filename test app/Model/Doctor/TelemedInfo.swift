//
//  TelemedInfo.swift
//  test app
//
//  Created by iosnuk on 25.05.2018.
//  Copyright © 2018 PlatinumKiller. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class TelemedInfo: Mappable {

    
    @objc dynamic var ClinicId = ""
    @objc dynamic var Chat = ""
    @objc dynamic var Phone = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        ClinicId <- map["ClinicId"]
        Chat <- map["Chat"]
        Phone <- map["Phone"]
    }
}
