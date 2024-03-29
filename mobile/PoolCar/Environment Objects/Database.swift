//
//  Database.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/26/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI
import Combine

final class Database: ObservableObject {
    @Published var rides = tempRides

    func addRide(ride: Ride) {
        self.rides.append(ride)
    }
}
