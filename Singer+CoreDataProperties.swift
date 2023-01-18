//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Don Bouncy on 17/12/2022.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

    public var wrappedFirstName: String{
        firstName ?? "N/A"
    }
    
    public var wrappedLastName: String{
        lastName ?? "N/A"
    }
}

extension Singer : Identifiable {

}
