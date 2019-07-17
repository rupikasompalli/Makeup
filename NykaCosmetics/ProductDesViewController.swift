//
//  ProductDesViewController.swift
//  NykaCosmetics
//
//  Created by Rupika on 2019-07-15.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit
import RealmSwift

class ProductDesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet var tableView : UITableView!
    var selectedProduct : RLMProduct?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "ProductFirstTableViewCell", bundle: nil), forCellReuseIdentifier: "firstcell")
        tableView.register(UINib(nibName : "SecondProductTableViewCell",bundle: nil), forCellReuseIdentifier: "secondcell")
        tableView.register(UINib(nibName: "ThirdProductTableViewCell", bundle: nil), forCellReuseIdentifier: "thirdcell")
        tableView.register(UINib(nibName: "FourthTableViewCell", bundle: nil), forCellReuseIdentifier: "fourthcell")
        tableView.separatorStyle = .none
        tableView.reloadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
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
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondcell", for: indexPath) as! SecondProductTableViewCell
            return cell
        }
        if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "thirdcell", for: indexPath) as! ThirdProductTableViewCell
            cell.productDescription.text = selectedProduct?.prod_description
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "fourthcell", for: indexPath) as! FourthTableViewCell
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            
            return 10
        }
        return 20
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
           
            return 480
        }
        if indexPath.section == 1{
           
            return 60
        }
        if indexPath.section == 3{
          
            return 450
        }
        return UITableView.automaticDimension
       
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
