//
//  AddContactViewControllerExtension.swift
//  GJAssignment
//
//  Created by Anonymous on 18/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import Foundation

import UIKit

extension AddContactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contactMetadata?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactEditTableViewCell.identifier,
                                                       for: indexPath) as? ContactEditTableViewCell else {
                                                        fatalError("Unable to dequeue ContactDetailsTableViewCell cell.")
        }
        cell.delegate = self
        cell.accessibilityIdentifier = String(format: "editTableViewCell_%ld", indexPath.row)
        cell.config(metaData: viewModel!.contactMetadata[indexPath.row])
        return cell
    }
}

extension AddContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

extension AddContactViewController: ContactEditTableViewHeaderDelegate {
    func takeImageButtonAction(_ sender: UIButton) {
        imagePicker.showImagePickerSources(sender: sender)
    }
}

extension AddContactViewController: ImagePickerDelegate {
    func didFinishPickingImage(_ image: UIImage?) {
        tableViewHeader.imageView.image = image
    }
}

extension AddContactViewController: ContactEditTableViewCellDelegate {
    func textChanged(contactMetaData: ContactMetadata, text: String) {
        contactMetaData.info = text
        switch contactMetaData.type {
        case .firstName:
            viewModel.contact.value.firstName = text
        case .lastName:
            viewModel.contact.value.lastName = text
        case .email:
            viewModel.contact.value.email = text
        case .mobile:
            viewModel.contact.value.phoneNumber = text
        }
    }
}
