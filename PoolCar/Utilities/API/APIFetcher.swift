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
    static func getJSONResponse<T>(_ relPath: String, params: [String: String] = [:],
                                   completion: @escaping (_ resp: T?, _ err: APIError?) -> Void)
    where T: Decodable {
        let baseURL = "http://localhost:5000/"
        var components = URLComponents(string: NSString.path(withComponents: [baseURL, relPath]))
        components?.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value) }
        let finalURL = components?.url?.absoluteString ?? ""

        AF.request(finalURL, method: .get, /*parameters: params, encoder: JSONParameterEncoder.default,*/
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
                completion(nil, APIError.alamofireError(err.errorDescription, err.responseCode))
            }
        }
    }

    // params is used for sending JSON body
    static func postJSONResponse<T, Y>(_ relPath: String, params: Y? = nil,
                                       completion: @escaping (_ resp: T?, _ err: APIError?) -> Void)
    where T: Decodable, Y: Encodable {
        let baseURL = "http://localhost:5000/"
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

    // function is only used when completion has a weird type (aka Stripe handlers)
//    static func postJSONResponse<T, Y>(_ relPath: String, params: Y? = nil,
//                                       completion: @escaping (_ resp: T?, _ err: APIError?) -> Void)
//    where Y: Encodable {
//        let baseURL = "http://localhost:5000/"
//        let queryURL = NSString.path(withComponents: [baseURL, relPath])
//
//        AF.request(queryURL, method: .post, parameters: params, encoder: URLEncodedFormParameterEncoder.default,
//                   headers: JWTUtils.getAuthorizationHeaders())
//        .validate(statusCode: 200 ..< 300)
//        .responseJSON { responseJSON in
//            switch responseJSON.result {
//            case .success(let resp):
//                guard let ret = resp as? T else {
//                    completion(nil, APIError.castError(type: T.self))
//                    break
//                }
//                completion(ret, nil)
//            case .failure(let err):
//                completion(nil, APIError.alamofireError(err.errorDescription, err.responseCode))
//            }
//        }
//    }
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
