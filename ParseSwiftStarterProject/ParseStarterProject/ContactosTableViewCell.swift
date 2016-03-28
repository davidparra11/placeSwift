//
//  ContactosTableViewCell.swift
//  PlaceAp
//
//  Created by david on 10/08/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class ContactosTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nombreAmigo: UILabel!

    @IBOutlet weak var imagenAmigo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
