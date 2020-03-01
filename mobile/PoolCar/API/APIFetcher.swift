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
    // params wants query parameters
    static func getJSONResponse<T, Y>(_ relPath: String, params: Y? = nil,
                                      completion: @escaping (_ resp: T?, _ err: APIError?) -> Void)
        where T: Decodable, Y: Encodable {
        let baseURL = "https://infinite-stream-52265.herokuapp.com/"
        let queryURL = NSString.path(withComponents: [baseURL, relPath])

        AF.request(queryURL, method: .get, parameters: params, headers: JWTUtils.getAuthorizationHeaders())
        .validate(statusCode: 200 ..< 300)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let resp):
                completion(resp, nil)
            case .failure(let err):
                completion(nil, APIError.alamofireError(err.localizedDescription, err.responseCode))
            }
        }
    }

    // params is used for sending JSON body
    static func postJSONResponse<T, Y>(_ relPath: String, params: Y? = nil,
                                       completion: @escaping (_ resp: T?, _ err: APIError?) -> Void)
    where T: Decodable, Y: Encodable {
        let baseURL = "https://infinite-stream-52265.herokuapp.com/"
        //let baseURL = "http://localhost:5000/"
        let queryURL = NSString.path(withComponents: [baseURL, relPath])

        AF.request(queryURL, method: .post, parameters: params, encoder: URLEncodedFormParameterEncoder.default,
                   headers: JWTUtils.getAuthorizationHeaders())
        .validate(statusCode: 200 ..< 300)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let resp):
                completion(resp, nil)
            case .failure(let err):
                completion(nil, APIError.alamofireError(err.localizedDescription, err.responseCode))
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
