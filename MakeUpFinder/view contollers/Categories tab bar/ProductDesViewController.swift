//
//  ProductDesViewController.swift
//  MakeUpFinder
//
//  Created by Rupika on 2019-07-15.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit
import RealmSwift

class ProductDesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet var tableView : UITableView!
    var selectedProduct : RLMProduct?
    @IBOutlet var displayView : UIView!
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var secondLabel : UILabel!
    @IBOutlet var easyreturnImage : UIImageView!
    @IBOutlet var gotItButton : UIButton!
     var realm : Realm?
    var cartCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.navigationController?.setNavigationBarHidden(false, animated: true)
        
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "ProductFirstTableViewCell", bundle: nil), forCellReuseIdentifier: "firstcell")
        tableView.register(UINib(nibName : "SecondProductTableViewCell",bundle: nil), forCellReuseIdentifier: "secondcell")
        tableView.register(UINib(nibName: "ThirdProductTableViewCell", bundle: nil), forCellReuseIdentifier: "thirdcell")
        tableView.register(UINib(nibName: "FourthTableViewCell", bundle: nil), forCellReuseIdentifier: "fourthcell")
        tableView.separatorStyle = .none
        tableView.reloadData()
        displayView.isHidden = true
        //to enable navigation button for cart
        //This need to be replaced with the pod
        let rightBarBtn = BadgedButtonItem(with:  UIImage(named: "shopping-cart"))
        rightBarBtn.badgeTintColor = UIColor(red:0.40, green:0.58, blue:0.62, alpha:1.0)
        rightBarBtn.badgeSize = .large
        rightBarBtn.tintColor = UIColor(red:0.40, green:0.58, blue:0.62, alpha:1.0)
        self.navigationItem.rightBarButtonItem = rightBarBtn
        do{
            realm = try Realm()
            
        }catch{
            
        }
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: false)
         self.navigationController?.setNavigationBarHidden(false, animated: false)
         self.navigationController?.navigationItem.hidesBackButton = false
    }
    
   //related to view on which 100% authentic and easy returns button clicked
    @IBAction func okGoItButtonClicked(){
        displayView.isHidden = true
    }
    
    
    
    //table view related functions.
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstcell", for: indexPath) as! ProductFirstTableViewCell
            let selectedValue = selectedProduct?.name
            cell.productLabel.text = selectedValue
            let selectedImage = selectedProduct?.image_link
            if let url = URL(string: selectedImage  ??  ""){
          cell.productImage?.downloaded(from: url)
            }
            let selectedPrice = selectedProduct?.price
            cell.priceLabel.text = selectedPrice
            if let selectedColor = selectedProduct{
                cell.selectedProduct = selectedColor
            }
           
             return cell
            }
        if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondcell", for: indexPath) as! SecondProductTableViewCell
            cell.delegate = self
            return cell
        }
        if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "thirdcell", for: indexPath) as! ThirdProductTableViewCell
            cell.productDescription.text = selectedProduct?.prod_description
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "fourthcell", for: indexPath) as! FourthTableViewCell
        cell.delegate = self
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            
            return 10
        }
        return 20
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
           
            return 480
        }
        if indexPath.row == 1{
           
            return 60
        }
        if indexPath.row == 3{
          
            return 620
        }
        return UITableView.automaticDimension
       
    }
    
    // to diaplay tablefooterview in footer section.
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let myView = Bundle.main.loadNibNamed("TableFooterView", owner: nil,options: nil)?.first as! TableFooterVIew
      // myView.layer.borderWidth = 1
        myView.layer.cornerRadius = 10
        myView.backgroundColor = UIColor.clear
        myView.layer.shadowColor = UIColor.black.cgColor
        myView.layer.shadowOffset = CGSize(width: 0, height: 2)
        myView.layer.shadowOpacity = 0.5
        myView.layer.shadowRadius = 2.0
       // myView.layer.borderColor = UIColor.lightGray.cgColor
        myView.heartView.layer.borderWidth = 1
        myView.heartView.layer.borderColor = UIColor.lightGray.cgColor
        myView.delegate = self
        if selectedProduct?.favourite == true{
           myView.heartButton.setImage(UIImage(named: "filledheart"), for: .normal)
        }
        else{
           myView.heartButton.setImage(UIImage(named: "unfilledheart"), for: .normal)
        }
    return myView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProductDesViewController : SecondProductTableViewCellDelegate{
   
    func leftButtonClicked() {
        displayView.isHidden = false
        titleLabel.text = "100% Authentic"
        secondLabel.text = "All Cosmetics Products are 100% authentic and purchased directly from Cosmetics."
        }
    func rightButtonClicked() {
        displayView.isHidden = false
        titleLabel.text = "Easy Return Policy"
        secondLabel.text = "Products can be returned within 5 days of delivery products are eligible for returns only in their original package and in a sealed condition. Opened or used products will not be accepted as retruns."
       easyreturnImage.image = UIImage(named: "100")
    }
}

//for rating clciked in fourth cell
extension ProductDesViewController: FourthTableViewCellDelegate{
    
    
    func ratingButtonClicked(senderTag: Int) {
        //using story board id we are presenting view controller.
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ratingVC") as! RatingViewController
        vc.selectedStarTag = senderTag
        
        self.present(vc, animated: true, completion: nil)
        
    }
}

//to add to cart which is in the table footer view we are using protocol delegate.

extension ProductDesViewController : TableFooterVIewDelegate {
   
    func addToCartButtonClicked(){
            if  let rightBtn = self.navigationItem.rightBarButtonItem as? BadgedButtonItem{
                cartCount += 1
                rightBtn.setBadge(with: cartCount)
            }
        }
        
   func addToHeartButtonClicked(){
            
            //get indexoath of the button clicked
            
            if let favourite = selectedProduct{
                let product = favourite
                //Add this to wish list arr
                let manager = WishListManager.shared
                var productAlreadyAdded = false
                var addedProductIndex = 0
                for (index,productTemp) in manager.wishList.enumerated(){
                    if  productTemp.name == product.name{
                        productAlreadyAdded = true
                        addedProductIndex = index
                        break
                    }
                }
                
                if productAlreadyAdded{
                    manager.wishList.remove(at: addedProductIndex)
                }else{
                    manager.wishList.append(product)
                }
                do{
                    try realm?.write{
                        product.favourite = !(product.favourite)
                    }
                }catch{
                    
                }
            }
      }
}

