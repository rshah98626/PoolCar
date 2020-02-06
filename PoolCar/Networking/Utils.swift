//
//  Utils.swift
//  PoolCar
//
//  Created by Raajesh Arunachalam on 2/5/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingUtilities {
    static let tokenKey = "jwt"

    static func storeJwtToken(_ token: String) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: NetworkingUtilities.tokenKey)
    }

    static func getJwtToken() -> String {
        let defaults = UserDefaults.standard
        return (defaults.string(forKey: NetworkingUtilities.tokenKey) ?? "")
    }

    static func getAuthorizationHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            .authorization(bearerToken: NetworkingUtilities.getJwtToken())
        ]

        return headers
    }
}
