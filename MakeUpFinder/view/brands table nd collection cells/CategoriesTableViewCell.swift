//
//  CategoriesTableViewCell.swift
//  NykaCosmetics
//
//  Created by Rupika on 2019-06-19.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    @IBOutlet var categoriesLabel : UILabel!
    @IBOutlet var arrowImageView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
