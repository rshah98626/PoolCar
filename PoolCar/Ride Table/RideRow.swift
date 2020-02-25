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
            // placeholder for driver picture
            Circle().fill(Color.gray).frame(width: 75, height: 75)
            Divider()
            VStack {
                HStack {
                    Text(ride.origin)
                    Spacer()
                    // possibly add arrow
                    Text(ride.destination)
                }.padding()
                HStack {
                    Text(PriceUtils.getPriceString(ride.price))
                        .padding(.leading)
                    Spacer()
                    Text(DateUtils.getFormattedDateTime(ride.rideStartTime))
                }
                .padding(.trailing)
            }
            .padding(.bottom)
        }
    }
}

struct RideRow_Previews: PreviewProvider {
    static var previews: some View {
        RideRow(ride: tempRides[0])
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
