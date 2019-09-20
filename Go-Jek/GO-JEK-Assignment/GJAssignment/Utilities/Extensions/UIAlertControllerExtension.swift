//
//  UIAlertViewController.swift
//  GJAssignment
//
//  Created by Anonymous on 18/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    static func show(_ message: String, from viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
