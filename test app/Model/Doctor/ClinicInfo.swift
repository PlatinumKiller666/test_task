//
//  ClinicInfo.swift
//  test app
//
//  Created by iosnuk on 25.05.2018.
//  Copyright © 2018 PlatinumKiller. All rights reserved.
//

import UIKit
import ObjectMapper
import Realm
import RealmSwift

class ClinicInfo: Mappable {
    @objc dynamic var ClinicId = 0
    @objc dynamic var ClinicName = "Крестьянская застава"
    @objc dynamic var Street = "Люблинская"
    @objc dynamic var House = "99cc33"
    @objc dynamic var StationsDistance = "99cc33"
//    @objc dynamic var CityId = List<String>()
//    @objc dynamic var Specialities = List<ClinicSpecialityInfo>()
//    @objc dynamic var Stations = List<ClinicSpecialityInfo>()
    @objc dynamic var Longitude = 37.66478729
    @objc dynamic var Latitude = 55.732463840000001
    @objc dynamic var SlotsWork = ""

    

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        ClinicId <- map["ClinicId"]
        ClinicName <- map["ClinicName"]
        Street <- map["Street"]
        House <- map["House"]
//        CityId <- map["CityId"]
//        Specialities <- map["Specialities"]
//        Stations <- map["Stations"]
        Longitude <- map["Longitude"]
        Latitude <- map["Latitude"]
        SlotsWork <- map["SlotsWork"]
    }
}
