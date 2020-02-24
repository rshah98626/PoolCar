//
//  RideFilter.swift
//  PoolCar
//
//  Created by Raajesh Arunachalam on 2/23/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import SwiftUI

struct RideFilter: View {
    @Binding var isShowing: Bool
    @Binding var originLocation: String?
    @Binding var destinationLocation: String?
    @Binding var tripStartDate: Double?

    @State var originLocationText = ""
    @State var destinationLocationText = ""
    @State var tripStartDateChosen = Date()

    var body: some View {
        VStack(spacing: 30) {
            topButtonBar
            TextField("Origin Location", text: self.$originLocationText)
                .padding()
                .frame(width: 250.0, height: 40.0)
                .background(Color.white)
                .border(Color.black, width: 2)

            TextField("Destination Location", text: self.$destinationLocationText)
                .padding(.horizontal)
                .frame(width: 250.0, height: 40.0)
                .background(Color.white)
                .border(Color.black, width: 2)

            DatePicker(selection: self.$tripStartDateChosen, in: Date()..., displayedComponents: .date) {
                Text("Trip Date")
            }
            .padding()


            Spacer()
        }
    }

    /// Menu buttons
    var topButtonBar: some View {
        HStack {
            Button("Cancel") { self.isShowing.toggle() }
            Spacer()
            Button("Filter") { self.filterRides() }
        }
        .padding()
    }

    func filterRides() {
        if !self.originLocationText.isEmpty {
            self.originLocation = self.originLocationText
        }

        if !self.destinationLocationText.isEmpty {
            self.destinationLocation =
                self.destinationLocationText
        }

        self.tripStartDate = self.tripStartDateChosen.timeIntervalSince1970

        self.isShowing.toggle()
    }
}

struct RideFilter_Previews: PreviewProvider {
    static var previews: some View {
        RideFilter(isShowing: .constant(true),
                   originLocation: .constant(nil),
                   destinationLocation: .constant(nil),
                   tripStartDate: .constant(nil))
    }
}
