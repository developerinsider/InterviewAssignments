//
//  ContactDetailsViewModel.swift
//  GJAssignment
//
//  Created by Anonymous on 17/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import Foundation

class ContactDetailsViewModel {
    private var httpClient: HTTPClient!

    let editBarButtonTitle = NSLocalizedString("Edit", comment: "")
    
    var contact: Bindable<Contact>!
    var isBusy: Bindable<Bool> = Bindable(false)
    var error: Bindable<GJError?> = Bindable(nil)
    
    // MARK: - Computed Properties
    var contactMetadata: [ContactMetadata] {
        return contact.value.getDetailsMetadata()
    }
    
    var name: String {
        return contact.value.fullName
    }
    
    var imageURL: URL? {
        return URL(string: contact.value.profilePic ?? "")
    }
    
    var isFavorite: Bool {
        return contact.value.favorite
    }
    
    var telURL: URL? {
        if let phone = contact.value.phoneNumber {
            return URL(string: String(format: "tel://%@", phone))
        }
        return nil
    }
    
    var messageURL: URL? {
        if let phone = contact.value.phoneNumber {
            return URL(string: String(format: "sms://%@", phone))
        }
        return nil
    }
    
    var mailURL: URL? {
        if let email = contact.value.email {
            return URL(string: String(format: "mailto://%@", email))
        }
        return nil
    }
    
    init(contact: Contact, client: HTTPClient? = nil) {
        self.contact = Bindable(contact)
        self.httpClient = client ?? HTTPClient.shared
    }
    
    func getContactDetails() {
        isBusy.value = true
        httpClient.dataTask(ContactAPI.getContact(id: Int(contact.value.id))) { [weak self] (result) in
            guard let self = self else {
                return
            }
            
            self.isBusy.value = false
            switch result {
            case .success(let data):
                guard let data = data else {
                    return
                }
                
                do {
                    let contact = try JSONDecoder().decode(Contact.self, from: data)
                    CoreDataManager.shared.saveContext()
                    self.contact.value = contact
                } catch {
                    Log.error("Unable to decode Contact.", error: error)
                }
            case .failure(let error):
                self.error.value = GJError(error.localizedDescription)
                Log.error("Error in fetching Contact.", error: error)
            }
        }
    }
    
    func updateFavourite() {
        contact.value.favorite = !contact.value.favorite
        let contactRequest = ContactAPI.updateContact(id: Int(contact.value.id), contact: contact.value)
        isBusy.value = true
        httpClient.dataTask(contactRequest) { [weak self] (result) in
            guard let self = self else {
                return
            }
            
            self.isBusy.value = false
            switch result {
            case .success(let data):
                guard let data = data else {
                    return
                }
                
                do {
                    let contact = try JSONDecoder().decode(Contact.self, from: data)
                    CoreDataManager.shared.saveContext()
                    self.contact.value = contact
                } catch {
                    Log.error("Unable to decode Contact.", error: error)
                }
            case .failure(let error):
                self.error.value = GJError(error.localizedDescription)
                self.contact.value.favorite = !self.contact.value.favorite
                Log.error("Error in updating Contact.", error: error)
            }
        }
    }
}
