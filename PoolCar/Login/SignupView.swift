//
//  SignupView.swift
//  PoolCar
//
//  Created by Bhavish Bhattar on 12/31/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI
//package allows HTTPS Requests to be sent
import Alamofire

struct SignupView: View {
    @State private var passwrd = ""
    @State private var email = ""
    @State private var name = ""
    @State private var signedUp = 0
    var body: some View {
        VStack {
            if signedUp == 0 {
                VStack {
                    Text("Create a New User")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("please enter your info")
                        .font(.subheadline)
                        .fontWeight(.light)

                    //name text field - needs proper formatting
                    TextField("Name", text: $name)
                        .padding(.horizontal)
                        .frame(width: 200.0, height: 30.0)
                        .background(Color.white)
                        .border(Color.black, width: 2)

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
                    // TODO - NEEDS to reject when fields are not entered
                    Button(
                        action: {
                            self.signupRequest(email: self.email, pass: self.passwrd, name: self.name)
                        }
                    ) {
                        Text("Sign Up")
                            .frame(width: nil)
                    }
                }
            } else {
                //takes user to the home page once successful signup
                Home()
            }
        }
    }

    //This function grabs all of the values entered it and sends it to the node server
    func signupRequest(email: String, pass: String, name: String) {
        //node URL
        let url = "https://infinite-stream-52265.herokuapp.com/users/signup"
        let signup = Signup(name: name, email: email, password: pass)

        AF.request(url, method: .post, parameters: signup)
            .validate()
            .responseString { response in
                switch response.result {
                case let .success(token):
                    JWTUtils.storeJwtToken(token)
                    self.signedUp = 1
                case let .failure(error):
                    print(error)
                }
            }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

//struct turns values into JSON format
struct Signup: Encodable {
    let name: String
    let email: String
    let password: String
}

// TODO NEED TO REMEMBER TO UPDATE transport security when moving to production
