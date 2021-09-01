//
//  CustomPhotoAlbum.swift
//  Pic Secure
//
//  Created by Talha Ghous on 1/6/18.
//  Copyright © 2018 Talha Ghous. All rights reserved.
//

import UIKit
import Photos

@objc protocol GalleryCallerProtocol{
    @objc optional func galleryFetching(object:Array<UIImage>)
    @objc optional func privateGalleryFetching(object:Array<UIImage>)
}
class CustomPhotoAlbum: NSObject {

    static let albumName = "PicSecure" // here put your album name
    static let sharedInstance = CustomPhotoAlbum()
    var delegate:GalleryCallerProtocol?
    var assetCollection: PHAssetCollection!
    
    override init() {
        super.init()
        
        if let assetCollection = fetchAssetCollectionForAlbum() {
            self.assetCollection = assetCollection
            return
        }
        
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in
                ()
            })
        }
        
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            self.createAlbum()
        } else {
            PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
        }
    }
    
    func requestAuthorizationHandler(status: PHAuthorizationStatus) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            // ideally this ensures the creation of the photo album even if authorization wasn't prompted till after init was done
            print("trying again to create the album")
            self.createAlbum()
        } else {
            print("should really prompt the user to let them know it's failed")
        }
    }
    
    func createAlbum() {
        PHPhotoLibrary.shared().performChanges({
            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: CustomPhotoAlbum.albumName)   // create an asset collection with the album name
        }) { success, error in
            if success {
                self.assetCollection = self.fetchAssetCollectionForAlbum()
            } else {
                print("error \(error)")
            }
        }
    }
    
    func fetchAssetCollectionForAlbum() -> PHAssetCollection? {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", CustomPhotoAlbum.albumName)
        let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        if let _: AnyObject = collection.firstObject {
            return collection.firstObject
        }
        return nil
    }
    
    func save(image: UIImageView) {
        if assetCollection == nil {
            return    // if there was an error upstream, skip the save
        }
        
        PHPhotoLibrary.shared().performChanges({
            
//            let sizeofUIIMage = image.bounds.size
//            let sizeofImage = image.image!.size
//            image.image!.size.p
//            let heightInPoints = image.image!.size.height
//            let heightInPixels = heightInPoints * image.image!.scale
//
//            let widthInPoints = image.image!.size.width
//            let widthInPixels = widthInPoints * image.image!.scale
//            let pixelsSize = CGSize(width: widthInPixels, height: heightInPixels)
//            UIGraphicsBeginImageContextWithOptions(sizeofImage, true, 1)
//            UIGraphicsBeginImageContextWithOptions(image.bounds.size, false, 1)
        //    UIGraphicsBeginImageContext(pixelsSize)
//            let context: CGContext? = UIGraphicsGetCurrentContext()
//            image.layer.render(in: context!)
            
 //           let imgs: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
 //          UIGraphicsEndImageContext()

//            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: imgs!)
//            let assetPlaceHolder = assetChangeRequest.placeholderForCreatedAsset
//            let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection)
//            let enumeration: NSArray = [assetPlaceHolder!]
//            albumChangeRequest!.addAssets(enumeration)
            
            
            //testing
            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image.image!)
            let assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset
            let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection)
            let enumeration: NSArray = [assetPlaceholder!]
            albumChangeRequest!.addAssets(enumeration)
            

        }, completionHandler: nil)
    }

    func FetchCustomAlbumPhotos()
    {
        var arrayOfImages : Array<UIImage> = Array()
        //var albumName = self.//"SwiftAlbum"
        var assetCollection = PHAssetCollection()
       // var albumFound = Bool()
        var photoAssets = PHFetchResult<AnyObject>()
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", CustomPhotoAlbum.albumName)
        let collection:PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        if let first_Obj:AnyObject = collection.firstObject{
            //found the album
            assetCollection = first_Obj as! PHAssetCollection
        //    albumFound = true
        }
//        else { albumFound = false }
    //    var i = collection.count
        photoAssets = PHAsset.fetchAssets(in: assetCollection, options: nil) as! PHFetchResult<AnyObject>
        let imageManager = PHCachingImageManager()
        
        //        let imageManager = PHImageManager.defaultManager()
        
        photoAssets.enumerateObjects{(object: AnyObject!,
            count: Int,
            stop: UnsafeMutablePointer<ObjCBool>) in
            
            if object is PHAsset{
                let asset = object as! PHAsset
                print("Inside  If object is PHAsset, This is number 1")
                
            //    let imageSize = IMAGE_SIZE//CGSize(width: asset.pixelWidth,
                                       //height: asset.pixelHeight)
                
                let imageSize = IMAGE_SIZE//CGSize(width: 600,height: 600)
//                let imageSize = CGSize(width: asset.pixelWidth,height: asset.pixelHeight)
                /* For faster performance, and maybe degraded image */
                let options = PHImageRequestOptions()
              //  options.deliveryMode = .fastFormat
                options.isSynchronous = true
                
                imageManager.requestImage(for: asset,
                                                  targetSize: imageSize,
                                                  contentMode: .aspectFit,
                                                  options: options,
                                                  resultHandler: {
                                                    (image, info) -> Void in

                                                    if image != nil{
                                                            arrayOfImages.append(image!)
                                                    }
                })
                
            }
        }
        self.delegate?.privateGalleryFetching?(object: arrayOfImages)
    }
    
    
    func getAllPhotoFromGallery()  {
        var arrayOfImages : Array<UIImage> = Array()
        // testing
       
        
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                let fetchOptions = PHFetchOptions()
                let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                option.isSynchronous = true
                option.deliveryMode = .fastFormat
                for i in 0...allPhotos.count-1{
                    // testing
                    manager.requestImage(for: allPhotos[i], targetSize: IMAGE_SIZE, contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                        thumbnail = result!
                    })
                      arrayOfImages.append(thumbnail)
                    // testing ends
                //    arrayOfImages.append(self.getAssetThumbnail(asset: allPhotos[i]))
                }
                self.delegate?.galleryFetching?(object: arrayOfImages)
                
            //    print("Found \(allPhotos.count) assets")
            case .denied, .restricted:
                print("Not allowed")
              
            case .notDetermined:
                // Should not see this when requesting
                print("Not determined yet")
                
            }
        }
    }
   
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        //option.deliveryMode = .opportunistic
      //  option.isSynchronous = true
        var thumbnail = UIImage()
        option.isSynchronous = true
//                manager.requestImage(for: asset, targetSize: CGSize(width: 600, height: 600), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
//                    thumbnail = result!
//                })
//        manager.requestImage(for: asset, targetSize: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
//            let size = result!.size
//            thumbnail = result!
//        })
        manager.requestImage(for: asset, targetSize: IMAGE_SIZE, contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                thumbnail = result!
            })
        
//         Because of actual pixels it take a lot of time to encrypt it.
//        manager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
//            thumbnail = result!
//        })
        return thumbnail
    }//UIScreen.main.scale

}
