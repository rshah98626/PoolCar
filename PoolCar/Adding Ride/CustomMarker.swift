//
//  CustomMarker.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/30/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class CustomMarker: GMSMarker {
    override init() {
      //self.place = place
      super.init()

      //position = place.coordinate
      icon = UIImage(named: "MapPin")
      groundAnchor = CGPoint(x: 0.5, y: 1)
      appearAnimation = .pop
    }
}
