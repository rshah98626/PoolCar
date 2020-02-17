//
//  UserIDUtils.swift
//  PoolCar
//
//  Created by Rahul Shah on 2/15/20.
//  Copyright © 2020 RSInc. All rights reserved.
//
import Foundation

class UserIDUtils {
    static let tokenKey = "user_id"

    static func storeUserID(_ token: String) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: UserIDUtils.tokenKey)
    }

    static func getUserID() -> String {
        let defaults = UserDefaults.standard
        return (defaults.string(forKey: UserIDUtils.tokenKey) ?? "")
    }

    static func removeUserID() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: UserIDUtils.tokenKey)
    }
}
