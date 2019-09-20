//
//  ContactListViewControllerExtension.swift
//  GJAssignment
//
//  Created by Anonymous on 17/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// MARK: - NSFetchResultController Delegate
extension ContactListViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        contactTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            contactTableView.insertRows(at: [newIndexPath!], with: .none)
        case .delete:
            contactTableView.deleteRows(at: [indexPath!], with: .none)
        case .update:
            contactTableView.reloadRows(at: [indexPath!], with: .none)
        case .move:
            contactTableView.moveRow(at: indexPath!, to: newIndexPath!)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            contactTableView.insertSections(IndexSet(integer: sectionIndex), with: .none)
        case .delete:
            contactTableView.deleteSections(IndexSet(integer: sectionIndex), with: .none)
        case .update:
            contactTableView.reloadSections(IndexSet(integer: sectionIndex), with: .none)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        contactTableView.endUpdates()
    }
    
}

// MARK: - UITableView Data Source
extension ContactListViewController: UITableViewDataSource {    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultController?.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController?.sections?[section].objects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier,
                                                       for: indexPath) as? ContactTableViewCell else {
            fatalError("Unable to dequeue ContactTableViewCell.")
        }
        cell.config(contact: fetchedResultController!.object(at: indexPath))
        cell.accessibilityIdentifier = String(format: "contactTableViewCell_%ld_%ld", indexPath.section, indexPath.row)
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return fetchedResultController?.sectionIndexTitles
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fetchedResultController?.sections?[section].indexTitle
    }
}

extension ContactListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = fetchedResultController!.object(at: indexPath)
        let contactDetailsViewController = ContactDetailsViewController.get(contact: contact)
        navigationController?.pushViewController(contactDetailsViewController, animated: true)
    }
}
