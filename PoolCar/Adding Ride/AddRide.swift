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
                           latitudeOrigin: fromLocation?.coordinate.latitude ?? 0.0,
                           longitudeOrigin: fromLocation?.coordinate.longitude ?? 0.0,
                           latitudeDestination: toLocation?.coordinate.latitude ?? 0.0,
                           longitudeDestination: toLocation?.coordinate.longitude ?? 0.0
                      )
        self.database.addRide(ride: newRide)
        //adding ride via Heroku Server
        self.riderAddRequest(newRide: newRide)
        self.isShowing.toggle()
    }
    //This function sends ride object to MongoDB
    func riderAddRequest(newRide: Ride)->Void{
        //node URL - online server
        let url = "http://infinite-stream-52265.herokuapp.com/rides/create"
        //local URL
        /*let url = "http://localhost:8000/rides/create"*/

        AF.request(url, method: .post, parameters: newRide, headers: NetworkingUtilities.getAuthorizationHeaders())
            .validate()
            .responseString { response in
                switch response.result {
                case let .success(id):
                    print(id)
                case let .failure(error):
                    print(error)
                }
            }
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
