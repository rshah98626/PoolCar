//
//  Response.swift
//  PoolCar
//
//  Created by Rahul Shah on 2/14/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name

// MARK: - Internal Objects
struct RideResponse: Codable {
    let riders: [UserResponse]
    let driver: UserResponse
    let id, rideID, origin: String
    let destination, departureTime: String
    let latitudeOrigin, longitudeOrigin, latitudeDestination, longitudeDestination: Double
    let price, space: Int

    enum CodingKeys: String, CodingKey {
        case riders
        case id = "_id"
        case rideID = "id"
        case driver, origin, destination, latitudeOrigin, longitudeOrigin, latitudeDestination,
        longitudeDestination, price, space, departureTime
    }
}

struct UserResponse: Codable {
    let id, firstName, lastName, email, password: String
    let driverProfile: DriverResponse
    let preferences: PreferencesResponse

    enum CodingKeys: String, CodingKey {
        case id, firstName, lastName, email, password, driverProfile, preferences
    }
}

struct DriverResponse: Codable {
    let id, liscensePlate: String
    let car: CarResponse

    enum CodingKeys: String, CodingKey {
        case id, liscensePlate, car
    }
}

struct CarResponse: Codable {
    let id, model, make, year: String

    enum CodingKeys: String, CodingKey {
        case id, model, make, year
    }
}

struct PreferencesResponse: Codable {
    let id, favoriteMusicGenre, funFact: String
    let smokeFree, petFree: Bool
    let interests: [InterestsResponse]

    enum CodingKeys: String, CodingKey {
        case id, smokeFree, petFree, funFact, interests
        case favoriteMusicGenre = "musicTaste"
    }
}

struct InterestsResponse: Codable {
    let interest: InterestsEnum

    enum InterestsEnum: String, Codable {
        case sports = "Sports"
        case music = "Music"
        case art = "Art"
        case travel = "Travel"
        case environment = "Environment"
        case politics = "Politics"
        case lit = "LIT"
    }
}

struct VerifyResponse: Codable {
    let userID, jwtToken: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case jwtToken = "token"
    }
}

// MARK: Stripe Responses
struct StripeClientSecretResponse: Codable {
    let secret: String
}
