//
//  DrawerContent.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/30/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI

struct DrawerContent: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("My Profile")
            Divider()
            Text("Settings")
            Divider()
            Text("Past Rides")
            Spacer()
        }
        .padding()
        .background(Color.green)
    }
}

struct DrawerContent_Previews: PreviewProvider {
    static var previews: some View {
        DrawerContent()
    }
}
