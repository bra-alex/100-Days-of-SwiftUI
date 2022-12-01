//
//  Mission.swift
//  Moonshot
//
//  Created by Don Bouncy on 05/11/2022.
//

import Foundation

struct Mission: Codable, Identifiable{
    
    struct Crew: Codable{
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [Crew]
    let description: String
    
    var displayName: String{
        "Apollo \(id)"
    }
    
    var image: String{
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String{
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
