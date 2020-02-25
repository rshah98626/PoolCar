//
//  PriceUtils.swift
//  PoolCar
//
//  Created by Raajesh Arunachalam on 2/25/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import Foundation

class PriceUtils {
    static func getPriceString(_ price: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.usesGroupingSeparator = true
        
        return (numberFormatter.string(from: price as NSNumber) ?? "")
    }
}
