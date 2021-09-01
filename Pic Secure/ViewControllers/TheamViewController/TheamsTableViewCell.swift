//
//  TheamsTableViewCell.swift
//  Pic Secure
//
//  Created by Talha Ghous on 2/6/18.
//  Copyright © 2018 Talha Ghous. All rights reserved.
//

import UIKit

class TheamsTableViewCell: UITableViewCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorNameLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
