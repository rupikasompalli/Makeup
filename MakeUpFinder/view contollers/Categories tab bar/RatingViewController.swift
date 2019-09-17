//
//  RatingViewController.swift
//  MakeUpFinder
//
//  Created by Rupika on 2019-07-20.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController{

    @IBOutlet var writeCommentTextView : UITextView!
    @IBOutlet var starFirstButton : UIButton!
    @IBOutlet var starSecondButton : UIButton!
    @IBOutlet var starThirdButton : UIButton!
    @IBOutlet var starFourthButton : UIButton!
    @IBOutlet var starFifthButton : UIButton!
    var selectedStarTag : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        writeCommentTextView.textColor = UIColor.lightGray

        // Do any additional setup after loading the view.
        if selectedStarTag == 1{
           let img = UIImage(named: "filledstar")
             starFirstButton.setImage(img, for: .normal)
        }
        if selectedStarTag == 2{
            let img = UIImage(named: "filledstar")
            starFirstButton.setImage(img, for: .normal)
            starSecondButton.setImage(img, for: .normal)
        }
        if selectedStarTag == 3{
            let img = UIImage(named: "filledstar")
            starFirstButton.setImage(img, for: .normal)
            starSecondButton.setImage(img, for: .normal)
            starThirdButton.setImage(img, for: .normal)
        }
        if selectedStarTag == 4{
            let img = UIImage(named: "filledstar")
            starFirstButton.setImage(img, for: .normal)
            starSecondButton.setImage(img, for: .normal)
            starThirdButton.setImage(img, for: .normal)
            starFourthButton.setImage(img, for: .normal)
           
        }
        if selectedStarTag == 5{
            let img = UIImage(named: "filledstar")
            starFirstButton.setImage(img, for: .normal)
            starSecondButton.setImage(img, for: .normal)
            starThirdButton.setImage(img, for: .normal)
            starFourthButton.setImage(img, for: .normal)
            starFifthButton.setImage(img, for: .normal)
        }
        
        
    }
    @IBAction func submitBUttonClicked(){
        
    }
    @IBAction func cancelButtonClicked(){
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func backButtonClicked(){
         dismiss(animated: true, completion: nil)
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


