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
    @State private var password = ""
    @State private var email = ""
    @State private var name = ""
    @State private var signedUp = 0
    var body: some View {
        VStack{
            if signedUp == 0{
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
                        .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    
                    //email field - needs proper formatting
                    TextField("Email", text: $email)
                        .padding(.horizontal)
                        .frame(width: 200.0, height: 30.0)
                        .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    
                    //password field, is set to secure typing
                    SecureField("Password", text: $password)
                        .padding(.horizontal)
                        .frame(width: 200.0, height: 30.0)
                        .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    
                    
                    //button handle calling AF and submitting entered information - NEEDS to reject when fields are not entered
                    Button(action: {
                        UsersApi.signUp(email: self.email, pass: self.password, name: self.name) {
                            self.signedUp = 1
                        }
                    }) {
                        Text("Sign Up")
                            .frame(width: nil)
                    }
                }}
            else{
                //takes user to the home page once successful signup
                
                Home()
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
struct Signup: Encodable{
    let name: String
    let email: String
    let password: String
}

//NEED TO REMEMBER TO UPDATE transport security when moving to production
