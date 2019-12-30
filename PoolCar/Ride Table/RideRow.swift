//
//  RideRow.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/25/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI

struct RideRow: View {
    var ride: Ride
    var body: some View {
        HStack {
            Text(ride.origin)
            Text(ride.destination)
            Spacer()
        }.padding()
    }
}

struct RideRow_Previews: PreviewProvider {
    static var previews: some View {
        RideRow(ride: tempRides[0])
            .previewLayout(.fixed(width: 300, height: 50))
    }
}
