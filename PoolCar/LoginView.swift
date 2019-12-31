//
//  LoginView.swift
//  PoolCar
//
//  Created by Bhavish Bhattar on 12/31/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack{
            Text("Welcome Back")
                .font(.title)
                .fontWeight(.bold)
                
            //.font(Font.title)
            //.font(.title)
            Text("please enter your login")
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
            
        
        }
    }}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
