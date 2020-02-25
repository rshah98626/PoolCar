//
//  DateUtils.swift
//  PoolCar
//
//  Created by Raajesh Arunachalam on 2/24/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import Foundation

class DateUtils {
    static func getFormattedDateTime(_ time: Double?) -> String {
        if let secondsSinceEpoch = time {
            let date = Date(timeIntervalSince1970: secondsSinceEpoch)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    static func getFormattedDate(_ time: Double?, style: DateFormatter.Style) -> String {
        if let secondsSinceEpoch = time {
            let date = Date(timeIntervalSince1970: secondsSinceEpoch)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = style
            dateFormatter.timeStyle = .none
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    static func getFormattedTime(_ time: Double?, style: DateFormatter.Style) -> String {
        if let secondsSinceEpoch = time {
            let date = Date(timeIntervalSince1970: secondsSinceEpoch)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = style
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
}
