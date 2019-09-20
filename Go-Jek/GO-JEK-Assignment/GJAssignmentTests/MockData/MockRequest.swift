//
//  MockRequest.swift
//  GJAssignmentTests
//
//  Created by Anonymous on 18/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import Foundation
@testable import GJAssignment

typealias Completion = (Data?, URLResponse?, Error?) -> Void

enum MockRequest {
    case contacts
    case singlecontact
}

extension MockRequest {
    //Identify request based on endpoint
    static func identifyRequest(request: URLRequest) -> MockRequest? {
        if request.url?.path == "/contacts.json" {
            return contacts
        } else if request.url?.path == "/contacts/1.json" {
            return singlecontact
        }
        return nil
    }
    
    //Return success response
    func completionHandler(request: URLRequest, completion: Completion) {
        guard let method = request.httpMethod, let httpMethod = HTTPMethod(rawValue: method) else {
            fatalError("Unknown HTTPMethod Used.")
        }
        
        switch (self, httpMethod) {
        case (.contacts, .get):
            getContacts(request: request, statusCode: 200, completion: completion)
        case (.contacts, .post):
            postContact(request: request, statusCode: 200, completion: completion)
        case (.singlecontact, .get):
            getContact(request: request, statusCode: 200, completion: completion)
        case (.singlecontact, .put):
            getFavoriteContact(request: request, statusCode: 200, completion: completion)
        case (.singlecontact, .delete):
            getContact(request: request, statusCode: 204, completion: completion)
        default:
            fatalError("Request not handled yet.")
        }
    }
    
    //Return error response
    func badCompletionHandler(request: URLRequest, completion: Completion) {
        guard let method = request.httpMethod, let httpMethod = HTTPMethod(rawValue: method) else {
            fatalError("Unknown HTTPMethod Used.")
        }
        
        switch (self, httpMethod) {
        case (.contacts, .get):
            getBadContacts(request: request, statusCode: 400, completion: completion)
        case (.singlecontact, .get):
            getBadContact(request: request, statusCode: 400, completion: completion)
        default:
            fatalError("Request not handled yet.")
        }
    }
    
    // MARK: - Helper Functions
    private func getContacts(request: URLRequest, statusCode: Int, completion: Completion) {
        let path = Bundle.init(for: MockSession.self).path(forResource: "contacts", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe) else {
            let error = NSError(domain: "No stub data foubt", code: 0, userInfo: nil)
            completion(nil, nil, error)
            return
        }
        
        let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        completion(data, response, nil)
    }
    
    private func getBadContacts(request: URLRequest, statusCode: Int, completion: Completion) {
        let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        completion(nil, response, GJError("Server not reachable."))
    }
    
    private func postContact(request: URLRequest, statusCode: Int, completion: Completion) {
        let path = Bundle.init(for: MockSession.self).path(forResource: "contact", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe) else {
            let error = NSError(domain: "No stub data foubt", code: 0, userInfo: nil)
            completion(nil, nil, error)
            return
        }
        
        let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        completion(data, response, nil)
    }
    
    private func getContact(request: URLRequest, statusCode: Int, completion: Completion) {
        let path = Bundle.init(for: MockSession.self).path(forResource: "contact", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe) else {
            let error = NSError(domain: "No stub data foubt", code: 0, userInfo: nil)
            completion(nil, nil, error)
            return
        }
        
        let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        completion(data, response, nil)
    }
    
    private func getBadContact(request: URLRequest, statusCode: Int, completion: Completion) {
        let path = Bundle.init(for: MockSession.self).path(forResource: "not_found", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe) else {
            let error = NSError(domain: "No stub data foubt", code: 0, userInfo: nil)
            completion(nil, nil, error)
            return
        }
        
        let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        completion(data, response, nil)
    }
    
    private func getFavoriteContact(request: URLRequest, statusCode: Int, completion: Completion) {
        let path = Bundle.init(for: MockSession.self).path(forResource: "fav_contact", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe) else {
            let error = NSError(domain: "No stub data foubt", code: 0, userInfo: nil)
            completion(nil, nil, error)
            return
        }
        
        let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        completion(data, response, nil)
    }
}
