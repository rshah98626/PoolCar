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

struct AddRide: View {
    // MARK: Global Variables
    @Binding var isShowing: Bool
    @EnvironmentObject var database: Database

    // MARK: Instance Variables
    @State private var timing = Date()
    @State private var fromLocation: GMSPlace?
    @State private var toLocation: GMSPlace?

    // MARK: State Variables
    @State private var showingGMS = false

    // Menu buttons
    var topButtonBar: some View {
        HStack {
            Button("Cancel") { self.isShowing.toggle() }
            Spacer()
            Button("Create Ride") { self.submitRide() }.disabled(saveButtonDisabled())
        }
    }

    // Input parameters
    var inputOptions: some View {
        VStack {
            fromLabel
            toLabel
            dateTimeView
        }
    }

    var fromLabel: some View {
        HStack {
            Text("From:")
            Spacer()
            Button(self.fromLocation?.name ?? "Tap to select an origin!") {
                self.showingGMS.toggle()
            }
        }
        .padding(.top)
        .sheet(isPresented: $showingGMS) {
            AddRideController(gmsShowing: self.$showingGMS, selectedLocation: self.$fromLocation)
        }
    }

    var toLabel: some View {
        HStack {
            Text("To:")
            Spacer()
            Text("Tap to select a desination!")
                .frame(minWidth: 100, idealWidth: 200, maxWidth: 500, alignment: .leading)
        }.padding(.top)
    }

    var dateTimeView: some View {
        DatePicker("Depature Time", selection: $timing, in: Date()...)
            .labelsHidden()
    }

    // Total View
    var body: some View {
        VStack {
            topButtonBar
            inputOptions
            Spacer()
        }
        .padding()
    }

    // Adds new ride to database based upon input selections
    func submitRide() {
        let newRide = Ride(origin: "Montreal", destination: "Ontario")
        self.database.addRide(ride: newRide)
        self.isShowing.toggle()
    }

    // Disable save button unless origin and destination are selected
    func saveButtonDisabled() -> Bool {
        if fromLocation == nil && toLocation == nil {
            return true
        } else {
            return false
        }
    }
}

struct AddRideController: UIViewControllerRepresentable {
    @Binding var gmsShowing: Bool
    @Binding var selectedLocation: GMSPlace?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> GMSAutocompleteViewController {
        // Setup GMS Place controller
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator as GMSAutocompleteViewControllerDelegate

        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.country = "US"
        autocompleteController.autocompleteFilter = filter

        return autocompleteController
    }

    func updateUIViewController(_ addRideController: GMSAutocompleteViewController, context: Context) {}

    class Coordinator: NSObject, GMSAutocompleteViewControllerDelegate {
        var parent: AddRideController

        init(_ addRideController: AddRideController) {
            self.parent = addRideController
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            // Return selected place to parent controller
            self.parent.selectedLocation = place
            // Dismiss controller
            self.parent.gmsShowing = false
        }

        func viewController(_ viewController: GMSAutocompleteViewController,
                            didFailAutocompleteWithError error: Error) {
            // Dismiss controller
            self.parent.gmsShowing = false
        }

        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            // Dismiss controller
            self.parent.gmsShowing = false
        }
    }

}

struct AddRide_Previews: PreviewProvider {
    static var previews: some View {
        AddRide(isShowing: .constant(true)).environmentObject(Database())
    }
}
