//
//  MockSession.swift
//  GJAssignmentTests
//
//  Created by Anonymous on 18/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import Foundation
@testable import GJAssignment

//MokeSession or Good MockSession always return success response
class MockSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        
        if let mockRequest =  MockRequest.identifyRequest(request: request) {
            mockRequest.completionHandler(request: request, completion: completionHandler)
        }
        
        return MockDataTask()
    }
}
