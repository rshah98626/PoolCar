//
//  PreviewData.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/25/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

let ride1 = Ride(origin: "Naperville", destination: "Champaign")
let ride2 = Ride(origin: "Mount Prospect", destination: "Champaign")

let tempRides: [Ride] = [ride1, ride2]
let location1 = CLLocationCoordinate2D(latitude: 41.750788, longitude:-88.154189)
let location2 = CLLocationCoordinate2D(latitude:42.065816, longitude:-87.936386)
let location3 = CLLocationCoordinate2D(latitude:40.116710, longitude:-88.242780)
let location4 = CLLocationCoordinate2D(latitude:40.692789, longitude:-89.589438)
let tempLocations: [CLLocationCoordinate2D] =
    [location1, location2, location3, location4]
let tempNames = ["Naperville, IL", "Mount Prospect, IL", "Champaign, IL", "Peoria, IL"]
