//
//  BrandsTableViewCell.swift
//  NykaCosmetics
//
//  Created by Rupika on 2019-07-07.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit

class BrandsTableViewCell: UITableViewCell {
    
    @IBOutlet var productImage : UIImageView!
    @IBOutlet var priceLabel : UILabel!
    @IBOutlet var productName : UILabel!
    @IBOutlet var heartButton : UIButton!
    @IBOutlet var heartView : UIView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        heartView.layer.borderWidth = 1
        heartView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
//    }
    
}
