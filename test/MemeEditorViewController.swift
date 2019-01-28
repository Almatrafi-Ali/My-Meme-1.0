//
//  ViewController.swift
//  test
//
//  Created by Ali Fahad on 01/03/1440 AH.
//  Copyright © 1440 Ali Fahad. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate { // UITextFieldDelegate


    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var top: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var navegationBarrr: UINavigationBar!
    
    var activeField: UITextField? // to hold which text is active
    var defultTopText = "TOP"
    var defultBottomText = "BOTTOM"
    
    func configure(textfield: UITextField,text:String){
        
        let memeTextAttributes:[NSAttributedString.Key : Any] = [
            NSAttributedString.Key.strokeColor:UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth: -1] // -5
        
            textfield.text = text
        textfield.defaultTextAttributes = memeTextAttributes
        textfield.textAlignment = .center

        textfield.delegate = self // will apply text fild func bellow
    }
    
    
    @IBOutlet var x :UILabel!
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
        // if there's an image in the imageView, enable the share button
        if let _ = imagePickerView.image {
            shareButton.isEnabled = true
        } else {
            shareButton.isEnabled = false
        }
        
        //  Hide Navigation Controller and Tab Bar Controller 
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
    
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    //keyboard
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShowNotification(_:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHideNotification(_:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    func unsubscribeFromKeyboardNotifications() {

NotificationCenter.default.removeObserver(self,name:UIResponder.keyboardDidShowNotification, object: nil)
        
  NotificationCenter.default.removeObserver(self,name:UIResponder.keyboardDidShowNotification, object: nil)
                                                }

    @objc func keyboardDidShowNotification (_ notification:Notification) {
        if activeField!.tag == 1 {
            view.frame.origin.y =  -getKeyboardHeight(notification as Notification)
        } else {
            view.frame.origin.y = 0
        }
        
    }

    // MARK: Move the keyboard up when the bottom textfield is tapped
    @objc func keyboardWillShow(_ notification:Notification) {
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    // MARK: Move view down when keyboard is dismissed
    
    @objc func keyboardDidHideNotification(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera) // disaple camera button when needed
       
        configure(textfield: top, text: "TOP")
        configure(textfield: bottomText, text: "BOTTOM")

        top.delegate = self
        bottomText.delegate = self
    }

    
    func setText(textFeild: UITextField, string:String) {
        textFeild.text = string
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        //pick image from Photos Album using method
        presentImagePickerWith(sourceType: UIImagePickerController.SourceType.photoLibrary)
    }
    
    //reusable method
    func presentImagePickerWith(sourceType: UIImagePickerController.SourceType){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        self.present(imagePicker, animated: true, completion:nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == defultTopText || textField.text == defultBottomText {
            textField.text = ""
            
        }
        activeField = textField
    }
 
    
    //When a user presses return, the keyboard will dismissed  اشتغلت
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.top.resignFirstResponder()
        self.bottomText.resignFirstResponder()
    
        return true
    }
    
    func generateMemedImage() -> UIImage {
        
        // to hide both bars before generating Meme img
        configureToolBar(hideElements: true)
        
        // ريندر للفيو
        UIGraphicsBeginImageContext(self.imagePickerView.frame.size)
        //Use of unresolved identifier 'self'
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates:
            true)
        //Use of unresolved identifier 'self'
        let memedImage:UIImage =
            UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        configureToolBar(hideElements: false)
        return memedImage
    }

   
    func configureToolBar(hideElements: Bool) {
        
        navegationBarrr.isHidden = hideElements
        toolBar.isHidden = hideElements
    }
    
    func save(_ memeImage: UIImage) {
        // Creates the meme
        let meme = Meme(topText: top.text!, bottomText:bottomText.text!, originalImage: imagePickerView.image!, memedImage:memeImage)
        

        // Add it to the memes array in the Application Delegate اضافة المي مي الي مصفوفة
        (UIApplication.shared.delegate as!
            AppDelegate).memes.append(meme)
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input:
        UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }
    

    @IBAction func cancelButton(_ sender: Any) {
        imagePickerView.image = nil
        top.text = defultTopText
        bottomText.text = defultBottomText
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func cameraButton(_ sender: Any) {
        //  take an image directly from camera
        presentImagePickerWith(sourceType: UIImagePickerController.SourceType.camera)
    }
    
    
    @IBAction func share(_ sender: Any) {
        let memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error:Error?)
            in
            // user has complete activity
            if completed {
                self.save(memedImage)

                //Dismiss the shareActivityViewController
                self.dismiss(animated: true, completion: nil)
    
                //Unwind to SentMemeTableView
                self.navigationController?.popViewController(animated: true)
                
            } //end if

        }
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}
