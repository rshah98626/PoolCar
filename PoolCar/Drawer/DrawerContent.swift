//
//  DrawerContent.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/30/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI

struct DrawerContent: View {
    @Binding var shouldLogOut: Bool
    
    var body: some View {
            VStack(spacing: 20) {
                Text("My Profile")
                Divider()
                Text("Settings")
                Divider()
                Text("Past Rides")
                Divider()
                
                Button(action: {self.logout()} ) {
                    Text("Log out")
                        .frame(width: nil)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.green)
    }
    
    func logout() {
        JWTUtils.removeJwtToken()
        self.shouldLogOut = true
    }
}

struct DrawerContent_Previews: PreviewProvider {
    static var previews: some View {
        DrawerContent(shouldLogOut: .constant(true))
    }
}
