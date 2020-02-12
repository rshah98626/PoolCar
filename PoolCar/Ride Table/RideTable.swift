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
    @State var rides: [Ride] = [Ride]()
    
    var body: some View {
        VStack {
            if rides.isEmpty {
                List(database.rides) { ride in
                    // Navigation Link makes text and other items look faint in preview
                    NavigationLink(destination: RideDetail(ride: ride)) {
                        RideRow(ride: ride)
                    }
                }
            } else {
                List(rides) { ride in
                   // Navigation Link makes text and other items look faint in preview
                   NavigationLink(destination: RideDetail(ride: ride)) {
                       RideRow(ride: ride)
                   }
                }
            }
        }
        .onAppear() {
            self.GetRides()
        }
    }
    
    func GetRides() {
        //node URL
        let url = "https://infinite-stream-52265.herokuapp.com/rides/getAll"
        
        AF.request(url, method: .get, headers: NetworkingUtilities.getAuthorizationHeaders())
            .validate()
            .responseData() { response in
                switch response.result {
                case let .success(data):
                    let decoder = JSONDecoder()
                    let ridesServer = try? decoder.decode([Ride].self, from: data)
                    self.rides = ridesServer ?? [Ride]()
                case let .failure(error):
                    print(error)
                }
        }
    }
}

struct RideTable_Previews: PreviewProvider {
    static var previews: some View {
        RideTable().environmentObject(Database())
    }
}
