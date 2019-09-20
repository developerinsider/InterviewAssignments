//
//  ServerError.swift
//  GJAssignment
//
//  Created by Anonymous on 18/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import Foundation

struct ServerError: Decodable {
    let status: String?
    let error: String?
}
