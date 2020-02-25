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
        VStack {
            if JWTUtils.getJwtToken().isEmpty == false {
                Home(ridesViewModel: RidesViewModel())
            } else {
                if viewPointer == 0 {
                    VStack {
                        Text("WELCOME TO POOL")
                        Button(action: {self.viewPointer = 2}) {
                            Text("Login")
                                .frame(width: 200.0, height: 40.0)
                                .border(Color.black, width: 2)
                        }

                        Button(action: {self.viewPointer = 1}) {
                            Text("Sign Up")
                                .frame(width: 200.0, height: 40.0)
                                .border(Color.black, width: 2)
                        }
                    }
                } else if viewPointer == 1 { //takes the user to the correct view
                    SignupView()
                } else if viewPointer == 2 {
                    LoginView()
                }
            }
        }
    }
    
    /// Initializes the navigation controller
    init() {
        // navigation bar color
        UINavigationBar.appearance().backgroundColor = .green

        // for displayMode .large
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont(name: "Papyrus", size: 40)!]

        // for displayMode .inline
        UINavigationBar.appearance().titleTextAttributes = [
            .font: UIFont(name: "HelveticaNeue-Thin", size: 20)!]
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
