//
//  EncodableDictionaryExtension.swift
//  PoolCar
//
//  Created by Rahul Shah on 2/15/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import Foundation

protocol EncodableExtension: Encodable {
    var dictionary: [String: Any]? {get} {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
