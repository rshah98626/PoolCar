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
            Spacer()
            Text("From: " + self.ride.origin)
            Text("To: " + self.ride.destination)
            Text("Date: " + ride.getFormattedDateTime(dateStyle: .long, timeStyle: .none))
            Text("Time: " + ride.getFormattedDateTime(dateStyle: .none, timeStyle: .long))
            Text("Price: " + ride.getPriceString())
            Button("Show Chat") {
                print(self.ride.id)
                self.isShowingChat.toggle()
            }
            .sheet(isPresented: self.$isShowingChat) {
                MessageView(chatShowing: self.$isShowingChat).environmentObject(MessageController())
            }
            Spacer()
            StripeView(self.ride)
            .padding(.top).padding(.leading).padding(.trailing)
        }
    }
}

struct RideDetail_Previews: PreviewProvider {
    static var previews: some View {
        RideDetail(ride: tempRides[0])
    }
}
