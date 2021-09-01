//
//  GalleryCollectionViewController.swift
//  Pic Secure
//
//  Created by Talha Ghous on 30/5/18.
//  Copyright © 2018 Talha Ghous. All rights reserved.
//

import UIKit
import Photos

//private let reuseIdentifier = "Cell"

class GalleryCollectionViewController: UICollectionViewController,GalleryCallerProtocol {

    let reuseIdentifier = "Cell"
    var arrayOfImages : Array<UIImage> = Array()
    var arrayOfnames : Array<String> = Array()
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()
       
        activityIndicator.center =  CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        self.view.addSubview(activityIndicator)
        activityIndicator.color = UIColor.blue
      //  activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        CustomPhotoAlbum.sharedInstance.delegate = self
        self.initArray()
    //CustomPhotoAlbum.sharedInstance.getAllPhotoFromGallery()
        self.setRevealControllerButton()
        self.title = "Categories"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "settings-icon-512.png"), style: .done, target: self, action: #selector(refreshGallery))
        
    }
    @objc func refreshGallery(sender: AnyObject)  {
//        activityIndicator.startAnimating()
//        CustomPhotoAlbum.sharedInstance.getAllPhotoFromGallery()
    }

    override func viewWillAppear(_ animated: Bool) {
    
        self.view.backgroundColor = APP_BACKGROUND_COLOR
        self.navigationController?.navigationBar.backgroundColor = APP_THEAM_COLOR
        CustomPhotoAlbum.sharedInstance.delegate = self
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setRevealControllerButton()  {
        let reveal:SWRevealViewController = self.revealViewController()
        reveal.panGestureRecognizer()
        reveal.tapGestureRecognizer()
        let btnLeft:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "reveal-icon.png"), style: UIBarButtonItemStyle.plain, target: reveal, action:#selector(SWRevealViewController.revealToggle(_:)) )
        self.navigationItem.leftBarButtonItem = btnLeft
    }

// MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayOfImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> GalleryCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath as IndexPath) as! GalleryCollectionViewCell
        
        cell.imageView.image = self.arrayOfImages[indexPath.row]
        cell.name.text = arrayOfnames[indexPath.row]
        
        return cell
    }
  
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            let myVC = storyboard?.instantiateViewController(withIdentifier: "ImageProcessingViewController") as! ImageProcessingViewController
            myVC.centerImage = self.arrayOfImages[indexPath.row]
            //navigationController?.pushViewController(myVC, animated: true)
        
      //  print("You selected cell #\(indexPath.item)!")
    }
    
    func galleryFetching(object: Array<UIImage>) {
        self.arrayOfImages = object
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.collectionView?.reloadData()
        }
        
    }
    
    func initArray(){
        self.arrayOfImages.append(UIImage(named: "car-icon.jpeg")!)
        self.arrayOfImages.append(UIImage(named: "Utility-bills-icon.jpg")!)
        self.arrayOfImages.append(UIImage(named: "notes-icon.png")!)
        self.arrayOfImages.append(UIImage(named: "password-Lock-icon.jpg")!)
        self.arrayOfImages.append(UIImage(named: "recipt-icon.jpg")!)
        
        self.arrayOfnames.append("Car Insurance")
        self.arrayOfnames.append("Bills")
        self.arrayOfnames.append("Notes")
        self.arrayOfnames.append("Passwords")
        self.arrayOfnames.append("Recipts")
    }


}
