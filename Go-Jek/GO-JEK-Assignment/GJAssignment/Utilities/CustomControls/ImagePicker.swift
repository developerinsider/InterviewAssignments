//
//  ImagePicker.swift
//  GJAssignment
//
//  Created by Anonymous on 18/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import Foundation
import UIKit

protocol ImagePickerDelegate: class {
    func didFinishPickingImage(_ image: UIImage?)
}

class ImagePicker: NSObject {
    weak var viewController: UIViewController!
    let imagePickerController = UIImagePickerController()
    weak var delegate: ImagePickerDelegate?
    
    init(from viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showImagePickerSources(sender: UIView) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.openImagePickerController(source: .camera)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openImagePickerController(source: .photoLibrary)
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender
            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func openImagePickerController(source: UIImagePickerController.SourceType) {
        imagePickerController.delegate = self
        imagePickerController.sourceType = source
        imagePickerController.allowsEditing = true
        viewController.present(imagePickerController, animated: true, completion: nil)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            delegate?.didFinishPickingImage(image)
        } else {
            delegate?.didFinishPickingImage(nil)
        }
        imagePickerController.dismiss(animated: true, completion: nil)
    }
}
