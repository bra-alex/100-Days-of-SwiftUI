//
//  Result.swift
//  BucketList
//
//  Created by Don Bouncy on 11/03/2023.
//

import Foundation

struct Result: Codable{
    let query: Query
}

struct Query: Codable{
    let pages: [String: Page]
}

struct Page: Codable, Comparable{
    let pageid: Int
    let title: String
    let terms: Terms?
    
    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
    
    static func == (lhs: Page, rhs: Page) -> Bool {
        lhs.pageid == rhs.pageid
    }
}

struct Terms: Codable{
    let description: [String]
    var fullDescription: String{
        description.joined(separator: " ")
    }
}
