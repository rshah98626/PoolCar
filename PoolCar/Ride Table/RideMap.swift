//
//  RideMap.swift
//  PoolCar
//
//  Created by Vignesh Srivatsan on 2/11/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

struct RideMap: View {
    @State private var showingGMSFrom = false
    @State private var fromLocation: GMSPlace?
    var body: some View {
        VStack {
            search
        }
    }
    var search: some View {
        VStack {
            Button("Search") {
                self.showingGMSFrom.toggle()
            }
            .sheet(isPresented: $showingGMSFrom) {
                GMSSearchPlaceController(gmsShowing: self.$showingGMSFrom, selectedLocation: self.$fromLocation)
            }
        }
    }
}

struct RideMap_Previews: PreviewProvider {
    static var previews: some View {
        RideMap()
    }
}
