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

    @State var ridesViewModel: RidesViewModel
    @State var originLocationText = ""
    @State var destinationLocationText = ""
    @State var tripStartDateChosen = Calendar.current.startOfDay(for: Date())

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
        ridesViewModel.fetchRides(originLocation: self.originLocationText,
                                  destinationLocation: self.destinationLocationText,
                                  startDate: self.tripStartDateChosen.timeIntervalSince1970)
        self.isShowing.toggle()
    }
}

struct RideFilter_Previews: PreviewProvider {
    static var previews: some View {
        RideFilter(isShowing: .constant(true), ridesViewModel: RidesViewModel())
    }
}
