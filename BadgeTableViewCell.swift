//
//  BadgeTableViewCell.swift
//  KioskProjB
//
//  Created by Keenan Grant on 6/22/17.
//  Copyright © 2017 Keenan Grant. All rights reserved.
//

import UIKit

class BadgeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameCell: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
