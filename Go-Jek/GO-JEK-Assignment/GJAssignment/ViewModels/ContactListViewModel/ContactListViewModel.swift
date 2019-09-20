//
//  ContactListViewModel.swift
//  GJAssignment
//
//  Created by Anonymous on 17/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import Foundation

class ContactListViewModel {
    
    private var httpClient: HTTPClient!
    
    let title = NSLocalizedString("Contact", comment: "")
    let groupBarButtonTitle = NSLocalizedString("Groups", comment: "")
    
    var isBusy: Bindable<Bool> = Bindable(false)
    var contacts: Bindable<[Contact]?> = Bindable(nil)
    var error: Bindable<GJError?> = Bindable(nil)
    
    init(client: HTTPClient? = nil) {
        self.httpClient = client ?? HTTPClient.shared
    }
    
    func getContacts() {
        isBusy.value = true
        httpClient.dataTask(ContactAPI.getContacts) { [weak self] (result) in
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
                    Contact.deleteAllContacts()
                    let contacts = try JSONDecoder().decode([Contact].self, from: data)
                    CoreDataManager.shared.saveContext()
                    self.contacts.value = contacts
                    Log.info("Contact sync successfully.")
                } catch {
                    Log.error("Unable to decode Contact List", error: error)
                }
            case .failure(let error):
                self.error.value = GJError(error.localizedDescription)
                Log.error("Error in fetching Contacts", error: error)
            }
        }
    }
}
