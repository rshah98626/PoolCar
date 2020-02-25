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
        RidesApi.getAllRides { ridesServer in
            self.rides = ridesServer
        }
    }
}
