//
//  ResponseModels.swift
//  PoolCar
//
//  Created by Rahul Shah on 1/28/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import Foundation

// MARK: - Ride
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
        case driver, origin, destination, latitudeOrigin, longitudeOrigin, latitudeDestination, longitudeDestination, price, space, departureTime
    }
}

// MARK: - User
struct UserResponse: Codable {
    let id, firstName, lastName, email, password: String
    let driverProfile: DriverResponse
    let preferences: PreferencesResponse

    enum CodingKeys: String, CodingKey {
        case id, firstName, lastName, email, password, driverProfile, preferences
    }
}

// MARK: - Driver
struct DriverResponse: Codable {
    let id, liscensePlate: String
    let car: CarResponse

    enum CodingKeys: String, CodingKey {
        case id, liscensePlate, car
    }
}

// MARK: - Car
struct CarResponse: Codable {
    let id, model, make, year: String

    enum CodingKeys: String, CodingKey {
        case id, model, make, year
    }
}

// MARK: - User Preferences
struct PreferencesResponse: Codable {
    let id, favoriteMusicGenre, funFact: String
    let smokeFree, petFree: Bool
    let interests: [InterestsResponse]

    enum CodingKeys: String, CodingKey {
        case id, smokeFree, petFree, funFact, interests
        case favoriteMusicGenre = "musicTaste"
    }
}

// MARK: - Interests
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
