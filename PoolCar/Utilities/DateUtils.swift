//
//  DateUtils.swift
//  PoolCar
//
//  Created by Raajesh Arunachalam on 2/24/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import Foundation

class DateUtils {
    static func getFormattedDateTime(_ time: Double?, dateStyle: DateFormatter.Style = .short,
                                     timeStyle: DateFormatter.Style = .short) -> String {
        if let secondsSinceEpoch = time {
            let date = Date(timeIntervalSince1970: secondsSinceEpoch)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = dateStyle
            dateFormatter.timeStyle = timeStyle
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
}
