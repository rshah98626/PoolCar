//
//  AddRide.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/26/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI

struct AddRide: View {
    @Binding var isShowing: Bool
    @EnvironmentObject var database: Database

    var topButtonBar: some View {
        HStack {
            Button("Cancel") { self.isShowing.toggle() }
            Spacer()
            Button("Create Ride") { self.submitRide() }
        }
    }

    var body: some View {
        VStack {
            topButtonBar
            Spacer()
        }
        .padding()
    }

    func submitRide() {
        let newRide = Ride(origin: "Montreal", destination: "Ontario")
        self.database.addRide(ride: newRide)
        self.isShowing.toggle()
    }
}

struct AddRide_Previews: PreviewProvider {
    static var previews: some View {
        AddRide(isShowing: .constant(true)).environmentObject(Database())
    }
}
