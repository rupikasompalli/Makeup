//
//  MoreViewController.swift
//  NykaCosmetics
//
//  Created by Rupika on 2019-07-22.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tableView : UITableView!
    var tableLabel = ["My Account","My Wishlist","My Wallet","Help Center"]
     var tableImage : [UIImage] = [UIImage(named: "account")!,UIImage(named: "greenstar")!,UIImage(named: "wallet")!,UIImage(named: "help")!]
    
    func addNavigationBarItems(){
        let rightBarBtn = BadgedButtonItem(with:  UIImage(named: "shopping-cart"))
        rightBarBtn.badgeTintColor = UIColor(red:0.40, green:0.58, blue:0.62, alpha:1.0)
        rightBarBtn.tintColor = UIColor(red:0.40, green:0.58, blue:0.62, alpha:1.0)
        
        let rightBarBtn2 = UIBarButtonItem(image: UIImage(named: "notifications-button"), style: .plain, target: self, action: #selector(HomeViewController.rightBarButtonClicked))
        
        rightBarBtn2.tintColor = UIColor(red:0.40, green:0.58, blue:0.62, alpha:1.0)
        self.navigationItem.rightBarButtonItems = [rightBarBtn, rightBarBtn2]
         self.navigationItem.title = "Menu"
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addNavigationBarItems()
        tableView.register(UINib(nibName: "MoreTableViewCell", bundle:nil), forCellReuseIdentifier: "more")
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell = tableView.dequeueReusableCell(withIdentifier: "more", for: indexPath) as! MoreTableViewCell
            cell.displayLabel?.text = tableLabel[indexPath.row]
            cell.displayImageView?.image = tableImage[indexPath.row]
            return cell
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            performSegue(withIdentifier: "account", sender: indexPath.row)
        }
        if indexPath.row == 1{
             performSegue(withIdentifier: "wishlistcontroller", sender: indexPath.row)
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return 50
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
