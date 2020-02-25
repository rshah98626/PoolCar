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
    private var originLocation: String?
    private var destinationLocation: String?
    private var startDate: Double?
    
    func refresh() {
        RidesApi.getRides(originLocation: self.originLocation,
                          destinationLocation: self.destinationLocation,
                          startDate: self.startDate) { ridesServer in
            print(ridesServer.count)
            self.rides = ridesServer
        }
    }
    
    func fetchRides(originLocation: String?, destinationLocation: String?, startDate: Double?) {
        if (self.originLocation != originLocation) || (self.destinationLocation != destinationLocation) || (self.startDate != startDate) {
            self.originLocation = originLocation
            self.destinationLocation = destinationLocation
            self.startDate = startDate
            
            RidesApi.getRides(originLocation: self.originLocation,
                              destinationLocation: self.destinationLocation,
                              startDate: self.startDate) { ridesServer in
                print(ridesServer.count)
                self.rides = ridesServer
            }
        }
    }
}
