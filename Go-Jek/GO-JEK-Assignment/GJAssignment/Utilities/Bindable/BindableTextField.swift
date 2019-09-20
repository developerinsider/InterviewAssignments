//
//  BindableTextField.swift
//  GJAssignment
//
//  Created by Anonymous on 18/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import Foundation
import UIKit

class BindableTextField: UITextField {
    typealias Listener = (String) -> Void
    var textChanged: Listener = { _ in }
    
    func bind(listener: @escaping Listener) {
        self.textChanged = listener
        self.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        self.textChanged(textField.text!)
    }
}
