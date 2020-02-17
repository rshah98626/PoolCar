//
//  JWTUtils.swift
//  PoolCar
//
//  Created by Raajesh Arunachalam on 2/5/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import Foundation
import Alamofire

class JWTUtils {
    static let tokenKey = "jwt"

    static func storeJwtToken(_ token: String) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: JWTUtils.tokenKey)
    }

    static func getJwtToken() -> String {
        let defaults = UserDefaults.standard
        return (defaults.string(forKey: JWTUtils.tokenKey) ?? "")
    }
  
    static func removeJwtToken() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: JWTUtils.tokenKey)
    }

    static func getAuthorizationHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            .authorization(bearerToken: JWTUtils.getJwtToken())
        ]

        return headers
    }
}
