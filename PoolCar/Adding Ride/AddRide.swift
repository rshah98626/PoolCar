//
//  AddRide.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/26/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI
import GoogleMaps
import GooglePlaces
import os

struct AddRide: View {
    // MARK: Global Variables
    @Binding var isShowing: Bool
    @EnvironmentObject var database: Database

    // MARK: New State Variables
    @State private var timing = Date()
    @State private var fromLocation: GMSPlace?
    @State private var toLocation: GMSPlace?
    @State private var showingGMSTo = false
    @State private var showingGMSFrom = false

    var body: some View {
        VStack {
            topButtonBar
            InputOptions(timing: $timing, fromLocation: $fromLocation,
                         toLocation: $toLocation, showingGMSTo: $showingGMSTo, showingGMSFrom: $showingGMSFrom)
            GoogleMapView(toLocation: $toLocation, fromLocation: $fromLocation)
                .padding()
            Spacer()
        }
    }

    /// Menu buttons
    var topButtonBar: some View {
        HStack {
            Button("Cancel") { self.isShowing.toggle() }
            Spacer()
            Button("Create Ride") { self.submitRide() }.disabled(saveButtonDisabled())
        }
        .padding()
    }

    /// Adds new ride to database based upon input selections
    func submitRide() {
        var originTown = ""
        var destinationTown = ""

        for addressComponent in self.fromLocation!.addressComponents! {
            if addressComponent.types.contains("locality") {
                originTown = addressComponent.name
            }
        }

        for addressComponent in self.toLocation!.addressComponents! {
            if addressComponent.types.contains("locality") {
                destinationTown = addressComponent.name
            }
        }

        let newRide = Ride(origin: originTown, destination: destinationTown)
        self.database.addRide(ride: newRide)
        self.isShowing.toggle()
    }

    /// Disable save button unless origin and destination are selected
    func saveButtonDisabled() -> Bool {
        if fromLocation == nil || toLocation == nil {
            return true
        } else {
            return false
        }
    }
}

struct AddRide_Previews: PreviewProvider {
    static var previews: some View {
        AddRide(isShowing: .constant(true)).environmentObject(Database())
    }
}
