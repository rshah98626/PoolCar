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
    @State var isShowingChat = false

    var body: some View {

        VStack(spacing: 20) {
            Text("From: " + ride.origin)
            Text("To: " + ride.destination)
            Text("Price: $" + String(ride.price))
            Button("Show Chat") { self.isShowingChat.toggle() }
            .sheet(isPresented: $isShowingChat) {
                MessageView(chatShowing: self.$isShowingChat).environmentObject(MessageController())
            }
        }
    }
}

struct RideDetail_Previews: PreviewProvider {
    static var previews: some View {
        RideDetail(ride: tempRides[0])
    }
}
