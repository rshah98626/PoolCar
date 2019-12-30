//
//  ContentView.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/25/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI

struct RideTable: View {
    @EnvironmentObject var database: Database
    @State private var showAddRideModal: Bool = false

    var addRideButton: some View {
        HStack {
            Button(action: {
                self.showAddRideModal.toggle()
            }) {
                Image(systemName: "car.fill")
                    .font(.largeTitle)
            }
            .foregroundColor(.blue)
        }
    }

    var body: some View {
        NavigationView {
            List(database.rides) { ride in
                NavigationLink(destination: RideDetail(ride: ride)) {
                    RideRow(ride: ride)
                }
            }
            .navigationBarTitle("Rides", displayMode: .inline)
            .navigationBarItems(trailing: addRideButton)
            .sheet(isPresented: $showAddRideModal) {
                AddRide(isShowing: self.$showAddRideModal)
                    .environmentObject(self.database)
            }
        }
    }

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

struct RideTable_Previews: PreviewProvider {
    static var previews: some View {
        RideTable().environmentObject(Database())
    }
}
