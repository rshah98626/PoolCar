//
//  UsersApi.swift
//  PoolCar
//
//  Created by Raajesh Arunachalam on 2/12/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import Foundation
import Alamofire

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
                    NetworkingUtilities.storeJwtToken(token)
                    successAction()
                case let .failure(error):
                    print(error)
                    
            }
        }
        
    }
}
