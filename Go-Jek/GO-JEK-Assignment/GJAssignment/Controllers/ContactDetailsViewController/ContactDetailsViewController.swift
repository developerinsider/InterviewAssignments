//
//  ContactDetailsViewController.swift
//  GJAssignment
//
//  Created by Anonymous on 17/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var favouriteImageView: UIImageView!
    
    // MARK: - Private Properties
    private var navigationBarShadowImage: UIImage?
    
    // MARK: - Internal Properties
    var viewModel: ContactDetailsViewModel!
    
    // MARK: - Class Functions
    class func get(contact: Contact) -> ContactDetailsViewController {
        let detailsViewController = ContactDetailsViewController(nibName: ContactDetailsViewController.name, bundle: nil)
        detailsViewController.viewModel = ContactDetailsViewModel(contact: contact)
        return detailsViewController
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupBindingAndGetContact()
        setupNavigationBarButtonItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.shadowImage = navigationBarShadowImage
    }
    
    // MARK: - Helper Functions
    private func setupNavigationBarButtonItems() {
        //Store original shadow image
        navigationBarShadowImage = navigationController?.navigationBar.shadowImage
        
        //set edit contact bar button item
        let editBarButtonItem = UIBarButtonItem(title: viewModel?.editBarButtonTitle,
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(editBarButtonItemAction))
        navigationItem.rightBarButtonItem = editBarButtonItem
    }
    
    private func setupTableView() {
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.tableFooterView = UIView(frame: CGRect.zero)
        detailsTableView.register(ContactDetailsTableViewCell.nib, forCellReuseIdentifier: ContactDetailsTableViewCell.identifier)
        detailsTableView.accessibilityIdentifier = "detailsTableView"
    }
    
    private func setupBindingAndGetContact() {
        //Binding
        viewModel.isBusy.bind { [unowned self] isBusy in
            self.navigationController?.view.showLoader(show: isBusy)
        }
        
        viewModel.contact.bind(listener: {[unowned self] (_) in
            let isFavorite = self.viewModel?.isFavorite ?? false
            let image = isFavorite ? UIImage.Action.favoriteSelected : UIImage.Action.favorite
            self.favouriteImageView.image = image
            
            self.userImageView.image = UIImage.Contact.placeHolder
            self.userName.text = self.viewModel?.name
            self.detailsTableView.reloadData()
        })
        
        viewModel.error.bind { [unowned self] (error) in
            if let error = error {
                UIAlertController.show(error.localizedDescription, from: self)
            }
        }
        
        viewModel.getContactDetails()
    }
    
    // MARK: - Actions
    @objc private func editBarButtonItemAction() {
        AddContactViewController.present(contact: viewModel.contact.value, delegate: self)
    }
    
    @IBAction func messageTapGestureAction(_ sender: UITapGestureRecognizer) {
        guard  let messageURL = viewModel.messageURL else {
            UIAlertController.show("Contact number not valid.", from: self)
            return
        }
        UIApplication.shared.open(messageURL, options: [:], completionHandler: nil)
    }
    
    @IBAction func callTapGestureAction(_ sender: UITapGestureRecognizer) {
        guard  let telURL = viewModel.telURL else {
            UIAlertController.show("Contact number not valid.", from: self)
            return
        }
        UIApplication.shared.open(telURL, options: [:], completionHandler: nil)
    }
    
    @IBAction func emailTapGestureAction(_ sender: UITapGestureRecognizer) {
        guard  let mailURL = viewModel.mailURL else {
            UIAlertController.show("Contact email not valid.", from: self)
            return
        }
        UIApplication.shared.open(mailURL, options: [:], completionHandler: nil)
    }
    
    @IBAction func favouriteTapGestureAction(_ sender: UITapGestureRecognizer) {
        if sender.state == .recognized {
            viewModel.updateFavourite()
        }
    }
}
