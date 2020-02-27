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

    @ObservedObject var ridesViewModel: RidesViewModel
    
    @State var originLocationText = ""
    @State var destinationLocationText = ""
    @State var tripStartDateChosen = Calendar.current.startOfDay(for: Date())
    @State private var showFilterModal: Bool = false

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
        .sheet(isPresented: $showAddRideModal) {
            AddRide(isShowing: self.$showAddRideModal,
                    ridesViewModel: self.ridesViewModel)
                .environmentObject(self.database)
        }
    }

    var filterButton: some View {
        HStack {
            Button(action: {
                self.showFilterModal.toggle()
            }) {
                Image(systemName: "slider.horizontal.3")
                    .font(.largeTitle)
            }
            .foregroundColor(.blue)
        }
        .sheet(isPresented: $showFilterModal) {
            RideFilter(isShowing: self.$showFilterModal,
                       ridesViewModel: self.ridesViewModel,
                       originLocationText: self.$originLocationText,
                       destinationLocationText: self.$destinationLocationText,
                       tripStartDateChosen: self.$tripStartDateChosen)
        }
    }

    /// Menu drawer button
    var sideMenuButton: some View {
        HStack {
            Button(action: {
                print(UserIDUtils.getUserID())
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
                        RideTable(ridesViewModel: self.ridesViewModel).environmentObject(database)
                        // Navigation configurations
                        .navigationBarTitle("Rides", displayMode: .inline)
                        .navigationBarItems(leading: sideMenuButton,
                                            trailing: HStack {
                                                filterButton
                                                addRideButton
                                            }
                        )
                    }

                    // side drawer
                    NavigationDrawer(isOpen: self.$drawerOpen, shouldLogOut: self.$shouldLogOut)
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(ridesViewModel: RidesViewModel()).environmentObject(Database())
    }
}
