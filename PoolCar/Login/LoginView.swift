//
//  LoginView.swift
//  PoolCar
//
//  Created by Bhavish Bhattar on 1/11/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import SwiftUI
//package allows HTTPS Requests to be sent
import Alamofire

struct LoginView: View {
    @State private var passwrd = ""
    @State private var email = ""
    @State private var loggedIn = 0
    @State private var showingAlert = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""

    var body: some View {
        VStack {
            if loggedIn == 0 {
                VStack {
                    Text("Welcome Back")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("please enter your info")
                        .font(.subheadline)
                        .fontWeight(.light)

                    //email field - needs proper formatting
                    TextField("Email", text: $email)
                        .padding(.horizontal)
                        .frame(width: 200.0, height: 30.0)
                        .background(Color.white)
                        .border(Color.black, width: 2)

                    //password field, is set to secure typing
                    SecureField("Password", text: $passwrd)
                        .padding(.horizontal)
                        .frame(width: 200.0, height: 30.0)
                        .background(Color.white)
                        .border(Color.black, width: 2)

                    // button handle calling AF and submitting entered information
                    // TODO: NEEDS to reject when fields are not entered
                    Button(action: {self.loginRequest(email: self.email, pass: self.passwrd)}) {
                        Text("Login")
                            .frame(width: nil)
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text(self.errorTitle), message: Text(self.errorMessage),
                              dismissButton: .default(Text("OK")))
                    }

                }

            } else {
                Home()
            }
        }
    }

    //This function grabs all of the values entered it and sends it to the node server - login
    func loginRequest(email: String, pass: String) {
        //node URL
        //let url = "https://infinite-stream-52265.herokuapp.com/users/verify"

        let login = Login(email: email, password: pass)

        APIFetcher.postJSONResponse("/users/verify", params: login) { (resp: VerifyResponse?, err: APIError?) in
            // TODO ADD in response code handling!!!
            guard let resp = resp else {
                fatalError(err?.toString() ?? "Provided Error was nil")
            }

            // success
            UserIDUtils.storeUserID(resp.userID)
            JWTUtils.storeJwtToken(resp.jwtToken)
            self.loggedIn = 1
        }

//        AF.request(url, method: .post, parameters: signup)
//            .validate()
//            .responseString { response in
//                switch response.result {
//                case let .success(token):
//                    JWTUtils.storeJwtToken(token)
//                    self.loggedIn = 1
//
//                case let .failure(error):
//                    var notSet = true
//                    if let responseCode = error.responseCode {
//                        if responseCode == 401 {
//                            self.errorTitle = "Login Failed"
//                            self.errorMessage = "Email/Password Combination Incorrect"
//                            notSet = false
//                        }
//                    }
//
//                    if notSet {
//                        self.errorTitle = "Network Error"
//                        self.errorMessage = "There was an error with the network request. Please try again"
//                    }
//
//                    self.showingAlert = true
//                    print(error)
//                }
//        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
