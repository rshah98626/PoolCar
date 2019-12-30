//
//  GMSSearchPlaceController.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/29/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI
import GooglePlaces

struct GMSSearchPlaceController: UIViewControllerRepresentable {
    // MARK: Bindings
    @Binding var gmsShowing: Bool
    @Binding var selectedLocation: GMSPlace?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    /// Initialize the Google Places  searching controller
    func makeUIViewController(context: Context) -> GMSAutocompleteViewController {
        // Setup GMS Place controller
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator as GMSAutocompleteViewControllerDelegate

        // Specify a filter
        let filter = GMSAutocompleteFilter()
        filter.country = "US"
        autocompleteController.autocompleteFilter = filter

        return autocompleteController
    }

    // Delegate handles upadte of controller
    func updateUIViewController(_ addRideController: GMSAutocompleteViewController, context: Context) {}

    // MARK: Coordinator
    class Coordinator: NSObject, GMSAutocompleteViewControllerDelegate {
        var parent: GMSSearchPlaceController

        init(_ addRideController: GMSSearchPlaceController) {
            self.parent = addRideController
        }

        /// Function called when place is selected
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            // Return selected place to parent controller
            self.parent.selectedLocation = place
            // Dismiss controller
            self.parent.gmsShowing = false
        }

        /// Error handler
        // TODO: Handle errors better
        func viewController(_ viewController: GMSAutocompleteViewController,
                            didFailAutocompleteWithError error: Error) {
            // Dismiss controller
            self.parent.gmsShowing = false
        }

        /// User hits cancel
        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            // Dismiss controller
            self.parent.gmsShowing = false
        }
    }
}
