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
    
    func fetchRides(originLocation: String?, destinationLocation: String?, startDate: Double?) {
        RidesApi.getRides(originLocation: originLocation,
                          destinationLocation: destinationLocation, startDate: startDate) { ridesServer in
            print(ridesServer.count)
            self.rides = ridesServer
        }
    }
}
