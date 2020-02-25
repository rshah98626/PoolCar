//
//  Ride.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/25/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI
import CoreLocation

struct Ride: Hashable, Codable, Identifiable {
    // swiftlint:disable:next identifier_name
    var id = UUID()
    //place holder
    var driverName: String = "billy"
    var origin: String
    var destination: String
    var rideStartTime: Double?

    var latitudeOrigin: Double
    var longitudeOrigin: Double
    var latitudeDestination: Double
    var longitudeDestination: Double
    //place holders
    var price: Double = 25
    var space: Double = 4

    func getFormattedDateTime(dateStyle: DateFormatter.Style = .short,
                              timeStyle: DateFormatter.Style = .short) -> String {
        if let secondsSinceEpoch = self.rideStartTime {
            let date = Date(timeIntervalSince1970: secondsSinceEpoch)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = dateStyle
            dateFormatter.timeStyle = timeStyle
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }

    func getPriceString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.usesGroupingSeparator = true

        return (numberFormatter.string(from: self.price as NSNumber) ?? "")
    }
}
