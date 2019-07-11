//
//  HomeViewController.swift
//  NykaCosmetics
//
//  Created by Rupika on 2019-06-18.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var searchBar : UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //for creating right buttons dynamically
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let rightBarBtn = UIBarButtonItem(image: UIImage(named: "shopping-cart"), style: .plain, target: self, action: #selector(HomeViewController.rightBarButtonClicked))
        rightBarBtn.tintColor = UIColor(red:0.40, green:0.58, blue:0.62, alpha:1.0)
         let rightBarBtn2 = UIBarButtonItem(image: UIImage(named: "notifications-button"), style: .plain, target: self, action: #selector(HomeViewController.rightBarButtonClicked))
         rightBarBtn2.tintColor = UIColor(red:0.40, green:0.58, blue:0.62, alpha:1.0)
        tabBarController?.navigationItem.rightBarButtonItems = [rightBarBtn, rightBarBtn2]
        tabBarController?.navigationItem.setHidesBackButton(true, animated:true);
        //for displaying placeholder tetx color for search bar
        let searchTextField: UITextField? = searchBar.value(forKey: "searchField") as? UITextField
        if searchTextField!.responds(to: #selector(getter: UITextField.attributedPlaceholder))
        {
        let attributeDict = [NSAttributedString.Key.foregroundColor: UIColor(red:0.40, green:0.58, blue:0.62, alpha:1.0)]
        searchTextField!.attributedPlaceholder = NSAttributedString(string: "Search for items", attributes: attributeDict)
        }
    }
    
    @objc func rightBarButtonClicked(){
        
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
