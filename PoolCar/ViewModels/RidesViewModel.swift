//
//  RidesViewModel.swift
//  PoolCar
//
//  Created by Raajesh Arunachalam on 2/12/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import Foundation

class RidesViewModel: ObservableObject {
    @Published var rides = [Ride]()
    
    init() {
        fetchRides()
    }
    
    func fetchRides() {
        RidesApi.getAllRides(responseHandler: { response in
            switch response.result {
            case let .success(data):
                let decoder = JSONDecoder()
                let ridesServer = try? decoder.decode([Ride].self, from: data)
                self.rides = ridesServer ?? [Ride]()
            case let .failure(error):
                print(error)
            }
        })
    }
}
