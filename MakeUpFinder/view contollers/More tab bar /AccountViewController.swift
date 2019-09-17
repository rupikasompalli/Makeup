//
//  AccountViewController.swift
//  NykaCosmetics
//
//  Created by Rupika on 2019-07-22.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    

    @IBOutlet var tableView : UITableView!
    @IBOutlet var saveButton : UIButton!
    var displayAccount = ["Change Password","Log out"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "AccountFirstTableViewCell", bundle: nil), forCellReuseIdentifier: "firstcell")
        tableView.register(UINib(nibName: "SecondTableViewCell", bundle: nil), forCellReuseIdentifier: "secondaccount")
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor(red: 0.48, green: 0.8, blue: 0.79, alpha: 1)
        self.navigationItem.title = "My Account"
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstcell", for: indexPath) as! AccountFirstTableViewCell
            // tableView.separatorStyle = .none
            cell.viewController = self
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondaccount", for: indexPath) as! SecondTableViewCell
            //becox indexpath.row stars from 0 so we have are taking displayAccount[indexPath.row-1]
            cell.accountLabel?.text = displayAccount[indexPath.row-1]
           //  tableView.separatorStyle = .singleLine
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 370
        }
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //for change password
        if indexPath.row == 1{
            performSegue(withIdentifier: "changepassword", sender: indexPath.row)
        }
        if indexPath.row == 2 {
            //for log out
            //navigationController?.popToRootViewController(animated: true)
            if let vc = navigationController!.viewControllers.filter({ $0 is LandingViewController }).first {
                navigationController!.popToViewController(vc, animated: true)
            }
        }
    }
    @IBAction func saveButtonClicked(){
        
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

