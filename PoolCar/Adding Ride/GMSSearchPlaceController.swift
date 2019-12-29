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
        var parent: GMSSearchPlaceController

        init(_ addRideController: GMSSearchPlaceController) {
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
