//
//  RidesViewModel.swift
//  PoolCar
//
//  Created by Raajesh Arunachalam on 2/12/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import Foundation

class RidesViewModel: ObservableObject {
    private static let pageLimit = 15

    @Published var rides = [Ride]()
    private var originLocation: String? = ""
    private var destinationLocation: String? = ""
    private var startDate: Double? = Calendar.current.startOfDay(for: Date()).timeIntervalSince1970

    // Stores whether there are any rides left in the pagination results
    var objectsLeft: Bool = false
    // Stores whether currently fetching rides
    var isLoading: Bool = true
    // Rides offset used for pagination
    private var currentOffset: Int = 0
    private var type: RideQueryType = .full

    init() {
        getMoreResults()
    }

    // Method sets back to default parameters to show users all rides from today onwards
    func setDefaultSettings() {
        self.originLocation = ""
        self.destinationLocation = ""
        self.startDate = Calendar.current.startOfDay(for: Date()).timeIntervalSince1970
        self.objectsLeft = false
        self.currentOffset = 0
        self.rides = [Ride]()
        self.type = .full
    }

    // Method that uses current parameters to fetch more results through the pagination offset
    func getMoreResults() {
        self.isLoading = true
        RidesApi.getRides(originLocation: self.originLocation, destinationLocation: self.destinationLocation,
                          startDate: self.startDate, offset: self.currentOffset, type: self.type) { ridesServer in
                            // Update the rides offset for fetching the next page
                            self.currentOffset += ridesServer.count
                            // If we got a full page of rides back, then that means there
                            // are likely more rides for us to fetch
                            self.objectsLeft = (ridesServer.count == RidesViewModel.pageLimit)
                            self.rides += ridesServer
                            self.isLoading = false
        }
    }
    
    // Does not change current filtering settings, but just reloads the rides data
    func refresh() {
        self.objectsLeft = false
        self.currentOffset = 0
        self.rides = [Ride]()

        self.getMoreResults()
    }

    // Method that applies chosen filters for orgin, destination, date, etc.
    func fetchFilteredRides(originLocation: String?, destinationLocation: String?, startDate: Double?) {
        self.originLocation = originLocation
        self.destinationLocation = destinationLocation
        self.startDate = startDate
        self.objectsLeft = false
        self.currentOffset = 0
        self.rides = [Ride]()
        self.type = .filtered

        self.getMoreResults()
    }
}

// RideQueryType.full refers to a full query of getting all rides from toda onwards, while
// RideQueryType.filtered refers to a filtered query of matching all parameters exactly
// and getting rides only for a specific day
enum RideQueryType: String, Codable {
    case full
    case filtered
}
