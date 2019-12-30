//
//  GoogleMapView.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/29/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

struct GoogleMapView: UIViewRepresentable {
    // MARK: Instance Variables
    @Binding var toLocation: GMSPlace?
    @Binding var fromLocation: GMSPlace?

    let fromMarker: GMSMarker = CustomMarker()
    let toMarker: GMSMarker = CustomMarker()

    /// Creates a `UIView` instance to be presented.
    func makeUIView(context: Self.Context) -> GMSMapView {
        // TODO: move camera on current user location
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)

        return mapView
    }

    /// Updates the presented `UIView` (and coordinator) to the latest
    /// configuration.
    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
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
