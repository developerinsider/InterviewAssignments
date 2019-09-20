//
//  ContactDetailsTableViewCell.swift
//  GJAssignment
//
//  Created by Anonymous on 17/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import UIKit

class ContactDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    static let identifier = ContactDetailsTableViewCell.name
    static let nib = UINib(nibName: ContactDetailsTableViewCell.name, bundle: nil)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(metaData: ContactMetadata) {
        descLabel.text = metaData.desc
        infoLabel.text = metaData.info
    }
    
}
