//
//  ContactEditTableViewCell.swift
//  GJAssignment
//
//  Created by Anonymous on 17/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import UIKit

protocol ContactEditTableViewCellDelegate: class {
    func textChanged(contactMetaData: ContactMetadata, text: String)
}

class ContactEditTableViewCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var infoTextField: BindableTextField! {
        didSet {
            infoTextField.bind {[weak self] in
                guard let self = self else {
                    return
                }
                self.delegate?.textChanged(contactMetaData: self.contactMetadata, text: $0)
            }
        }
    }
    
    var contactMetadata: ContactMetadata!
    weak var delegate: ContactEditTableViewCellDelegate?
    
    static let identifier = ContactEditTableViewCell.name
    static let nib = UINib(nibName: ContactEditTableViewCell.name, bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(metaData: ContactMetadata) {
        contactMetadata = metaData
        descLabel.text = metaData.desc
        infoTextField.text = metaData.info
        infoTextField.keyboardType = metaData.keyboardType
    }
}
