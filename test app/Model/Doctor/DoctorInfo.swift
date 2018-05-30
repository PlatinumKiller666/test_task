//
//  DoctorInfo.swift
//  test app
//
//  Created by iosnuk on 25.05.2018.
//  Copyright © 2018 PlatinumKiller. All rights reserved.
//

import UIKit
import ObjectMapper
import Realm
import RealmSwift

class DoctorInfo: Mappable {

    @objc dynamic var Id = 0
    @objc dynamic var Name = ""
    @objc dynamic var Rating = ""
    @objc dynamic var Sex = 0
    @objc dynamic var Img = ""
    @objc dynamic var AddPhoneNumber = ""
    @objc dynamic var Category = ""
    @objc dynamic var Degree = ""
    @objc dynamic var Rank = ""
    @objc dynamic var Description = ""
    @objc dynamic var ExperienceYear = 0
    @objc dynamic var Price = 0
    @objc dynamic var SpecialPrice = 0
    @objc dynamic var Departure = 0
    @objc dynamic var Clinics:[Int] = []
    @objc dynamic var Alias = ""
    var Specialities:[SpecialityInfo] = []
    var Stations:[StationInfo] = []
    @objc dynamic var BookingClinics:[Int] = []
    @objc dynamic var isActive = true
    @objc dynamic var TextAbout = ""
    @objc dynamic var InternalRating = 0.0
    @objc dynamic var OpinionCount = 0
    @objc dynamic var Extra = ""
    @objc dynamic var KidsReception = ""
    var ClinicsInfo:[Int] = []
    var Telemed:TelemedInfo?
    @objc dynamic var ImgFormat = ""
    @objc dynamic var RatingLabel = ""
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        Id <- map["Id"]
        Name <- map["Name"]
        Rating <- map["Rating"]
        Sex <- map["Sex"]
        Img <- map["Img"]
        AddPhoneNumber <- map["AddPhoneNumber"]
        Category <- map["Category"]
        Degree <- map["Degree"]
        Rank <- map["Rank"]
        Description <- map["Description"]
        ExperienceYear <- map["ExperienceYear"]
        Price <- map["Price"]
        SpecialPrice <- map["SpecialPrice"]
        Departure <- map["Departure"]
        Clinics <- map["Clinics"]
        Alias <- map["Alias"]
        Specialities <- map["Specialities"]
        Stations <- map["Stations"]
        BookingClinics <- map["BookingClinics"]
        isActive <- map["isActive"]
        TextAbout <- map["TextAbout"]
        InternalRating <- map["InternalRating"]
        OpinionCount <- map["OpinionCount"]
        Extra <- map["Extra"]
        KidsReception <- map["KidsReception"]
        ClinicsInfo <- map["ClinicsInfo"]
        Telemed <- map["Telemed"]
        ImgFormat <- map["ImgFormat"]
        RatingLabel <- map["RatingLabel"]
    }
    
}
