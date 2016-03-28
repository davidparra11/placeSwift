//
//  TLineTableViewCell.swift
//  PlaceAp
//
//  Created by david on 3/08/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class TLineTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var postImage: UIImageView!

    
    
    @IBOutlet weak var nombre: UILabel!
    
    @IBOutlet weak var descripcion: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
