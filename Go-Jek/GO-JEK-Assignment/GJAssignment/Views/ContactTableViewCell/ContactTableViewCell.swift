//
//  ContactTableViewCell.swift
//  GJAssignment
//
//  Created by Anonymous on 17/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    static let identifier = ContactTableViewCell.name
    static let nib = UINib(nibName: ContactTableViewCell.name, bundle: nil)

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contactImageView.makeCircle()
    }
    
    func config(contact: Contact) {
        let viewModel = ContactViewModel(contact: contact)
        contactName.text = viewModel.name
        contactImageView.image = UIImage.Contact.placeHolder
        favoriteImageView.isHidden = !viewModel.isFavorite
        favoriteImageView.image = viewModel.isFavorite ? UIImage.Contact.showFavorite : nil
    }
}
