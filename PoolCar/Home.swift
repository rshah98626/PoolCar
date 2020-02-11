//
//  ContentView.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/25/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var database: Database
    @State private var showAddRideModal: Bool = false
    @State private var drawerOpen: Bool = false
    @State private var shouldLogOut = false

    /// Button to add ride
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

    /// Menu drawer button
    var sideMenuButton: some View {
        HStack {
            Button(action: {
                // background thread
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.drawerOpen.toggle()
                }
            }) {
                Image(systemName: "gear")
                    .font(.largeTitle)
            }
            .foregroundColor(.blue)
        }
    }

    var body: some View {
        VStack {
            if self.shouldLogOut {
                StartView()
            } else {
                ZStack {
                    NavigationView {
                        // Ride table
                        RideTable().environmentObject(database)
                        // Navigation configurations
                        .navigationBarTitle("Rides", displayMode: .inline)
                        .navigationBarItems(leading: sideMenuButton, trailing: addRideButton)
                        .sheet(isPresented: $showAddRideModal) {
                            AddRide(isShowing: self.$showAddRideModal)
                                .environmentObject(self.database)
                        }
                    }

                    // side drawer
                    NavigationDrawer(isOpen: self.$drawerOpen, shouldLogOut: self.$shouldLogOut)
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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(Database())
    }
}
