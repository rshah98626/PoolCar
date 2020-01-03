//
//  RideDetail.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/26/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI

struct RideDetail: View {
    var ride: Ride
    var body: some View {
        VStack {
            profile
            description
            Spacer()
        }
    }
    var profile: some View {
        HStack {
        Circle().fill(Color.gray).frame(width: 225, height: 200)
            Spacer()
            VStack {
                Text("From: " + ride.origin)
                    .padding(.bottom)
                Text("To: " + ride.destination)
                    .padding()
                Text("01/01/2020")
                    .padding()
            }
        }
    }
    var description: some View {
        VStack {
            Text("Name")
            Divider()
            Text("Hobbies")
            
        }
    }
}

struct RideDetail_Previews: PreviewProvider {
    static var previews: some View {
        RideDetail(ride: tempRides[0])
    }
}
