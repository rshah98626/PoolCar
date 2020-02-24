//
//  RidesApi.swift
//  PoolCar
//
//  Created by Raajesh Arunachalam on 2/12/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import Foundation
import Alamofire

class RidesApi {
    static let baseUrl = "https://infinite-stream-52265.herokuapp.com/"

    static func getRides(originLocation: String?, destinationLocation: String?, startDate: Double?, successAction: @escaping ([Ride]) -> Void) {
        //node URL
        let rideReq = RideRequest(originLocation: originLocation, destinationLocation: destinationLocation, startDate: startDate)

        let getAllRidesRoute = "rides/getAll"
        let getAllRidesUrl = baseUrl + getAllRidesRoute
        AF.request(getAllRidesUrl, method: .get, parameters: rideReq, headers: JWTUtils.getAuthorizationHeaders())
            .validate()
            .responseData { response in
                switch response.result {
                case let .success(data):
                    let decoder = JSONDecoder()
                    let ridesServer = (try? decoder.decode([Ride].self, from: data)) ?? [Ride]()
                    successAction(ridesServer)
                case let .failure(error):
                    print(error)
                }
            }
    }

//    static func getAllRides(successAction: @escaping([Ride]) -> Void) {
//        APIFetcher.getJSONResponse("/rides/getAll") { (resp: AllRides?, err: APIError?) in
//
//            guard let resp = resp else {
//                print(err?.toString() ?? "Provided error was nil")
//                return
//            }
//
//            successAction(resp.rides)
//        }
//    }

//    static func addRide(ride: Ride) {
//        let createRideRoute = "rides/create"
//        let createRidesUrl = baseUrl + createRideRoute
//
//        AF.request(createRidesUrl, method: .post, parameters: ride, headers: JWTUtils.getAuthorizationHeaders())
//        .validate()
//        .responseString { response in
//            switch response.result {
//            case let .success(rideID):
//                print(rideID)
//            case let .failure(error):
//                print(error)
//            }
//        }
//    }

    static func addRide(ride: Ride) {
        APIFetcher.postJSONResponse("/rides/create", params: ride) { (resp: Ride?, err: APIError?) in
            guard let resp = resp else {
                print(err?.toString() ?? "Provided error was nil")
                return
            }

            print(resp.id)
        }
    }
}
