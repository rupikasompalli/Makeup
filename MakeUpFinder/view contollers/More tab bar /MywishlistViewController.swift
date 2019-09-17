//
//  MywishlistViewController.swift
//  NykaCosmetics
//
//  Created by Rupika on 2019-07-29.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit

class MywishlistViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet var tableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         tableView.register(UINib(nibName: "MywishlistTableViewCell", bundle: nil), forCellReuseIdentifier: "wishlist")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WishListManager.shared.wishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wishlist", for: indexPath) as! MywishlistTableViewCell
        
        let prod = WishListManager.shared.wishList[indexPath.row]
        //show cell itmes
        cell.productLabel?.text = prod.name
        cell.productPrice?.text = prod.price
        if let url = URL(string: prod.image_link  ??  ""){
            cell.productImage?.downloaded(from: url)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
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
