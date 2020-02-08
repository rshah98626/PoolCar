//  StartView.swift
//  PoolCar
//
//  Created by Bhavish Bhattar on 12/30/19.
//  Copyright © 2019 RSInc. All rights reserved.
//
import SwiftUI

struct StartView: View {
    //view pointer directs user to the correct view (1 signup, 2 login)
    //needs a 3rd destination being if the user is still logged in
    @State private var viewPointer = 0
    var body: some View {
        VStack{
            if viewPointer == 0{
        VStack{
                Text("WELCOME TO POOL")
            Button(action: {self.viewPointer = 2}){
                Text("Login")
                .frame(width: 200.0, height: 40.0)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
    }

            Button(action: {self.viewPointer = 1}){
                        Text("Sign Up")
                        .frame(width: 200.0, height: 40.0)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            }
                }}
            //takes the user to the correct view
            else if viewPointer == 1{
            SignupView()
            }
            else if viewPointer == 2{
            LoginView()
            }}}
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
