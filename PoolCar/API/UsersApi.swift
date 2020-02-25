//
//  UsersApi.swift
//  PoolCar
//
//  Created by Raajesh Arunachalam on 2/12/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import Foundation
import Alamofire

// TODO - fix this entire file, & integrate with user ID utils

class UsersApi {
//    static let baseUrl = "https://infinite-stream-52265.herokuapp.com/"
//    static func signUp(email: String, pass: String, name: String, successAction: @escaping () -> Void) {
//        let signUpRoute = "users/signup"
//        let signUpUrl = baseUrl + signUpRoute
//        let signup = Signup(name: name, email: email, password: pass)
//
//        AF.request(signUpUrl, method: .post, parameters: signup)
//            .validate()
//            .responseString { response in
//                switch response.result {
//                case let .success(token):
//                    JWTUtils.storeJwtToken(token)
//                    successAction()
//                case let .failure(error):
//                    print(error)
//            }
//        }
//    }

    static func signUp(email: String, pass: String, name: String, successAction: @escaping () -> Void) {
        let signupBody = Signup(name: name, email: email, password: pass)

        APIFetcher.postJSONResponse("users/signup", params: signupBody) { (resp: VerifyResponse?, err: APIError?) in
            // TODO more graceful error handling
            guard let resp = resp else {
                print(err?.toString() ?? "Provided error was nil")
                return
            }

            // store jwt token and user id
            UserIDUtils.storeUserID(resp.userID)
            JWTUtils.storeJwtToken(resp.jwtToken)
            successAction()
            //self.signedUp = 1
        }
    }

//    static func logIn(email: String, pass: String,
//                      successAction: @escaping () -> Void, errorAction: @escaping (AFError) -> Void) {
//        //node URL
//        let logInRoute = "users/verify"
//        let logInUrl = baseUrl + logInRoute
//        let loginBody = Login(email: email, password: pass)
//
//        AF.request(logInUrl, method: .post, parameters: loginBody)
//            .validate()
//            .responseString { response in
//                switch response.result {
//                case let .success(token):
//                    JWTUtils.storeJwtToken(token)
//                    successAction()
//
//                case let .failure(error):
//                    errorAction(error)
//                    print(error)
//                }
//            }
//    }

    static func logIn(email: String, pass: String,
                      successAction: @escaping () -> Void, errorAction: @escaping (APIError?) -> Void) {
        let loginBody = Login(email: email, password: pass)

        APIFetcher.postJSONResponse("/users/verify", params: loginBody) { (resp: VerifyResponse?, err: APIError?) in
            // TODO ADD in response code handling!!!
            guard let resp = resp else {
                print(err?.toString() ?? "Provided error was nil")
                errorAction(err)
                //fatalError(err?.toString() ?? "Provided Error was nil")
                return
            }

            // success
            UserIDUtils.storeUserID(resp.userID)
            JWTUtils.storeJwtToken(resp.jwtToken)
            successAction()
            //self.loggedIn = 1
        }
    }
}
