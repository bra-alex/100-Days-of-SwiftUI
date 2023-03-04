//
//  ComparableConformance.swift
//  BucketList
//
//  Created by Don Bouncy on 03/03/2023.
//

import Foundation
struct University: Identifiable, Comparable{
    static func < (lhs: University, rhs: University) -> Bool {
        lhs.name < rhs.name
    }
    
    let id = UUID()
    let name: String
    let state: String
    let country: String
    let domain: String
    let webPage: String
    let alphaTwoCode: String
}
