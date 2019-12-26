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
                RideRow(ride: r)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(data: tempRides)
    }
}
