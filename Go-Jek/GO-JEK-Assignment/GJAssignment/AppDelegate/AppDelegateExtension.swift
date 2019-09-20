//
//  AppDelegateExtension.swift
//  GJAssignment
//
//  Created by Anonymous on 17/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {
    func setupNavigationBarAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.Common.tint
    }
    
    func getRootViewController() -> UIViewController {
        let contactViewController = ContactListViewController.get()
        let rootNavigationController = UINavigationController(rootViewController: contactViewController)
        return rootNavigationController
    }
}
