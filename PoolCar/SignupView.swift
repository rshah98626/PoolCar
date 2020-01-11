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
    var body: some View {
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
            SecureField("Password", text: $passwrd)
            .padding(.horizontal)
            .frame(width: 200.0, height: 30.0)
            .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
  
            
        //button handle calling AF and submitting entered information - NEEDS to reject when fields are not entered
        Button(action: {SignupRequest(email: self.email, pass: self.passwrd, name: self.name)}) {
            Text("Sign Up")
                .frame(width: nil)
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
//This function grabs all of the values entered it and sends it to the node server
func SignupRequest(email: String, pass: String, name: String)->Void{
    //node URL
    let url = "https://infinite-stream-52265.herokuapp.com/users/signup"
    let signup = Signup(name: name, email: email, password: pass)

    AF.request(url, method: .post, parameters: signup).response{ response in debugPrint(response) }
        //need to include error handling here to ensure that connection failures and bad inputs are handled
}
//NEED TO REMEMBER TO UPDATE transport security when moving to production
