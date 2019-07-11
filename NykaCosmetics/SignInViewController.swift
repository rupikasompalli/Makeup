//
//  SignInViewController.swift
//  NykaCosmetics
//
//  Created by Rupika on 2019-06-18.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet var username : UITextField!
    @IBOutlet var password : UITextField!
    @IBOutlet var signInBUtton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.navigationController?.isNavigationBarHidden = true
      //  self.navigationController?.setNavigationBarHidden(true, animated: false)
        customizeTextField()
        customizeSignInButton()
        
        
    }
    func customizeTextField(){
        
        let myColor : UIColor =  UIColor(red: 0.48, green: 0.8, blue: 0.79, alpha: 1)
        username.layer.borderColor = myColor.cgColor
        username.layer.borderWidth = 3.0
        //username.backgroundColor = UIColor(red: 0.48, green: 0.8, blue: 0.79, alpha: 1)
        username.layer.cornerRadius = 15
        //username.layer.masksToBounds = true
        username.clipsToBounds = true
        password.layer.borderColor = myColor.cgColor
        password.layer.borderWidth = 3.0
        //password.backgroundColor = UIColor(red: 0.48, green: 0.8, blue: 0.79, alpha: 1)
        password.layer.cornerRadius = 15
       // password.layer.masksToBounds = true
        password.clipsToBounds = true
    }
    func customizeSignInButton(){
        
        signInBUtton.titleLabel?.font = UIFont(name: "K2D-Regular", size: 18)
        signInBUtton.backgroundColor = UIColor(red: 0.48, green: 0.8, blue: 0.79, alpha: 1)
        signInBUtton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        signInBUtton.layer.shadowOffset = CGSize(width: 0, height: 4)
        signInBUtton.layer.shadowOpacity = 1.0
        signInBUtton.layer.shadowRadius = 4.0
        signInBUtton.layer.cornerRadius = 10
    }
    @IBAction func signInButtonClicked(){
        performSegue(withIdentifier: "gotohomescreen", sender: nil)
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
