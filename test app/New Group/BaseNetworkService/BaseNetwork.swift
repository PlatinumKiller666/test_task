//
//  BaseNetwork.swift
//  test app
//
//  Created by iosnuk on 25.05.2018.
//  Copyright © 2018 PlatinumKiller. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import Realm
import RealmSwift

class BaseNetwork: NSObject {
    static let login = "partner.13703"
    static let password = "ZZdFmtJD"

    static let versionAPI = "1.0.9"
    
    static let baseURL = "https://api.docdoc.ru/public/rest/\(versionAPI)/"
    
    let credential = URLCredential(user: login, password: password, persistence: URLCredential.Persistence.forSession)
    
    static func getHeaders() -> [String:String] {
        
        let credentialData = "\(BaseNetwork.login):\(BaseNetwork.password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        return ["Authorization": "Basic \(base64Credentials)"]
    }
}
