//
//  ContactDetailsViewControllerExtension.swift
//  GJAssignment
//
//  Created by Anonymous on 17/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import Foundation
import UIKit

extension ContactDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contactMetadata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactDetailsTableViewCell.identifier,
                                                       for: indexPath) as? ContactDetailsTableViewCell else {
            fatalError("Unable to dequeue ContactDetailsTableViewCell cell.")
        }
        cell.config(metaData: viewModel.contactMetadata[indexPath.row])
        cell.accessibilityIdentifier = String(format: "detailsTableViewCell_%ld", indexPath.row)
        return cell
    }
}

extension ContactDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

extension ContactDetailsViewController: AddContactViewControllerDelegate {
    func contactSyncSuccessfully(contact: Contact) {
        viewModel.contact.value = contact
    }
}
