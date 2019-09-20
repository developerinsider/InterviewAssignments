//
//  Contact+CoreDataProperties.swift
//  GJAssignment
//
//  Created by Anonymous on 17/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Contact)
public class Contact: NSManagedObject, Codable {
    @NSManaged public var id: Int64
    @NSManaged public var lastName: String?
    @NSManaged public var firstName: String?
    @NSManaged public var profilePic: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var email: String?
    @NSManaged public var phoneNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case id, favorite, email
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
        case phoneNumber = "phone_number"
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let contactId = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        let firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        let lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        let profilePic = try container.decodeIfPresent(String.self, forKey: .profilePic)
        let favorite = try container.decodeIfPresent(Bool.self, forKey: .favorite) ?? false
        let phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber)
        let email = try container.decodeIfPresent(String.self, forKey: .email)
        
        let managedObjectContext = CoreDataManager.shared.managedObjectContext
        guard let entity = NSEntityDescription.entity(forEntityName: Contact.name, in: managedObjectContext) else {
            fatalError("Failed to decode Contact")
        }
        self.init(entity: entity, insertInto: nil)
        self.id = Int64(contactId)
        self.firstName = firstName
        self.lastName = lastName
        self.profilePic = profilePic
        self.favorite = favorite
        self.phoneNumber = phoneNumber
        self.email = email
        
        if let entity = Contact.getContact(id: contactId) {
            entity.firstName = firstName
            entity.lastName = lastName
            entity.profilePic = profilePic
            entity.favorite = favorite
            entity.phoneNumber = phoneNumber
            entity.email = email
        } else {
            managedObjectContext.insert(self)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        //try container.encode(profilePic, forKey: .profilePic)
        try container.encode(favorite, forKey: .favorite)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(email, forKey: .email)
    }
}
