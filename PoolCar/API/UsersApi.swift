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
    static let baseUrl = "https://infinite-stream-52265.herokuapp.com/"
    static func signUp(email: String, pass: String, name: String, successAction: @escaping () -> Void) {
        let signUpRoute = "users/signup"
        let signUpUrl = baseUrl + signUpRoute
        let signup = Signup(name: name, email: email, password: pass)

        AF.request(signUpUrl, method: .post, parameters: signup)
            .validate()
            .responseString { response in
                switch response.result {
                case let .success(token):
                    JWTUtils.storeJwtToken(token)
                    successAction()
                case let .failure(error):
                    print(error)
            }
        }
    }

    static func logIn(email: String, pass: String,
                      successAction: @escaping () -> Void, errorAction: @escaping (AFError) -> Void) {
        //node URL
        let logInRoute = "users/verify"
        let logInUrl = baseUrl + logInRoute
        let loginBody = Login(email: email, password: pass)

        AF.request(logInUrl, method: .post, parameters: loginBody)
            .validate()
            .responseString { response in
                switch response.result {
                case let .success(token):
                    JWTUtils.storeJwtToken(token)
                    successAction()

                case let .failure(error):
                    errorAction(error)
                    print(error)
                }
            }
    }
}
