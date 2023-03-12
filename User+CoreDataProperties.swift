//
//  User+CoreDataProperties.swift
//  Challenge3
//
//  Created by Don Bouncy on 15/01/2023.
//
//

import Foundation
import CoreData


extension User {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: [String]?
    @NSManaged public var friends: NSSet?
    
    public var unwrappedId: String {
        id ?? ""
    }
    
    public var unwrappedName: String {
        name ?? ""
    }
    
    public var unwrappedCompany: String {
        company ?? ""
    }
    
    public var unwrappedEmail: String {
        email ?? ""
    }
    
    public var unwrappedAddress: String {
        address ?? ""
    }
    
    public var unwrappedAbout: String {
        about ?? ""
    }
    
    public var unwrappedRegistered: Date {
        registered ?? Date()
    }
    
    public var unwrappedTags: [String] {
        tags ?? []
    }
    
    public var friendsArray: [Friend]{
        let set = friends as? Set<Friend> ?? []
        return set.sorted { $0.name ?? "" < ($1.name) ?? "" }
    }
    
}

// MARK: Generated accessors for friends
extension User {
    
    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: Friend)
    
    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: Friend)
    
    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)
    
    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)
    
}

extension User : Identifiable {
    
}
