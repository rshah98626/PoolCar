//
//  RideTable.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/30/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI

struct RideTable: View {
    @EnvironmentObject var database: Database
    var body: some View {
        List(database.rides) { ride in
            // Navigation Link makes text and other items look faint in preview
            NavigationLink(destination: RideDetail(ride: ride)) {
                RideRow(ride: ride)
            }
        }
    }
}

struct RideTable_Previews: PreviewProvider {
    static var previews: some View {
        RideTable().environmentObject(Database())
    }
}
