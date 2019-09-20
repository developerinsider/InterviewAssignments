//
//  UIViewExtension.swift
//  GJAssignment
//
//  Created by Anonymous on 18/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIView {
    func showLoader(show: Bool) {
        if show {
            MBProgressHUD.showAdded(to: self, animated: true)
        } else {
            MBProgressHUD.hide(for: self, animated: true)
        }
    }
}
