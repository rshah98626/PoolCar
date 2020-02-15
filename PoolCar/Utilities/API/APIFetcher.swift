//
//  APIFetcher.swift
//  PoolCar
//
//  Created by Rahul Shah on 2/14/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import Foundation
import Alamofire

class APIFetcher {
    static func jsonResponse<T>(_ relPath: String, method: HTTPMethod = .get,
                                params: Parameters? = nil,
                                completion: @escaping (_ resp: T?, _ err: APIError?) -> Void) {
        let baseURL = "http://localhost:5000/"
        let queryURL = NSString.path(withComponents: [baseURL, relPath])

        AF.request(queryURL, method: method, parameters: params,
                   headers: JWTUtils.getAuthorizationHeaders())
        .validate(statusCode: 200 ..< 300)
        .responseJSON { responseJSON in
            switch responseJSON.result {
            case .success(let resp):
                guard let ret = resp as? T else {
                    completion(nil, APIError.castError(type: T.self))
                    break
                }
                completion(ret, nil)
            case .failure(let err):
                completion(nil, APIError.alamofireError(err.errorDescription))
            }
        }
    }

    static func stringResponse(relPath: String, method: HTTPMethod = .get,
                               params: Parameters? = nil,
                               completion: @escaping (String?, APIError?) -> Void) {
        let baseURL = "http://localhost:5000/"
        let queryURL = NSString.path(withComponents: [baseURL, relPath])

        AF.request(queryURL, method: method, parameters: params,
                   headers: JWTUtils.getAuthorizationHeaders())
        .validate(statusCode: 200 ..< 300)
        .responseJSON { responseJSON in
            switch responseJSON.result {
            case .success(let resp):
                guard let str = resp as? String else {
                    completion(nil, APIError.castError(type: String.self))
                    break
                }
                completion(str, nil)
            case .failure(let err):
                completion(nil, APIError.alamofireError(err.errorDescription))
            }
        }
    }
}

//class APIResponse<T> {
//    var resp: T?
//    var err: APIError?
//    var status: Status
//
//    enum Status {
//        case ok
//        case error
//    }
//
//    init(_ re: T?, _ e: APIError? = nil) {
//        if err == nil {
//            guard let re = re else {
//                fatalError("API returned no error and no response")
//            }
//            resp = re
//            err = nil
//            status = .ok
//        } else {
//            err = e
//            status = .error
//        }
//    }
//}
