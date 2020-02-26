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
    case alamofireError(_ description: String?, _ responseCode: Int?)

    func toString() -> String {
        switch self {
        case .castError(let type):
            return "Cast error with type " + String(describing: type)
        case .alamofireError(let description, let responseCode):
            let desc = "Description: " + (description ?? "")
            let code = "With code: \(responseCode ?? 0)"
            return "Alamofire error. \n" + desc + "\n" + code
        }
    }
}
