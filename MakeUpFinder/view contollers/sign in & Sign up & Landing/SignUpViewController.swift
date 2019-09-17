//
//  SignUpViewController.swift
//  MakeUpFinder
//
//  Created by Rupika on 2019-07-31.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var emailId : UITextField!
    @IBOutlet var password : UITextField!
    @IBOutlet var username : UITextField!
    @IBOutlet var mobileNumber : UITextField!
    @IBOutlet var passwordLabel : UILabel!
    @IBOutlet var userNameLabel : UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)

        // Do any additional setup after loading the view.
       passwordLabel.isHidden = true
        userNameLabel.isHidden = true
    }
    
    @IBAction func registerButtonClicked(){
        self.view.endEditing(true)
       performEmptyValidation()
        //to check email is valid and to check password contain alpha numericals and also to check password contains only 6 alphanumerics.
        
        if isValidEmail(testStr: emailId.text!) == true && password.text?.isAlphanumeric == true && checkPasswordContainSixCharecter(textField: password) == true && isValidMobileNo(testmob: mobileNumber.text!){
            
            //After clicking login button if everthing valid it go to home page.
            
            let alert = UIAlertController(title: "you have sucessfully created account", message: "ThankQ for joining with us.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { _ in
                
                self.navigationController?.popViewController(animated: true)
                
            }))
            // Restyle the view of the Alert
            alert.view.tintColor = UIColor.brown  // change text color of the buttons
            alert.view.backgroundColor =  UIColor(red: 217/255, green: 134/255, blue: 64/255, alpha: 1.0) // change background color
            alert.view.layer.cornerRadius = 25   // change corner radius
            self.present(alert, animated: true, completion: nil)
            
           }
        //to save
        let defaults = UserDefaults.standard
        
        // Save String value to UserDefaults
        // Using defaults.set(value: Any?, forKey: String)
        defaults.set(emailId.text, forKey: "email")
        defaults.set(password.text, forKey: "password")
        defaults.set(username.text, forKey: "username")
    }
    func performEmptyValidation(){
        
        //check if fields are empty or not
        
        if checkIfFieldIsEmpty(textField: emailId) == true || checkIfFieldIsEmpty(textField: password) == true  || checkIfFieldIsEmpty(textField: username) == true || checkIfFieldIsEmpty(textField: mobileNumber) == true  {
            //show alert
            let alert = UIAlertController(title: "enter some text", message: alertEmptyMessage(), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func alertEmptyMessage() -> String{
        
        var message = ""
        if checkIfFieldIsEmpty(textField: emailId) == true{
            message.append("Email field is empty")
            message.append(",")
        }
        
        if checkIfFieldIsEmpty(textField: password) == true{
            message.append("Password field is empty")
            message.append(",")
        }
        if checkIfFieldIsEmpty(textField: username) == true{
            message.append("username field is empty")
            message.append(",")
        }
        if checkIfFieldIsEmpty(textField: mobileNumber) == true{
            message.append("mobile number field is empty")
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
    
    // To check whether the email is valid.
    
    func isValidEmail(testStr:String) -> Bool {
        
        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
        
    }
    // to check valid mobile no
    func  isValidMobileNo(testmob : String)->Bool {
        let PHONE_REGEX = "^[7-9][0-9]{9}$";
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: testmob)
        return result
    }

    //to check passswrod contain eight alpha numeric
    func checkPasswordContainSixCharecter(textField: UITextField) -> Bool{
       let passwordNoteMached :Bool = true
        if (password.text?.count)! > 6 {
            
            let alert = UIAlertController(title: "password not matched ", message: "password should be in six alphanumeric", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        return passwordNoteMached
    }
   
    //to move UIview up when keyboard pop up so that the tetx field and button won't hide under keyboard we have to set delegate methods.
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        UIView.animate(withDuration: 0.3, animations: {
//            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y - 200, width:self.view.frame.size.width, height:self.view.frame.size.height);
//
//        })
        if textField == password{
             passwordLabel.isHidden = false
        }
        if textField == username{
              userNameLabel.isHidden = false
        }
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        UIView.animate(withDuration: 0.3, animations: {
//            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y + 200, width:self.view.frame.size.width, height:self.view.frame.size.height);
//
//        })
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("textFieldShouldReturn")
        textField.resignFirstResponder()
        return true
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
// To check whether password contain alphanumeric.
extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}
