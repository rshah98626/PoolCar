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

    var objectsLeft: Bool = false
    var isLoading: Bool = true
    private var currentOffset: Int = 0
    private var type: RideQueryType = .full

    init() {
        getMoreResults()
    }

    func setDefaultSettings() {
        self.originLocation = ""
        self.destinationLocation = ""
        self.startDate = Calendar.current.startOfDay(for: Date()).timeIntervalSince1970
        self.objectsLeft = false
        self.currentOffset = 0
        self.rides = [Ride]()
        self.type = .full
    }

    func getMoreResults() {
        self.isLoading = true
        RidesApi.getRides(originLocation: self.originLocation, destinationLocation: self.destinationLocation,
                          startDate: self.startDate, offset: self.currentOffset, type: self.type) { ridesServer in
                            self.currentOffset += ridesServer.count
                            self.objectsLeft = (ridesServer.count == RidesViewModel.pageLimit)
                            self.rides += ridesServer
                            self.isLoading = false
        }
    }

    func refresh() {
        self.objectsLeft = false
        self.currentOffset = 0
        self.rides = [Ride]()

        self.getMoreResults()
    }

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

enum RideQueryType: String, Codable {
    case full
    case filtered
}
