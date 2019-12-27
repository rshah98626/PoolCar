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
        NavigationView {
            List(data) { ride in
                NavigationLink(destination: RideDetail(ride: ride)) {
                    RideRow(ride: ride)
                }
            }
            .navigationBarTitle("Rides", displayMode: .inline)
            .navigationBarItems(trailing: AddRideButton())
        }
    }

    init(data: [Ride]) {
        // navigation bar color
        UINavigationBar.appearance().backgroundColor = .green

        // for displayMode .large
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont(name: "Papyrus", size: 40)!]

        // for displayMode .inline
        UINavigationBar.appearance().titleTextAttributes = [
            .font: UIFont(name: "HelveticaNeue-Thin", size: 20)!]

        self.data = data
    }
}

struct AddRideButton: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "car.fill")
                    .font(.largeTitle)
            }
            .foregroundColor(.blue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(data: tempRides)
    }
}
