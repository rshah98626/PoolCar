//
//  SignupView.swift
//  PoolCar
//
//  Created by Bhavish Bhattar on 12/31/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI
import Alamofire

struct SignupView: View {
    @State private var password = ""
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

                    // email field - needs proper formatting
                    TextField("Email", text: $email)
                        .padding(.horizontal)
                        .frame(width: 200.0, height: 30.0)
                        .background(Color.white)
                        .border(Color.black, width: 2)

                    // password field, is set to secure typing
                    SecureField("Password", text: $password)
                        .padding(.horizontal)
                        .frame(width: 200.0, height: 30.0)
                        .background(Color.white)
                        .border(Color.black, width: 2)

                    // button handle calling AF and submitting entered information
                    // TODO - NEEDS to reject when fields are not entered
                    Button(action: {
                        UsersApi.signUp(email: self.email, pass: self.password, name: self.name) {
                            self.signedUp = 1
                        }
                    }) {
                        Text("Sign Up")
                            .frame(width: nil)
                    }
                }
            } else {
                //takes user to the home page once successful signup
                Home(ridesViewModel: RidesViewModel())
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

// TODO NEED TO REMEMBER TO UPDATE transport security when moving to production
