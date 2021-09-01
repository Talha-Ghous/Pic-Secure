//
//  ContainerViewController.swift
//  Pic Secure
//
//  Created by Talha Ghous on 30/9/18.
//  Copyright © 2018 Talha Ghous. All rights reserved.
//

import UIKit

@objc protocol RevealCallerProtocol{
    @objc optional func presentTheamsViewController()
    @objc optional func dismissTheamsFetching()
 
}

class ContainerViewController: BaseViewController, SWRevealViewControllerDelegate,RevealCallerProtocol {

    var reveal:SWRevealViewController?
    var myTabBarController:UITabBarController = UITabBarController()
    
    var menuViewController: MenuTableViewController!
    var galleryViewController : GalleryCollectionViewController!
    var privateGalleryViewController: PrivateGalleryCollectionViewController!
    var theamViewController : TheamsTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         theamViewController = storyboard?.instantiateViewController(withIdentifier: "TheamsTableViewController") as! TheamsTableViewController
        menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuTableViewController") as! MenuTableViewController
        let menuNavigationController = UINavigationController(rootViewController: menuViewController)
       
        galleryViewController = storyboard?.instantiateViewController(withIdentifier: "GalleryCollectionViewController") as! GalleryCollectionViewController
        
         let galleryNavigationController  = UINavigationController(rootViewController: galleryViewController)
         galleryNavigationController.tabBarItem = UITabBarItem(title: "Gallery", image: UIImage(named: "gallery_icon_1.png"), tag: 0)
        
        
        privateGalleryViewController = storyboard?.instantiateViewController(withIdentifier: "PrivateGalleryCollectionViewController") as! PrivateGalleryCollectionViewController
        
        let privateGalleryNavigationController = UINavigationController(rootViewController: privateGalleryViewController)
        privateGalleryNavigationController.tabBarItem = UITabBarItem(title: "MyGallery", image: UIImage(named: "gallery_icon_2.png"), tag: 1)
        
        let arrayOfNavigationControllers: [UINavigationController] = [galleryNavigationController,privateGalleryNavigationController]
//let arrayOfNavigationControllers: [UINavigationController] = [galleryNavigationController]
    myTabBarController.setViewControllers(arrayOfNavigationControllers, animated: true)
        myTabBarController.selectedIndex = 0
        myTabBarController.tabBar.backgroundColor = APP_THEAM_COLOR
        
//reveal = SWRevealViewController(rearViewController: menuNavigationController, frontViewController: galleryNavigationController)
        reveal = SWRevealViewController(rearViewController: menuNavigationController, frontViewController: myTabBarController)
        reveal!.delegate = self
        Singleton.sharedInstance.revealDelegate = self
        self.present(self.reveal!, animated: false, completion: nil)
        
        self.navigationItem.hidesBackButton = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myTabBarController.tabBar.backgroundColor = APP_THEAM_COLOR
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentTheamsViewController() {
        self.dismiss(animated: true) {
            self.navigationController?.pushViewController(self.theamViewController, animated: true  )
            //self.present(self.theamViewController, animated: true, completion: nil)
        }
    }
    func dismissTheamsFetching() {
        //self.popoverPresentationController
        self.navigationController?.popViewController(animated: true)
       // self.dismiss(animated: true) {
            self.present(self.reveal!, animated: true, completion: nil)
//}

        
    }
    


}


