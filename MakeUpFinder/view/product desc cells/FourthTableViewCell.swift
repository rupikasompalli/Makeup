//
//  FourthTableViewCell.swift
//  NykaCosmetics
//
//  Created by Rupika on 2019-07-17.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit
protocol FourthTableViewCellDelegate {
    
    func ratingButtonClicked(senderTag : Int)
   
}

class FourthTableViewCell: UITableViewCell {

    var delegate : FourthTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func ratingButtonClicked(sender : UIButton){
        
        self.delegate?.ratingButtonClicked(senderTag: sender.tag)
     }
    @IBAction func readAllReviewButtonClicked(){
        
    }
}
