//
//  ContactsCell.swift
//  Contacts
//
//  Created by Anusha Patil on 17/03/2016.
//  Copyright © 2016 Anusha Patil. All rights reserved.
//

import UIKit

class ContactsCell: UITableViewCell {

    @IBOutlet weak var contactsImageView: UIImageView!
    @IBOutlet weak var contactsNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
