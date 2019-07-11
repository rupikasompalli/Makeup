//
//  ViewController.swift
//  NykaCosmetics
//
//  Created by Rupika on 2019-06-13.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func faceBookButtonClicked(){
        let alert = UIAlertController(title: "\"Cosmetics Wants\" To Use \"Facebok.com\" to Sign In", message: "This allows the app and website to share information about you", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func googlePlusBUttonClicked(){
        let alert = UIAlertController(title: "\"Cosmetics Wants\" To Use \"google.com\" to Sign In", message: "This allows the app and website to share information about you", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

