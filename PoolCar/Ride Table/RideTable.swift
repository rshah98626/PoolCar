//
//  RideTable.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/30/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI
import Alamofire

struct RideTable: View {
    @EnvironmentObject var database: Database
    @ObservedObject var ridesViewModel: RidesViewModel

    var body: some View {
        VStack {
            if ridesViewModel.rides.isEmpty {
                List(database.rides) { ride in
                    // Navigation Link makes text and other items look faint in preview
                    NavigationLink(destination: RideDetail(ride: ride)) {
                        RideRow(ride: ride)
                    }
                }
            } else {
                List(ridesViewModel.rides) { ride in
                   // Navigation Link makes text and other items look faint in preview
                   NavigationLink(destination: RideDetail(ride: ride)) {
                       RideRow(ride: ride)
                   }
                }
            }
        }
    }
}

struct RideTable_Previews: PreviewProvider {
    static var previews: some View {
        RideTable(ridesViewModel: RidesViewModel()).environmentObject(Database())
    }
}
