//
//  CategoriesTableViewController.swift
//  NykaCosmetics
//
//  Created by Rupika on 2019-06-19.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit
import RealmSwift

struct MyCell {
    
    var cellName = ""
    var isExapnded = false
    var subArray : [String]?
    var isParent = true
    
}

class CategoriesTableViewController: UIViewController {
    
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var alphabetHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var segmentControl : UISegmentedControl!
    
    var catgoriesNames = ["Face","Eyes","Lips","Nails"]
    var brandsNames = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    var faceProducts = ["Foundation","Blush","Bronze"]
    var eyeProducts = ["Eyeshadow","Eyeliner","Eyebrow","Mascara"]
    var lipProducts = ["Lip liner","Lipstick"]
    var NailProducts = ["Nail Polish"]
    var dataSource = [MyCell]()
    
    var makeUpProduct : Results<RLMProduct>?
    var realm : Realm?
    
    
    var sectionDictionary : [String : [String]]?
    var sortedKeys : [String]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //tableView.separatorColor = UIColor.white
        tableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "categoriescell")
        
        alphabetHeightConstraint.constant = 0
        self.view.layoutIfNeeded()
        let font = UIFont.boldSystemFont(ofSize: 16)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: font],
                                              for: .normal)
       
        getDataFromRealm()
        
        //Preparing datasource
        for i in catgoriesNames{
            var s = MyCell()
            s.cellName = i
            s.isExapnded = false
            s.isParent = true
            if i == "Face"{
                 s.subArray = faceProducts
            }
            if i == "Eyes"{
                s.subArray = eyeProducts
            }
            if i == "Lips"{
                s.subArray = lipProducts
            }
            if i == "Nails"{
                s.subArray = NailProducts
            }
            dataSource.append(s)
        }
        print(dataSource)
    }
    
    
    func getDataFromRealm(){
        
        do{
            realm = try Realm()
            makeUpProduct = realm?.objects(RLMProduct.self)
            if let  makeUpProduct = makeUpProduct{
                var  filterSet = Set<String>()
                for product in makeUpProduct{
                    if let brand = product.brand{
                        filterSet.insert(brand)
                    }
                }
                
                var   filteredBrandNames = Array(filterSet)
                filteredBrandNames = filteredBrandNames.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                
                //PReparing dictionary with each alphabet have its own array
                sectionDictionary = [String : [String]]()
                for brandName in filteredBrandNames{
                    let firstChar = String(brandName.first!)
                    if sectionDictionary?[firstChar] == nil{
                        var nameArray = [String]()
                        nameArray.append(brandName)
                        sectionDictionary?[firstChar] = nameArray
                    }else{
                        var nameArray = sectionDictionary?[firstChar]
                        nameArray?.append(brandName)
                        sectionDictionary?[firstChar] = nameArray
                    }
                }
                
                //get keys from dictionary, this is unsorted
                if let unsortedkeys = sectionDictionary?.keys{
                    sortedKeys = Array(unsortedkeys)
                    //Now sort this keys
                    sortedKeys = sortedKeys?.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            
           
        }catch{
            print(error)
        }
    }
    
    @IBAction func segmentButtonClicked(){
        
        if segmentControl.selectedSegmentIndex == 0{
            
            alphabetHeightConstraint.constant = 0
            self.view.layoutIfNeeded()
        }else{
            alphabetHeightConstraint.constant = 105
            self.view.layoutIfNeeded()
        }
        tableView.reloadData()
        
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
extension CategoriesTableViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40)
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 0.48, green: 0.8, blue: 0.79, alpha: 1)
        label.textColor = UIColor.darkGray
        label.font = UIFont(name: "Georgia-Bold", size: 20)!
        // let capitalizedString = label.text?.capitalized
        //        if segmentControl.selectedSegmentIndex == 0{
        //
        //            label.text = catgoriesNames[section]
        //            return label
        //        }
        if segmentControl.selectedSegmentIndex == 1{
            
            label.text = sortedKeys?[section]
            return label
        }
        return UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if segmentControl.selectedSegmentIndex == 0 {
            
            return 1
        }
        if segmentControl.selectedSegmentIndex == 1{
            return sortedKeys?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segmentControl.selectedSegmentIndex == 0{
            
            return dataSource.count
        }
        if segmentControl.selectedSegmentIndex == 1{
            
            if  let alphabet = sortedKeys?[section]{
                if  let nameArray = sectionDictionary?[alphabet]{
                    return nameArray.count
                }
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriescell", for: indexPath) as! CategoriesTableViewCell
        if segmentControl.selectedSegmentIndex == 0{
            
            let s = dataSource[indexPath.row]
            
            if s.isParent == false {
                 cell.categoriesLabel?.text =  "     " + s.cellName
                 cell.arrowImageView?.isHidden = true
                 cell.categoriesLabel?.textColor = UIColor.black
            }else{
                 cell.categoriesLabel?.text = s.cellName
                 cell.categoriesLabel?.textColor = UIColor(red: 0.48, green: 0.8, blue: 0.79, alpha: 1)
            }
          
            return cell
        }
        if segmentControl.selectedSegmentIndex == 1{
            
            if  let alphabet = sortedKeys?[indexPath.section]{
                if  let nameArray = sectionDictionary?[alphabet]{
                    
                    let name = nameArray[indexPath.row]
                    cell.categoriesLabel?.text =  name
                    cell.categoriesLabel?.textColor = UIColor.black
                    return cell
                }
            }
            
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if segmentControl.selectedSegmentIndex == 0{
            applyExpandCollapseLogic(indexPath)
        }
        
        if segmentControl.selectedSegmentIndex == 1{
            //show prodcuts for specific brand
            if  let alphabet = sortedKeys?[indexPath.section]{
                if  let nameArray = sectionDictionary?[alphabet]{
                    let brand = nameArray[indexPath.row]
                    performSegue(withIdentifier: "goToBrand", sender: brand)
                }
            
            }
        }
       
        
    }
    
    func applyExpandCollapseLogic(_ indexPath :  IndexPath){
        var  s = dataSource[indexPath.row]
        
        if s.isExapnded{
            // subrows added, go to detail
            s.isExapnded = false
            dataSource[indexPath.row] = s
            
            if  let subArray = s.subArray{
                dataSource.removeSubrange( indexPath.row + 1...indexPath.row+subArray.count)
                tableView.reloadData()
            }
            
        }else{
            
            s.isExapnded = true
            
            dataSource[indexPath.row] = s
            
            //so ,add sub rows
            var tempArray = [MyCell]()
            if let subArray = s.subArray{
                for i in subArray{
                    var s = MyCell()
                    s.cellName = i
                    s.isExapnded = true
                    s.isParent = false
                    tempArray.append(s)
                }
                
                dataSource.insert(contentsOf: tempArray, at: indexPath.row + 1)
                tableView.reloadData()
            }
        }
        if s.isParent == false{
            //go to brand controller
            /*var faceProducts = ["Foundation","Blush","Bronze"]
             var eyeProducts = ["Eyeshadow","Eyeliner","Eyebrow","Mascara"]
             var lipProducts = ["Lip liner","Lipstick"]
             var NailProducts = ["Nail Polish"]*/
            
            if s.cellName == "Foundation"{
                performSegue(withIdentifier: "goToProducts", sender: "foundation")
            }
            if s.cellName == "Lipstick"{
                performSegue(withIdentifier: "goToProducts", sender: "lipstick")
            }
            if s.cellName == "Blush"{
                performSegue(withIdentifier: "goToProducts", sender: "blush")
            }
            if s.cellName == "Bronze"{
                performSegue(withIdentifier: "goToProducts", sender: "bronzer")
            }
            if s.cellName == "Eyeshadow"{
                performSegue(withIdentifier: "goToProducts", sender: "eyeshadow")
            }
            if s.cellName == "Eyeliner"{
                performSegue(withIdentifier: "goToProducts", sender: "eyeliner")
            }
            if s.cellName == "Eyebrow"{
                performSegue(withIdentifier: "goToProducts", sender: "eyebrow")
            }
            if s.cellName == "Mascara"{
                performSegue(withIdentifier: "goToProducts", sender: "mascara")
            }
            if s.cellName == "Lip liner"{
                performSegue(withIdentifier: "goToProducts", sender: "lip_liner")
            }
            if s.cellName == "Nail Polish"{
                performSegue(withIdentifier: "goToProducts", sender: "nail_polish")
            }
        }
    }
        
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToBrand" {
            let brandsVC = segue.destination as! BrandsViewController
            if sender != nil{
                brandsVC.selectedBrand = sender as? String
                brandsVC.makeUpProduct =  makeUpProduct
            }
        }
        
        if segue.identifier == "goToProducts" {
            let brandsVC = segue.destination as! BrandsViewController
            if sender != nil{
                brandsVC.productType = sender as? String
                brandsVC.makeUpProduct =  makeUpProduct
            }
        }
      
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    
}
extension CategoriesTableViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return brandsNames.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! BrandsCollectionViewCell
        cell.brandsAlphabetLabel.text  = brandsNames[indexPath.row]
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alphabet =  brandsNames[indexPath.row]
        
        print(alphabet)
        
        //get index of this alphabet from sorted kewys, which is used to display headers in the table view
        if let alphabetIndex = sortedKeys?.firstIndex(of: alphabet.lowercased()){
            
            let indexPath = IndexPath(row: 0, section: alphabetIndex)
            tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        }
        
    }
    
}