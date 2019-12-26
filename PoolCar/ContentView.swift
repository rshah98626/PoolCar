//
//  ContentView.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/25/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var data: [Ride]
    var body: some View {
        List {
            ForEach(data) { r in
                NavigationLink(destination: RideDetail(ride: r)){
                    RideRow(ride: r)
                }
            }
        }
        .navigationBarTitle("Rides")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ContentView(data: tempRides)
        }

    }
}
