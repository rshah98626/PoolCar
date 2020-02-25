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
import Alamofire

struct AddRide: View {
    // MARK: State Variables
    @EnvironmentObject var database: Database
    @Binding var isShowing: Bool  // Bool for showing add ride controller

    @State var ridesViewModel: RidesViewModel

    // Input variables
    @State private var timing = Date()
    @State private var fromLocation: GMSPlace?
    @State private var toLocation: GMSPlace?

    // Handles showing modal of GMSPlaceController
    @State private var showingGMSTo = false
    @State private var showingGMSFrom = false

    // MARK: Body
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

        // look through address components to find town name
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
        // add ride to DB
        let newRide = Ride(origin: originTown, destination: destinationTown,
                           rideStartTime: timing.timeIntervalSince1970,
                           latitudeOrigin: fromLocation?.coordinate.latitude ?? 0.0,
                           longitudeOrigin: fromLocation?.coordinate.longitude ?? 0.0,
                           latitudeDestination: toLocation?.coordinate.latitude ?? 0.0,
                           longitudeDestination: toLocation?.coordinate.longitude ?? 0.0
                      )
        self.database.addRide(ride: newRide)
        //adding ride via Heroku Server
        RidesApi.addRide(ride: newRide)
        self.ridesViewModel.refresh()
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
        AddRide(isShowing: .constant(true), ridesViewModel: RidesViewModel()).environmentObject(Database())
    }
}
