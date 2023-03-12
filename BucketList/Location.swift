//
//  Location.swift
//  BucketList
//
//  Created by Don Bouncy on 10/03/2023.
//

import Foundation
import CoreLocation

struct SavedLocation: Identifiable, Codable, Equatable{
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    var coordinates: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = SavedLocation(id: UUID(), name: "Buckingham Palace", description: "Where Queen Elizabeth lives with her dorgis.", latitude: 51.501, longitude: -0.141)

    static func ==(lhs: SavedLocation, rhs: SavedLocation) -> Bool{
        lhs.id == rhs.id
    }
}
