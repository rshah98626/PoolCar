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
    @Binding var originLocationText: String
    @Binding var destinationLocationText: String
    @Binding var tripStartDateChosen: Date
    var body: some View {
        VStack(spacing: 30) {
            topButtonBar
            TextField("Origin City", text: self.$originLocationText)
                .padding()
                .frame(width: 250.0, height: 40.0)
                .background(Color.white)
                .border(Color.black, width: 2)

            TextField("Destination City", text: self.$destinationLocationText)
                .padding()
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
        HStack(alignment: .top, spacing: nil) {
            Button("Cancel") { self.isShowing.toggle() }
            Spacer()
            VStack(alignment: .leading, spacing: 5.0) {
                Button("Apply Filters") { self.filterRides() }
                Button("Clear Filters") { self.clearFilters() }
            }
        }
        .padding()
    }

    func filterRides() {
        let beginningOfChosenDay = Calendar.current.startOfDay(for:
            self.tripStartDateChosen).timeIntervalSince1970
        ridesViewModel.fetchFilteredRides(originLocation: self.originLocationText,
                                          destinationLocation: self.destinationLocationText,
                                          startDate: beginningOfChosenDay)
        self.isShowing.toggle()
    }

    func clearFilters() {
        self.originLocationText = ""
        self.destinationLocationText = ""
        self.tripStartDateChosen = Calendar.current.startOfDay(for: Date())

        self.ridesViewModel.setDefaultSettings()
        self.ridesViewModel.getMoreResults()
        self.isShowing.toggle()
    }
}

struct RideFilter_Previews: PreviewProvider {
    static var previews: some View {
        RideFilter(isShowing: .constant(true),
                   ridesViewModel: RidesViewModel(),
                   originLocationText: .constant("Champaign"),
                   destinationLocationText: .constant("Naperville"),
                   tripStartDateChosen: .constant(Date()))
    }
}
