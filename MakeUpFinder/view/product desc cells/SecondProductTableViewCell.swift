//
//  SecondProductTableViewCell.swift
//  MakeUpFinder
//
//  Created by Rupika on 2019-07-16.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit

protocol SecondProductTableViewCellDelegate {
   
    func rightButtonClicked()
    func leftButtonClicked()
}

class SecondProductTableViewCell: UITableViewCell {
    
    @IBOutlet var leftButton : UIButton!
    @IBOutlet var rightButton : UIButton!
    var delegate : SecondProductTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func leftButtonClicked(){
        self.delegate?.leftButtonClicked()
    }
    @IBAction func rightButtonClicked(){
        self.delegate?.rightButtonClicked()
    }
    
}
