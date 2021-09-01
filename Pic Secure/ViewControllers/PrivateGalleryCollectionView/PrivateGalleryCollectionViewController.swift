//
//  PrivateGalleryCollectionViewController.swift
//  Pic Secure
//
//  Created by Talha Ghous on 1/6/18.
//  Copyright © 2018 Talha Ghous. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PrivateGalleryCell"

class PrivateGalleryCollectionViewController: UICollectionViewController, GalleryCallerProtocol {

    var arrayOfImages : Array<UIImage> = Array()
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        activityIndicator.center =  CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        self.view.addSubview(activityIndicator)
        activityIndicator.color = UIColor.blue
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        CustomPhotoAlbum.sharedInstance.delegate = self
//        CustomPhotoAlbum.sharedInstance.FetchCustomAlbumPhotos()
        self.setRevealControllerButton()
        self.title = "My Gallery"

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "refresh_icon.png"), style: .done, target: self, action: #selector(refreshGallery))
        DispatchQueue.global(qos: .background).async {
            CustomPhotoAlbum.sharedInstance.FetchCustomAlbumPhotos()
        }
    }

    @objc func refreshGallery(sender: AnyObject)  {
        activityIndicator.startAnimating()
        CustomPhotoAlbum.sharedInstance.FetchCustomAlbumPhotos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = APP_BACKGROUND_COLOR
        self.navigationController?.navigationBar.backgroundColor = APP_THEAM_COLOR
        CustomPhotoAlbum.sharedInstance.delegate = self
        //CustomPhotoAlbum.sharedInstance.FetchCustomAlbumPhotos()
    }
    func setRevealControllerButton()  {
        let reveal:SWRevealViewController = self.revealViewController()
        reveal.panGestureRecognizer()
        reveal.tapGestureRecognizer()
        let btnLeft:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "reveal-icon.png"), style: UIBarButtonItemStyle.plain, target: reveal, action:#selector(SWRevealViewController.revealToggle(_:)) )
        self.navigationItem.leftBarButtonItem = btnLeft
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "ImageProcessingViewController") as! ImageProcessingViewController
        myVC.centerImage = self.arrayOfImages[indexPath.row]
        navigationController?.pushViewController(myVC, animated: true)
        
        print("You selected cell #\(indexPath.item)!")
    }
 



    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.arrayOfImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PrivateGalleryCollectionViewCell
    
        // Configure the cell
        cell.imageView.image = self.arrayOfImages[indexPath.row]
        return cell
    }

    func privateGalleryFetching(object: Array<UIImage>) {
        self.arrayOfImages = object
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.collectionView?.reloadData()
        }
        
    }
  


   

}
