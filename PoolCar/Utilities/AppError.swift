//
//  AppError.swift
//  PoolCar
//
//  Created by Rahul Shah on 1/27/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import Foundation

enum AppError: Error {
    case parsing(description: String)
    case network(description: String)
}
