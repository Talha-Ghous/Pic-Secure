//
//  ForgotPasswordViewController.swift
//  Pic Secure
//
//  Created by Talha Ghous on 30/9/18.
//  Copyright © 2018 Talha Ghous. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class ForgotPasswordViewController: BaseViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var tfEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            showAlertView(Title: "Not Available", Message: "Mail services are not available")
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
    
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        if self.tfEmail.text != nil{
            if let emailAddress = Singleton.sharedInstance.getUserName(){
                if self.tfEmail.text == emailAddress{
                    composeVC.setToRecipients([emailAddress])
                    composeVC.setSubject("Password Recovery")
                    if let passord = Singleton.sharedInstance.getPassword(){
                        composeVC.setMessageBody("Hello, your passowrd for Pic Secure is \(passord)", isHTML: false)
                        self.present(composeVC, animated: true, completion: nil)
                    }else{
                        showAlertView(Title: "UnSuccessfull", Message: "Sorry we are unable to finde your password.")
                    }
                    
                }else{
                    showAlertView(Title: "Mis Match", Message: "Sorry, Your provided email address does not match with user.")
                }
                
            }else{
                showAlertView(Title: "Sorry", Message: "Sorry we are unable to find your email address.")
            }
            
        }else{
            showAlertView(Title: "Sorry", Message: "Please provide an email address.")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
    }

}
