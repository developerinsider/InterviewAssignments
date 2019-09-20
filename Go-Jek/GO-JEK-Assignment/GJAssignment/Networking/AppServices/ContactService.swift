//
//  ContactService.swift
//  GJAssignment
//
//  Created by Anonymous on 17/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import Foundation

//Contact APIs
enum ContactAPI {
    case getContacts
    case getContact(id: Int)
    case deleteContact(id: Int)
    case addContact(contact: Contact)
    case updateContact(id: Int, contact: Contact)
}

extension ContactAPI: RequestProtocol {
    //Set Base URL
    var baseURL: URL {
        guard let url = URL(string: Constants.Service.baseURL) else {
            fatalError("BaseURL could not be configured.")
        }
        return url
    }
    
    //Returns EndPoint for Contact APIs
    var path: String {
        switch self {
        case .getContacts, .addContact:
            return "contacts.json"
        case .getContact(let id), .deleteContact(let id), .updateContact(let id, _):
            return "contacts/\(String(describing: id)).json"
        }
    }
    
    //Returns HTTP Method for contact APIs
    var httpMethod: HTTPMethod {
        switch self {
        case .getContacts, .getContact:
            return .get
        case .addContact:
            return .post
        case .updateContact:
            return .put
        case .deleteContact:
            return .delete
        }
    }
    
    //Encode and Returns Encoded Data
    var httpBody: Data? {
        switch self {
        case .addContact(let contact), .updateContact(_, let contact):
            do {
                return try JSONEncoder().encode(contact)
            } catch {
                Log.error("Unable to encode Contact.", error: error)
            }
        default:
            return nil
        }
        return nil
    }
    
    //Return Contact APIs Specific Headers
    var headers: HTTPHeaders? {
        return nil
    }
}
