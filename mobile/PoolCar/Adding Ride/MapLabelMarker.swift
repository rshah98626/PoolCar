//
//  MapLabelMarker.swift
//  
//
//  Created by Rahul Shah on 12/30/19.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapLabelMarker: GMSMarker {
    //let place: GMSPlace

    override init() {
      //self.place = place
      super.init()

      //position = place.coordinate
      icon = UIImage(named: "MapPin")
      groundAnchor = CGPoint(x: 0.5, y: 1)
      appearAnimation = .pop
    }
}
