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
            TextField("Email", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .padding(.horizontal)
                .frame(width: 200.0, height: 30.0)
                .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            TextField("Password", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
            .padding(.horizontal)
            .frame(width: 200.0, height: 30.0)
            .background(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            /*TextField("Email", text:Binding<String>("hi"))
                .padding(.top, CGFloat(70.0))
                .frame(width: CGFloat(1.0), height: CGFloat(1.0))*/
            
        Button(action: testConnection) {
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

func testConnection()-> Void {
    let url = "http://localhost:8000/users/test"

    AF.request(url).response{ response in
    debugPrint(response)
    /*
        .responseJSON { resp in
            if resp.result.isSuccess,
                let data = resp.result.value as? [String: Any],
                let user = data["currentUser"] as? [String: String],
                let users = data["users"] as? [String: [String: String]],
                let id = user["id"], let name = user["name"]
            {
                for (uid, user) in users {
                    if let name = user["name"], id != uid {
                        self.users.append(User(id: uid, name: name))
                    }
                }

                self.user = User(id: id, name: name)
                self.nameTextField.text = nil

                return handler(true)
            }

            handler(false)
    }*/
}
}
