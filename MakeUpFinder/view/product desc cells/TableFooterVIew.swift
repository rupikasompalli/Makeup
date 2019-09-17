//
//  TableFooterVIew.swift
//  NykaCosmetics
//
//  Created by Rupika on 2019-07-18.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit
protocol  TableFooterVIewDelegate {
    func addToCartButtonClicked()
    func addToHeartButtonClicked()
}

class TableFooterVIew: UIView {

    @IBOutlet var mainView : UIView!
    @IBOutlet var addToCartButton : UIButton!
    @IBOutlet var favouriteHeart : UIButton!
    @IBOutlet var heartView : UIView!
    @IBOutlet var heartButton : UIButton!
    var delegate : TableFooterVIewDelegate?
    
   

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func addToCartButtonClicked(){
      
            self.delegate?.addToCartButtonClicked()
        
    }
    @IBAction func addToHeartButtonClicked(){
        
       // heartButton.isSelected = !heartButton.isSelected
        
        if heartButton.isSelected == false{
            heartButton.isSelected = true
        }else{
            heartButton.isSelected = false
        }
         self.delegate?.addToHeartButtonClicked()
        if heartButton.isSelected == true{
            heartButton.setImage(UIImage(named: "filledheart"), for: .normal)
        }
        else{
            heartButton.setImage(UIImage(named: "unfilledheart"), for: .normal)
        }
    }

}
