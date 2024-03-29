//
//  RequestModels.swift
//  PoolCar
//
//  Created by Rahul Shah on 2/15/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import Foundation

struct Signup: Encodable {
    let name: String
    let email: String
    let password: String
}

struct Login: Encodable {
    let email: String
    let password: String
}

// used if body is empty
struct Empty: Codable {

}

struct UserRequest: Codable {
    let userID: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}

struct RideRequest: Codable {
    let originLocation: String?
    let destinationLocation: String?
    let startDate: Double?
    let offset: Int
    let type: RideQueryType
}
