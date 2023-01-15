//
//  Friend+CoreDataProperties.swift
//  Challenge3
//
//  Created by Don Bouncy on 15/01/2023.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: User?

}

extension Friend : Identifiable {

}
