//
//  StationInfo.swift
//  test app
//
//  Created by iosnuk on 25.05.2018.
//  Copyright © 2018 PlatinumKiller. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class StationInfo: Mappable {
    @objc dynamic var Id = 0
    @objc dynamic var Name = "Крестьянская застава"
    @objc dynamic var LineName = "Люблинская"
    @objc dynamic var LineColor = "99cc33"
    @objc dynamic var CityId = "1"
    @objc dynamic var Alias = "krestyanskaya_zastava"
    @objc dynamic var DistrictIds = ["7"]
    @objc dynamic var Longitude = 37.66478729
    @objc dynamic var Latitude = 55.732463840000001

    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        Id <- map["Id"]
        Name <- map["Name"]
        LineName <- map["LineName"]
        LineColor <- map["LineColor"]
        CityId <- map["CityId"]
        Alias <- map["Alias"]
        DistrictIds <- map["DistrictIds"]
        Longitude <- map["Longitude"]
        Latitude <- map["Latitude"]
    }
}
