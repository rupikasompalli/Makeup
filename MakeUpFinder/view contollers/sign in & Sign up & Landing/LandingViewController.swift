//
//  LandingViewController.swift
//  NykaCosmetics
//
//  Created by Rupika on 2019-06-17.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit
import RealmSwift

class LandingViewController: UIViewController {
    
    @IBOutlet var signInBUtton : UIButton!
    @IBOutlet var signUpBUtton : UIButton!
    var realm : Realm?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadDatabase()

        // Do any additional setup after loading the view.
        
 }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        buttonProperties()
       
    }
    func buttonProperties(){
        signInBUtton.titleLabel?.font = UIFont(name: "K2D-Regular", size: 18)
        signInBUtton.backgroundColor = UIColor(red: 0.48, green: 0.8, blue: 0.79, alpha: 1)
        signInBUtton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        signInBUtton.layer.shadowOffset = CGSize(width: 0, height: 4)
        signInBUtton.layer.shadowOpacity = 1.0
        signInBUtton.layer.shadowRadius = 4.0
        signInBUtton.layer.cornerRadius = 10
        signUpBUtton.titleLabel?.font = UIFont(name: "K2D-Regular", size: 18)
        signUpBUtton.backgroundColor = UIColor(red: 0.76, green: 0.75, blue: 0.43, alpha: 1)
        signUpBUtton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        signUpBUtton.layer.shadowOffset = CGSize(width: 0, height: 4)
        signUpBUtton.layer.shadowOpacity = 1.0
        signUpBUtton.layer.shadowRadius = 4.0
        signUpBUtton.layer.cornerRadius = 10
    }
  
    @IBAction func signInBUttonClicked(){
        performSegue(withIdentifier: "gotosigninscreen", sender: nil)
    }
    @IBAction func signUpButtonClicked(){
        performSegue(withIdentifier: "signup", sender: nil)
    }
    
    //loading data into database
    func loadDatabase(){
        
        do{
            realm = try Realm()
            print(realm!.configuration.fileURL?.absoluteString ?? "")
            
        }catch{
            print(error)
        }
        
        if UserDefaults.standard.value(forKey: "dataloaded") == nil{
            
            UserDefaults.standard.set(true, forKey: "dataloaded")
            
            if let url = URL(string: "https://makeup-api.herokuapp.com/api/v1/products.json") {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    
                    do{
                        if let data = data{
                            guard let products = try? JSONDecoder().decode([Product].self, from: data) else {
                                return
                            }
                            
                            DispatchQueue.main.async {
                                
                                do{
                                    for product in products{
                                        try self.realm!.write {
                                            let realmProduct = RLMProduct()
                                            realmProduct.product_id = product.product_id
                                            realmProduct.name = product.name
                                            realmProduct.brand = product.brand
                                            realmProduct.price = product.price
                                            realmProduct.price_sign = product.price_sign
                                            realmProduct.currency = product.currency
                                            realmProduct.image_link = product.image_link
                                            realmProduct.product_link = product.product_link
                                            realmProduct.website_link = product.website_link
                                            realmProduct.prod_description = product.prod_description
                                            realmProduct.rating = String(product.rating ?? 0)
                                            realmProduct.category = product.category
                                            realmProduct.prod_type = product.prod_type
                                            
                                            if let colors = product.product_colors{
                                                for prod_color in colors{
                                                    let realmProductcolor = RLMProductColor()
                                                    realmProductcolor.hex_value = prod_color.hex_value
                                                    realmProductcolor.color_name = prod_color.color_name
                                                    realmProduct.product_colors.append(realmProductcolor)
                                                }
                                            }
                                            
                                            if let tags = product.tagList{
                                                for tag in tags{
                                                    realmProduct.tagList.append(tag)
                                                }
                                            }
                                            
                                            realmProduct.favourite = false
                                            
                                            self.realm!.add(realmProduct)
                                        }
                                    }
                                }catch{
                                    
                                }
                                
                            }
                            
                            
                        }
                    }catch{
                        print(error)
                    }
                    
                    }.resume()
            }
        }
        
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
