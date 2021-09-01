//
//  ViewController.swift
//  Pic Secure
//
//  Created by Talha Ghous on 29/9/18.
//  Copyright © 2018 Talha Ghous. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController,UITextFieldDelegate {

    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPasword: UITextField!
    
    @IBOutlet weak var btnShowPassword: UIButton!
    
    var secureTextEntry = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfUserName.delegate = self
        tfPasword.delegate = self
        tfPasword.isSecureTextEntry = true
    }

    @IBAction func showPasswordAction(_ sender: UIButton) {
        if secureTextEntry {
            self.btnShowPassword.setImage(UIImage(named: "checked_checkbox@2x"), for: UIControlState.normal)
            self.tfPasword.isSecureTextEntry = false
            secureTextEntry = false
            self.tfPasword.becomeFirstResponder()
        }else{
             self.btnShowPassword.setImage(UIImage(named: "unchecked_checkbox@2x"), for: UIControlState.normal)
            self.tfPasword.isSecureTextEntry = true
            secureTextEntry = true
            self.tfPasword.becomeFirstResponder()
        }
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        if self.tfUserName.text != nil && self.tfPasword.text != nil{
            if Singleton.sharedInstance.checkUsernameAndPassword(UserName: self.tfUserName.text!, Password: self.tfPasword.text!){
          
                let myVC = storyboard?.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
                
                self.navigationController!.pushViewController(myVC, animated: true)
            }else{
                showAlertView(Title: "Try Again", Message: "Please provide a valid username and password")
            }
        }else{

            showAlertView(Title: "Try Again", Message: "Please provide username and password.")
        }
    }
    @IBAction func signupAction(_ sender: UIButton) {
    }
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField ==  tfUserName {
            self.tfUserName.endEditing(true)
            self.tfPasword.becomeFirstResponder()
        }else{
            self.tfPasword.endEditing(true)
        }
        return true
    }
}

