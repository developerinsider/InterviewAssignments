//
//  AddContactViewController.swift
//  GJAssignment
//
//  Created by Anonymous on 18/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import UIKit

protocol AddContactViewControllerDelegate: class {
    func contactSyncSuccessfully(contact: Contact)
}

class AddContactViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var contactImageView: CircularImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var contactTableView: UITableView!
    
    // MARK: - Weak Properties and Delgate
    weak var tableViewHeader: ContactEditTableViewHeader!
    weak var delegate: AddContactViewControllerDelegate?
    
    // MARK: - Internal Properties
    var imagePicker: ImagePicker!
    
    // MARK: - Properties
    var viewModel: AddContactViewModel!
    
    // MARK: - Class Functions
    class func present(contact: Contact?, delegate: AddContactViewControllerDelegate? = nil) {
        let addContactViewController = AddContactViewController(nibName: AddContactViewController.name, bundle: nil)
        addContactViewController.delegate = delegate
        addContactViewController.viewModel = AddContactViewModel(contact: contact)
        let navigationController = UINavigationController(rootViewController: addContactViewController)
        UIApplication.shared.keyWindow?.rootViewController?.present(
            navigationController, animated: true, completion: nil)
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupImagePicker()
        setupBindingAndGetContact()
        setupNavigationBarButtonItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 150)
        contactTableView.tableHeaderView?.frame = frame
    }
    
    // MARK: - Helper Functions
    private func setupNavigationBarButtonItems() {
        navigationController?.navigationBar.shadowImage = UIImage()
        
        //set cancel and done bar button item
        let cancelBarButtonItem = UIBarButtonItem(title: viewModel?.cancelBarButtonTitle,
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(cancelBarButtonItemAction))
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        
        let doneBarButtonItem = UIBarButtonItem(title: viewModel?.doneBarButtonTitle,
                                                style: .done,
                                                target: self,
                                                action: #selector(doneBarButtonItemAction))
        navigationItem.rightBarButtonItem = doneBarButtonItem
    }
    
    private func setupTableView() {
        contactTableView.delegate = self
        contactTableView.dataSource = self
        contactTableView.tableFooterView = UIView(frame: CGRect.zero)
        contactTableView.register(ContactEditTableViewCell.nib, forCellReuseIdentifier: ContactEditTableViewCell.identifier)
        contactTableView.accessibilityIdentifier = "addContactTableView"
        
        tableViewHeader = ContactEditTableViewHeader.get()
        tableViewHeader.delegate = self
        contactTableView.tableHeaderView = tableViewHeader
    }
    
    private func setupImagePicker() {
        imagePicker = ImagePicker(from: self)
        imagePicker.delegate = self
    }
    
    private func setupBindingAndGetContact() {
        //Binding
        viewModel.isBusy.bind { [unowned self] isBusy in
            self.navigationController?.view.showLoader(show: isBusy)
        }
        
        viewModel.isContactSync.bind { [unowned self] (isSync) in
            if isSync {
                self.delegate?.contactSyncSuccessfully(contact: self.viewModel.contact.value)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        viewModel.contact.bind(listener: {[unowned self] (_) in
            self.contactTableView.reloadData()
        })
        
        viewModel.error.bind { [unowned self] (error) in
            if let error = error {
                UIAlertController.show(error.localizedDescription, from: self)
            }
        }
    }
    
    @objc private func cancelBarButtonItemAction() {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func doneBarButtonItemAction() {
        view.endEditing(true)
        viewModel.syncContact()
    }
}
