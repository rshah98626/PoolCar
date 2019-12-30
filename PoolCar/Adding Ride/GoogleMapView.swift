//
//  GoogleMapView.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/29/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI
//import UIKit
import GoogleMaps
import GooglePlaces

struct GoogleMapView: UIViewRepresentable {
    @Binding var toLocation: GMSPlace?
    @Binding var fromLocation: GMSPlace?

    let fromMarker: GMSMarker = GMSMarker()
    let toMarker: GMSMarker = GMSMarker()

    /// Creates a `UIView` instance to be presented.
    func makeUIView(context: Self.Context) -> GMSMapView {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)

        return mapView
    }

    /// Updates the presented `UIView` (and coordinator) to the latest
    /// configuration.
    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
        // Creates a marker in the center of the map.
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
        if toLocation != nil, fromLocation != nil {
            // set markers
            fromMarker.position = fromLocation!.coordinate
            toMarker.position = toLocation!.coordinate
            fromMarker.map = mapView
            toMarker.map = mapView

            // center camera on both points
            let bounds = GMSCoordinateBounds(coordinate: toLocation!.coordinate, coordinate: fromLocation!.coordinate)
            let camera = mapView.camera(for: bounds, insets: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))!
            mapView.animate(to: camera)
        } else if toLocation != nil {
            // set markers
            toMarker.position = toLocation!.coordinate
            toMarker.map = mapView

            // center on one location
            let toCam = GMSCameraUpdate.setTarget(toLocation!.coordinate, zoom: 15)
            mapView.animate(with: toCam)
        } else if fromLocation != nil {
            fromMarker.position = fromLocation!.coordinate
            fromMarker.map = mapView

            let fromCam = GMSCameraUpdate.setTarget(fromLocation!.coordinate, zoom: 15)
            mapView.animate(with: fromCam)
        }
    }
}

//struct GoogleMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        GoogleMapView()
//    }
//}
