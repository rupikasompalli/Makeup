//
//  ProductsCollectionViewCell.swift
//  MakeUpFinder
//
//  Created by Rupika on 2019-07-07.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit

protocol  ProductsCollectionViewCellDelegate {
    func addCartButton(_ indexPath : IndexPath)
    func addHeartButton(_ indexPath : IndexPath)
}

class ProductsCollectionViewCell: UICollectionViewCell {

    @IBOutlet var productImageForColl : UIImageView!
    @IBOutlet var priceLabelForColl : UILabel!
    @IBOutlet var productNameForColl : UILabel!
     @IBOutlet var heartViewForColl : UIView!
    @IBOutlet var heartButton : UIButton!
     var cellIndexPath : IndexPath?
     var delegate : ProductsCollectionViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        heartViewForColl.layer.borderWidth = 1
        heartViewForColl.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
    }
    @IBAction func addCartButton(){
        if let cellIndex = cellIndexPath{
            self.delegate?.addCartButton(cellIndex)
        }
        
    }
    @IBAction func addHeartButton(){
        if let cellIndex = cellIndexPath{
            self.delegate?.addHeartButton(cellIndex)
       }
    }
}
