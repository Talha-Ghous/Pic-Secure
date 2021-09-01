//
//  SignupViewController.swift
//  Pic Secure
//
//  Created by Talha Ghous on 30/9/18.
//  Copyright © 2018 Talha Ghous. All rights reserved.
//

import UIKit

class SignupViewController: BaseViewController,UITextFieldDelegate {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        tfEmail.delegate = self
        tfPassword.delegate = self
        tfConfirmPassword.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupAction(_ sender: UIButton) {
        
        if self.tfEmail.text != nil && self.tfPassword.text != nil && self.tfConfirmPassword.text != nil{
            if self.tfPassword.text == self.tfConfirmPassword.text {
                
                if isValidEmail(emailAddress: self.tfEmail.text!){
                    
                    if   Singleton.sharedInstance.writeDataToDisk(UserName: self.tfEmail.text!, Password: self.tfPassword.text!){
                        // YOu are signup successfully
                        showSignupSuccessful(Title: "Successful", Message: "You have Sign Up successfully.")
                    }else{
                        showAlertView(Title: "Failure", Message: "Sign up failure due to some technical fault, Try again.")
                    }
                    
                }else{
                    // Please provide a valid Email Address.
                    showAlertView(Title: "Invalid Email", Message: "Please provide a valid Email Address.")
                }
                
            }else{
                // Password does not matches.
                showAlertView(Title: "Password MisMatch", Message: "Password does not matches, Try agian.")
            }
            
        }else{
             showAlertView(Title: "Try Again", Message: "Please provide desired details.")
        }
    }
    
    func isValidEmail(emailAddress:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailAddress)
    }
    
    func showSignupSuccessful(Title title:String, Message message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                self.navigationController?.popViewController(animated: true)
                
            case .cancel:
                print("cancel")
                self.navigationController?.popViewController(animated: true)
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField ==  tfEmail {
            self.tfEmail.endEditing(true)
            self.tfPassword.becomeFirstResponder()
        }else if textField == tfPassword{
            self.tfPassword.endEditing(true)
            self.tfConfirmPassword.becomeFirstResponder()
        }else{
            self.tfConfirmPassword.endEditing(true)
        }
        return true
    }
}
