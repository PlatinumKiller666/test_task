//
//  ClinicSpecialityInfo.swift
//  test app
//
//  Created by iosnuk on 25.05.2018.
//  Copyright © 2018 PlatinumKiller. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class ClinicSpecialityInfo: Mappable {
    @objc dynamic var DeparturePriceFrom = 0
    @objc dynamic var DeparturePriceTo = 0
    @objc dynamic var SpecialityId = 0
    @objc dynamic var Price = 0
    @objc dynamic var SpecialPrice = 0
    @objc dynamic var InternalRating = 0.0
    @objc dynamic var HighlightDiscount = 0

    

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        DeparturePriceFrom <- map["DeparturePriceFrom"]
        DeparturePriceTo <- map["DeparturePriceTo"]
        SpecialityId <- map["SpecialityId"]
        Price <- map["Price"]
        SpecialPrice <- map["SpecialPrice"]
        InternalRating <- map["InternalRating"]
        HighlightDiscount <- map["HighlightDiscount"]
    }
}
