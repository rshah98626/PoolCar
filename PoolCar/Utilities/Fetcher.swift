//
//  Fetcher.swift
//  PoolCar
//
//  Created by Rahul Shah on 1/28/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import Combine

protocol RideFetchable {
    /// Get the most recently listed rides
    func getRecentRides() -> AnyPublisher<RideResponse, AppError>

    /// Get the nearest rides to a certain location
    func getClosestRides(lattitude: Double, longitude: Double) -> AnyPublisher<RideResponse, AppError>

    /// Get rides which match a preference
    // TODO: correct input param
    func getRidesMatchingPreference(prefs: InterestsResponse) -> AnyPublisher<RideResponse, AppError>

    /// Get all rides a user has taken
    func getUsersRides(userID: String) -> AnyPublisher<RideResponse, AppError>
}

private class RideFetcher {
    static let scheme = "https"
//    static let host = "api.openweathermap.org"
//    static let path = "/data/2.5"
//    static let key = "<your key>"
}
