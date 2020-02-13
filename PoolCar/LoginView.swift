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
        VStack{
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
                        .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    
                    //password field, is set to secure typing
                    SecureField("Password", text: $passwrd)
                        .padding(.horizontal)
                        .frame(width: 200.0, height: 30.0)
                        .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    
                    
                    //button handle calling AF and submitting entered information - NEEDS to reject when fields are not entered
                    Button(action: {self.LoginRequest(email: self.email, pass: self.passwrd)}) {
                        Text("Login")
                            .frame(width: nil)
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text(self.errorTitle), message: Text(self.errorMessage), dismissButton: .default(Text("OK")))
                    }
                    
                }
                
            }
            else{
                Home()
            }
        }
    }
    
    //This function grabs all of the values entered it and sends it to the node server - login
    func LoginRequest(email: String, pass: String) {
        //node URL
        let url = "https://infinite-stream-52265.herokuapp.com/users/verify"
        
        let signup = Login(email: email, password: pass)
        
        AF.request(url, method: .post, parameters: signup)
            .validate()
            .responseString { response in
                switch response.result {
                case let .success(token):
                    NetworkingUtilities.storeJwtToken(token)
                    self.loggedIn = 1
                    
                case let .failure(error):
                    var notSet = true
                    if let responseCode = error.responseCode {
                        if responseCode == 401 {
                            self.errorTitle = "Login Failed"
                            self.errorMessage = "Email/Password Combination Incorrect"
                            notSet = false
                        }
                    }
                    
                    if notSet {
                        self.errorTitle = "Network Error"
                        self.errorMessage = "There was an error with the network request. Please try again"
                    }
                    
                    self.showingAlert = true
                    print(error)
                }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

//login JSON struct
struct Login: Encodable{
    let email: String
    let password: String
}
