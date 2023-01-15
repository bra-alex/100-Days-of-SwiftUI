//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Don Bouncy on 17/12/2022.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?
    
    public var wrappedName: String{
        name ?? "N/A"
    }

}

extension Candy : Identifiable {

}
