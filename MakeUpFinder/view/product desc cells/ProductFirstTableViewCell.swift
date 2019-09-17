//
//  ProductFirstTableViewCell.swift
//  MakeUpFinder
//
//  Created by Rupika on 2019-07-15.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit
import RealmSwift

class ProductFirstTableViewCell: UITableViewCell {
    
    @IBOutlet var collectionView : UICollectionView!
    @IBOutlet var priceLabel : UILabel!
    @IBOutlet var productImage : UIImageView!
    @IBOutlet var productLabel : UILabel!
    
    // declaring varaible to acess reference
    var selectedProduct : RLMProduct?
    //collection view outlet

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //collection view register
        let nib = UINib(nibName: "ColorViewCell", bundle: nil)
         collectionView.register(nib, forCellWithReuseIdentifier: "colorcell")
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension ProductFirstTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return selectedProduct?.product_colors.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorcell", for: indexPath) as! ColorViewCell
        let selectedShade = selectedProduct?.product_colors[indexPath.row]
        let hexValue = selectedShade?.hex_value
        if let hexColor = hexValue{
             cell.shadesView.backgroundColor = UIColor(hexString: hexColor)
        }
       
        return cell
    }
    
    
}

extension UIColor {
    convenience init?(hexString: String) {
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        let red, green, blue, alpha: CGFloat
        switch chars.count {
        case 3:
            chars = chars.flatMap { [$0, $0] }
            fallthrough
        case 6:
            chars = ["F","F"] + chars
            fallthrough
        case 8:
            alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
            red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
            blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            return nil
        }
        self.init(red: red, green: green, blue:  blue, alpha: alpha)
    }
}
