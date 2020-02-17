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
    
    static func getAllRides(successAction: @escaping ([Ride]) -> Void) {
        //node URL
        let getAllRidesRoute = "rides/getAll"
        let getAllRidesUrl = baseUrl + getAllRidesRoute
        
        AF.request(getAllRidesUrl, method: .get, headers: JWTUtils.getAuthorizationHeaders())
            .validate()
            .responseData() { response in
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
    
    static func addRide(ride: Ride) {
        let createRideRoute = "rides/create"
        let createRidesUrl = baseUrl + createRideRoute
        
        AF.request(createRidesUrl, method: .post, parameters: ride, headers: JWTUtils.getAuthorizationHeaders())
        .validate()
        .responseString { response in
            switch response.result {
            case let .success(id):
                print(id)
            case let .failure(error):
                print(error)
            }
        }
    }
}
