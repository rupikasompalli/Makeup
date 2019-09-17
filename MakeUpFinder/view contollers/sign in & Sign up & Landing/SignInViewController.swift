//
//  SignInViewController.swift
//  MakeUpFinder
//
//  Created by Rupika on 2019-06-18.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet var username : UITextField!
    @IBOutlet var password : UITextField!
    @IBOutlet var signInBUtton : UIButton!
     let defaults = UserDefaults.standard
    
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
      
        performEmptyValidation()
        checkPasswordContainSixCharecter(textField: password)
        if checkIfFieldIsEmpty(textField: username) == true || checkIfFieldIsEmpty(textField: password) == true {
            if let savedUsername = defaults.string(forKey: "username") {
                if let savedPassword = defaults.string(forKey: "password"){
                    
                    print("defaults savedString: \(savedUsername)")
                    print("defaults savedString: \(savedPassword)")
                    performSegue(withIdentifier: "gotohomescreen", sender: nil)
                }
            }
        }
}
func performEmptyValidation(){
        
        //check if fields are empty or not
        
   if checkIfFieldIsEmpty(textField: username) == true  || checkIfFieldIsEmpty(textField: password) == true  {
            //show alert
            let alert = UIAlertController(title: "enter some text", message: alertEmptyMessage(), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func alertEmptyMessage() -> String{
        
        var message = ""
        if checkIfFieldIsEmpty(textField: username) == true{
            message.append("Email field is empty")
            message.append(",")
        }
        
        if checkIfFieldIsEmpty(textField: password) == true{
            message.append("Password field is empty")
            message.append(",")
        }
        return message
    }
    func checkIfFieldIsEmpty(textField: UITextField) -> Bool{
        
        var textFieldIsEmpty: Bool = true
        
        if let textinPAssedTextField = textField.text{
            if textinPAssedTextField.count > 0{
                textFieldIsEmpty = false
            }
        }
        return textFieldIsEmpty
 }
    //check password contain six character
    func checkPasswordContainSixCharecter(textField: UITextField) -> Bool{
        let passwordNoteMached :Bool = true
        if (password.text?.count)! > 6 {
            
            let alert = UIAlertController(title: "password not matched ", message: "password should be in six alphanumeric", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        return passwordNoteMached
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //to move UIview up when keyboard pop up so that the tetx field and button won't hide under keyboard we have to set delegate methods.
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y - 200, width:self.view.frame.size.width, height:self.view.frame.size.height);
            
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y + 200, width:self.view.frame.size.width, height:self.view.frame.size.height);
            
        })
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("textFieldShouldReturn")
        textField.resignFirstResponder()
        return true
    }
}
