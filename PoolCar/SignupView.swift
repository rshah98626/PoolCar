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
    var body: some View {
       VStack{
            Text("Create a New User")
                .font(.title)
                .fontWeight(.bold)
                
            //.font(Font.title)
            //.font(.title)
            Text("please enter your info")
                .font(.subheadline)
                .fontWeight(.light)
            
            //.padding(EdgeInsets(top: 0, bottom: 70, leading: 0))
            TextField("Email", text: $email)
                .padding(.horizontal)
                .frame(width: 200.0, height: 30.0)
                .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
        //values for text fields need to be held at VALUE
            TextField("Password", text: $passwrd)
            .padding(.horizontal)
            .frame(width: 200.0, height: 30.0)
            .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            /*TextField("Email", text:Binding<String>("hi"))
                .padding(.top, CGFloat(70.0))
                .frame(width: CGFloat(1.0), height: CGFloat(1.0))*/
            
        Button(action: {testConnection(email: self.email, pass: self.passwrd)}) {
        Text("Login")
        }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
struct Login: Encodable{
    let name: String
    let email: String
    let password: String
}

func testConnection(email: String, pass: String)->Void{
    let url = "http://localhost:8000/users/signup"
    let login = Login(name: "testusr", email: email, password: pass)

    AF.request(url, method: .post, parameters: login).response{ response in
    debugPrint(response)
        
        //need to work here to make sure there is error handling

}
}
