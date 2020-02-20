//
//  RideTable.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/30/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI
import GoogleMaps
import GooglePlaces
import os

struct RideTable: View {
    @State var toggleMap = true
    @State private var showingGMSFrom = false
    @State private var fromLocation: GMSPlace?
    var body: some View {
        ZStack {
            RideMapView()
            DragRideInfo {
                VStack {
                    //CoverImage(imageName: "maitlandbay")
                    Text("Test")
                        .font(.headline)
                    Spacer()
                }
            }
        }
    }

    struct ListView: View {
        @EnvironmentObject var database: Database
        var body: some View {
            List(database.rides) { ride in
                // Navigation Link makes text and other items look faint in preview
                NavigationLink(destination: RideDetail(ride: ride)) {
                    RideRow(ride: ride)
                }
            }
        }
    }

    struct RideMapView: UIViewRepresentable {
    //    @State private var fromLocation: GMSPlace?
    //    @State private var toLocation: GMSPlace?
        @EnvironmentObject var database: Database
        //var viewMap: UIView!
        let fromMarker: GMSMarker = CustomMarker()
        let toMarker: GMSMarker = CustomMarker()
        func makeUIView(context: Self.Context) -> GMSMapView {
            var camera = GMSCameraPosition.camera(withLatitude: database.locations[1].latitude,
                                                  longitude: database.locations[1].longitude, zoom: 15.0)
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    //        return mapView
            var bounds = GMSCoordinateBounds()
            var index = 0
            for data in database.locations {
                let location = CLLocationCoordinate2D(latitude: data.latitude, longitude: data.longitude)
                let marker = CustomMarker()
                marker.position = location
                marker.map = mapView
                marker.title = database.names[index]
                bounds = bounds.includingCoordinate(marker.position)
                index += 1
            }
            //let update = GMSCameraUpdate.fit(bounds)
            //mapView.animate(with: update)
                camera = mapView.camera(for: bounds, insets: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))!
                    mapView.animate(to: camera)
            return mapView
        }
        func updateUIView(_ mapView: GMSMapView, context: Self.Context) {

        }
    }
    struct RideTable_Previews: PreviewProvider {
        static var previews: some View {
            RideTable().environmentObject(Database())
        }
    }

}

