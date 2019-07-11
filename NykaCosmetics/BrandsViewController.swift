//
//  BrandsViewController.swift
//  NykaCosmetics
//
//  Created by Rupika on 2019-07-02.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit
import RealmSwift

class BrandsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    @IBOutlet var tableView : UITableView!
    @IBOutlet var collectionView : UICollectionView!
    @IBOutlet var squareButton : UIButton!
     var link = "https://makeup-api.herokuapp.com/api/v1/products.json"
     var makeUpProduct : Results<RLMProduct>?
     var filteredBrands : Results<RLMProduct>?
     var realm : Realm?
     var selectedBrand : String?
     var productType : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "BrandsTableViewCell", bundle: nil), forCellReuseIdentifier: "brandscell")
        tableView.dataSource = nil
        collectionView.dataSource = nil
        collectionView.isHidden = true
        tableView.isHidden = false
        tableView.backgroundColor = .clear
        
        do{
            realm = try Realm()
            
            //Filter the data based on the brand selected
            if let selectedBrand = selectedBrand{
                let predicate = NSPredicate(format: "brand == %@", selectedBrand)
                filteredBrands = makeUpProduct?.filter(predicate)
            }
            
            if let productType = productType{
                let predicate = NSPredicate(format: "prod_type == %@", productType)
                filteredBrands = makeUpProduct?.filter(predicate)
            }
          
            DispatchQueue.main.async {
                self.tableView.dataSource = self
                self.collectionView.dataSource = self
                self.tableView.reloadData()
                self.collectionView.reloadData()
            }
            
            
        }catch{
            print(error)
        }
        
       
        
    }
  @IBAction  func squareButtonClicked(){
        if  tableView.isHidden == true{
            tableView.isHidden = false
            collectionView.isHidden = true
           } else if tableView.isHidden == false{
            tableView.isHidden = true
            collectionView.isHidden = false
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.filteredBrands?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "brandscell", for: indexPath) as! BrandsTableViewCell
        if let brands = filteredBrands{
            let product = brands[indexPath.section]
            cell.productName?.text = product.name
             cell.priceLabel?.text = product.price
            if let url = URL(string: product.image_link  ??  ""){
                cell.productImage?.downloaded(from: url)
            }
        }
       
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
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
extension BrandsViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredBrands?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! ProductsCollectionViewCell
        
        if let brands = filteredBrands{
            let product = brands[indexPath.section]
            cell.productNameForColl?.text = product.name
            cell.priceLabelForColl?.text = product.price
            if let url = URL(string: product.image_link  ??  ""){
                cell.productImageForColl?.downloaded(from: url)
            }
        }
       
        return cell
    }
    
    //to reduce spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (self.collectionView.frame.size.width - 15)/2
        let height = width + 70
        return CGSize(width: width, height: height)
    }
    
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleToFill) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
