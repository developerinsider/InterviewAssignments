//
//  ContactEditTableViewHeader.swift
//  GJAssignment
//
//  Created by Anonymous on 18/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import UIKit

protocol ContactEditTableViewHeaderDelegate: class {
    func takeImageButtonAction(_ sender: UIButton)
}

class ContactEditTableViewHeader: UIView {
    @IBOutlet weak var imageView: CircularImageView!
    @IBOutlet weak var takeImageButton: UIButton!
    
    weak var delegate: ContactEditTableViewHeaderDelegate?
    
    class func get(image: UIImage = UIImage.Contact.placeHolder) -> ContactEditTableViewHeader {
        guard let view = Bundle.main.loadNibNamed(ContactEditTableViewHeader.name,
                                                  owner: nil, options: nil)?
            .first as? ContactEditTableViewHeader else {
            fatalError("Unable to load nib ContactEditTableViewHeader.")
        }
        view.imageView.image = image
        return view
    }
    
    @IBAction func takeImageButtonAction(_ sender: UIButton) {
        delegate?.takeImageButtonAction(sender)
    }
}
