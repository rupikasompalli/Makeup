//
//  MywishlistTableViewCell.swift
//  NykaCosmetics
//
//  Created by Rupika on 2019-07-29.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit

class MywishlistTableViewCell: UITableViewCell {

    @IBOutlet var productImage : UIImageView?
    @IBOutlet var productLabel : UILabel?
    @IBOutlet var productPrice : UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
