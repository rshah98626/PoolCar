//
//  SwiftUIView.swift
//  PoolCar
//
//  Created by Bhavish Bhattar on 12/30/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        VStack{
         Text("WELCOME TO POOL")
    NavigationLink(destination: LoginView()){
                Text("Login")
    }
    .frame(width: 200.0, height: 40.0)
    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            NavigationLink(destination: SignupView()){
                Text("sign up")
            }
        }}
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

