//
//  ImageProcessingViewController.swift
//  Pic Secure
//
//  Created by Talha Ghous on 31/5/18.
//  Copyright © 2018 Talha Ghous. All rights reserved.
//

import UIKit

class ImageProcessingViewController: BaseViewController , SingletonCallerProtocol {
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var buttonsConatainerView: UIView!
    var centerImage:UIImage! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.mainImageView.image = centerImage
        let imageViewSIze = self.mainImageView.image?.size
        let size = centerImage.size
        self.title = "Photo Process"
       
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        Singleton.sharedInstance.delegate = self
        self.view.backgroundColor = APP_BACKGROUND_COLOR
        self.navigationController?.navigationBar.backgroundColor = APP_THEAM_COLOR
    }
    
    @IBAction func encryptionAction(_ sender: Any) {
        if let image = self.mainImageView.image {
            self.disableUIButtons()
            showActivityIndicator()
            DispatchQueue.global(qos: .background).async {
//                print("This is run on the background queue")
            Singleton.sharedInstance.encryptImage(image: image)
            }
            
        }
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        DispatchQueue.main.async {
//            let size = self.mainImageView.image?.size
            CustomPhotoAlbum.sharedInstance.save(image: self.mainImageView)
            self.showAlertView(Title: "Successful", Message: "Image saved in device photo gallery")
        }

    }
    
    @IBAction func shareAction(_ sender: UIButton) {
       // let image = UIImage(named: "Image")
        
        // set up activity view controller
        if let image = self.mainImageView.image {
            DispatchQueue.main.async {
                let imageToShare = [ image ]
                let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                
                activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
                // present the view controller
                self.present(activityViewController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func decryptionAction(_ sender: UIButton) {
        if let image = self.mainImageView.image {
            self.disableUIButtons()
            showActivityIndicator()
            DispatchQueue.global(qos: .background).async {
                Singleton.sharedInstance.decryptImage(image: image)
            }
           
        }
    }
   
    func getEncryptedImage(object: UIImage) {
        DispatchQueue.main.async {
            self.stopActivityIndicator()
            self.mainImageView.image = object
            self.enableUIButtons()
        }
    }
    func getDecryptedImage(object: UIImage) {
        DispatchQueue.main.async {
            self.stopActivityIndicator()
            self.mainImageView.image = object
            self.enableUIButtons()
        }
    }
    
    func disableUIButtons()  {
        self.buttonsConatainerView.isUserInteractionEnabled = false
    }
    func enableUIButtons()  {
        self.buttonsConatainerView.isUserInteractionEnabled = true
    }

}
