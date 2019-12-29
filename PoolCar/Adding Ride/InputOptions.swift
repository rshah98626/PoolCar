//
//  InputOptions.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/29/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI
import GooglePlaces

struct InputOptions: View {
    @Binding var timing: Date
    @Binding var fromLocation: GMSPlace?
    @Binding var toLocation: GMSPlace?

    // MARK: State Variables
    @Binding var showingGMSTo: Bool
    @Binding var showingGMSFrom: Bool

    var body: some View {
        VStack {
            fromLabel
            toLabel
            dateTimeView
        }
        .padding()
    }

    var fromLabel: some View {
        HStack {
            Text("From:")
            Spacer()
            Button(self.fromLocation?.name ?? "Tap to select an origin!") {
                self.showingGMSFrom.toggle()
            }
            .sheet(isPresented: $showingGMSFrom) {
                GMSSearchPlaceController(gmsShowing: self.$showingGMSFrom, selectedLocation: self.$fromLocation)
            }
        }
    }

    var toLabel: some View {
        HStack {
            Text("To:")
            Spacer()
            Button(self.toLocation?.name ?? "Tap to select a desination!") {
                    self.showingGMSTo.toggle()
            }
            .sheet(isPresented: $showingGMSTo) {
                GMSSearchPlaceController(gmsShowing: self.$showingGMSTo, selectedLocation: self.$toLocation)
            }
        }
        .padding(.top)
    }

    var dateTimeView: some View {
        DatePicker("Depature Time", selection: $timing, in: Date()...)
            .labelsHidden()
    }
}

struct InputOptions_Previews: PreviewProvider {
    static var previews: some View {
        InputOptions(timing: .constant(Date()), fromLocation: .constant(nil),
                     toLocation: .constant(nil), showingGMSTo: .constant(false), showingGMSFrom: .constant(false))
    }
}
