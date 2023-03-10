//
//  Location.swift
//  BucketList
//
//  Created by Don Bouncy on 10/03/2023.
//

import Foundation

struct SavedLocation: Identifiable, Codable, Equatable{
    let id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
}
