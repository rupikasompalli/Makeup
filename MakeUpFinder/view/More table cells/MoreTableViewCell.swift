//
//  MoreTableViewCell.swift
//  NykaCosmetics
//
//  Created by Rupika on 2019-07-22.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit

class MoreTableViewCell: UITableViewCell {

    @IBOutlet var displayImageView : UIImageView!
    @IBOutlet var displayLabel : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
