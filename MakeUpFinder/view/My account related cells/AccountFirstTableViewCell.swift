//
//  AccountFirstTableViewCell.swift
//  MakeUpFinder
//
//  Created by Rupika on 2019-07-22.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit
//protocol AccountFirstTableViewCellDelegate {
//    }

class AccountFirstTableViewCell: UITableViewCell,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
   
    

    @IBOutlet var profileImageView : UIImageView!
    @IBOutlet var editNameTextField : UITextField!
    @IBOutlet var editBirthDayTextField : UITextField!
    @IBOutlet var editProfileButton : UIButton!
    @IBOutlet var editGenderTextField : UITextField!{
        didSet{
            editGenderTextField.delegate = self
        }
    }
    var myPickerView : UIPickerView!
    var pickerData = ["Female","Male"]
   
    //for picker image
    
    var picker = UIImagePickerController();
    var viewController: UIViewController?
  
    //var delegate : AccountFirstTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        roundProfileImage()
    }
    func roundProfileImage(){
        profileImageView.layer.borderWidth = 1.0
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func editTextButtonClicked(){
        editNameTextField.isUserInteractionEnabled = true
        editNameTextField.becomeFirstResponder()
    }
    @IBAction func editDateButtonClicked(){
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(updateDateField(sender:)), for: .valueChanged)
        editBirthDayTextField .inputView = picker
    }
    //for update date picker
    @objc func updateDateField(sender: UIDatePicker) {
        editBirthDayTextField.text = formatDateForDisplay(date: sender.date)
    }
    func formatDateForDisplay(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
    
    @IBAction func editGenderButtonClicked(){
        self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: 375, height: 216))
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = UIColor.white
        editGenderTextField.inputView = self.myPickerView
        editGenderTextField.resignFirstResponder()
    }
    @IBAction func editProfileButtonClicked(){
        pickImage()
    }
   
    //for picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.editGenderTextField.text = pickerData[row]
    }
    
    //to make intial one picker as male
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.editGenderTextField.text = pickerData[0]
    }
    
    //for image picker
    func pickImage() {

        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
         }
        
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        viewController?.present(alert, animated: true, completion: nil)
    }
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            self.viewController!.present(picker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "warning", message: "You don't have camera", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.viewController?.present(alert, animated: true, completion: nil)
        }
    }
    func openGallery(){
        picker.sourceType = .photoLibrary
        self.viewController!.present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
 //after u select the image, didFinishPicking method will get called
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
       //to load the image from gallery to image view.
      profileImageView.image = image
    }
    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
    }

}

