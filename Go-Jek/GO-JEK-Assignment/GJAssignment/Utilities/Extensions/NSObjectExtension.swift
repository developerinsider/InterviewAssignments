//
//  NSObjectExtension.swift
//  GJAssignment
//
//  Created by Anonymous on 16/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import Foundation

extension NSObject {
    class var name: String {
        return String(describing: self)
    }
}
