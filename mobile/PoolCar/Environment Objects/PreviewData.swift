//
//  PreviewData.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/25/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI

let ride1 = Ride(origin: "Naperville", destination: "Champaign",
                 rideStartTime: 1583267400.0,
                 latitudeOrigin: 41.7508, longitudeOrigin: -88.1535,
                 latitudeDestination: 40.1164, longitudeDestination: -88.2434)
let ride2 = Ride(origin: "Mount Prospect", destination: "Champaign",
                 rideStartTime: 1582988000.0,
                 latitudeOrigin: 42.0064, longitudeOrigin: -87.9373,
                 latitudeDestination: 40.1164, longitudeDestination: -88.2434)

let tempRides: [Ride] = [ride1, ride2]
