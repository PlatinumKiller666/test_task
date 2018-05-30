//
//  StationDistanceInfo.swift
//  test app
//
//  Created by iosnuk on 25.05.2018.
//  Copyright © 2018 PlatinumKiller. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class StationDistanceInfo: Mappable {

    @objc dynamic var Station = 0
    @objc dynamic var TimeWalking = 0
    @objc dynamic var DistanceWalking = 0
    
    

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        Station <- map["Station"]
        TimeWalking <- map["TimeWalking"]
        DistanceWalking <- map["DistanceWalking"]
    }
}
