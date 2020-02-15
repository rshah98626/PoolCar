//
//  Errors.swift
//  PoolCar
//
//  Created by Rahul Shah on 2/13/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import Foundation

enum APIError: Error {
    case castError(type: Any)
    case alamofireError(_ description: String?)
}
