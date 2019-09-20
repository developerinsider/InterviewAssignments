//
//  ContactViewController.swift
//  GJAssignment
//
//  Created by Anonymous on 16/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import UIKit
import CoreData

class ContactListViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var contactTableView: UITableView!
    
    // MARK: - Private Properties
    private let viewModel = ContactListViewModel()
    var fetchedResultController: NSFetchedResultsController<Contact>?
    
    // MARK: - Class Functions
    class func get() -> ContactListViewController {
        let contactViewController = ContactListViewController(nibName: ContactListViewController.name, bundle: nil)
        return contactViewController
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        
        contactTableView.delegate = self
        contactTableView.dataSource = self
        contactTableView.tableFooterView = UIView(frame: CGRect.zero)
        contactTableView.register(ContactTableViewCell.nib, forCellReuseIdentifier: ContactTableViewCell.identifier)
        contactTableView.accessibilityIdentifier = "contactListTableView"
        
        setupNavigationBarButtonItems()
        setupFetchedResultController()
        setupBindingAndGetContacts()
    }
    
    // MARK: - Helper Functions
    private func setupNavigationBarButtonItems() {
        let groupsBarButtonItem = UIBarButtonItem(title: viewModel.groupBarButtonTitle,
                                                  style: .plain,
                                                  target: self,
                                                  action: nil)
        navigationItem.leftBarButtonItem = groupsBarButtonItem
        
        let addContactBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                      target: self,
                                                      action: #selector(addContactBarButtonItemAction))
        navigationItem.rightBarButtonItem = addContactBarButtonItem
    }
    
    private func setupFetchedResultController() {
        let contactsFetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Contact.firstName),
                                              ascending: true,
                                              selector: #selector(NSString.caseInsensitiveCompare(_:)))
        contactsFetchRequest.sortDescriptors = [sortDescriptor]
        let managedObjectContext = CoreDataManager.shared.managedObjectContext
        fetchedResultController = .init(fetchRequest: contactsFetchRequest,
                                        managedObjectContext: managedObjectContext,
                                        sectionNameKeyPath: #keyPath(Contact.sectionTitle),
                                        cacheName: nil)
        fetchedResultController?.delegate = self
    }
    
    private func performFetchRequest() {
        do {
            try fetchedResultController?.performFetch()
            contactTableView.reloadData()
        } catch {
            Log.error("Unable to perform fetch operation from DB.", error: error)
        }
    }
    
    private func setupBindingAndGetContacts() {
        //Binding
        viewModel.isBusy.bind { [unowned self] isBusy in
            self.view.showLoader(show: isBusy)
        }
        
        viewModel.contacts.bind { [unowned self] (contacts) in
            if contacts != nil {
                self.performFetchRequest()
            }
        }
        
        viewModel.error.bind { [unowned self] (error) in
            if let error = error {
                self.performFetchRequest()
                UIAlertController.show(error.localizedDescription, from: self)
            }
        }
        
        //Get Contacts
        viewModel.getContacts()
    }
    
    @objc private func addContactBarButtonItemAction() {
        AddContactViewController.present(contact: nil)
    }
}
