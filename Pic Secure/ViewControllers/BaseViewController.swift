//
//  BaseViewController.swift
//  Pic Secure
//
//  Created by Talha Ghous on 29/9/18.
//  Copyright © 2018 Talha Ghous. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = APP_BACKGROUND_COLOR
        activityIndicator.center =  CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        activityIndicator.color = UIColor.white
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
    }
    override func viewWillAppear(_ animated: Bool) {
        
    self.navigationController?.navigationBar.backgroundColor = APP_THEAM_COLOR
    }
    func showActivityIndicator()  {
        self.activityIndicator.startAnimating()
    }
    func stopActivityIndicator() {
        self.activityIndicator.stopAnimating()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlertView(Title title:String, Message message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
       
        self.present(alert, animated: true, completion: nil)
    }

}
