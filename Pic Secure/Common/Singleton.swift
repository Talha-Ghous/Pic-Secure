//
//  Singleton.swift
//  Pic Secure
//
//  Created by Talha Ghous on 30/9/18.
//  Copyright © 2018 Talha Ghous. All rights reserved.
//

import UIKit

public struct PixelData {
    var a: UInt8
    var r: UInt8
    var g: UInt8
    var b: UInt8
}

@objc protocol SingletonCallerProtocol{
    @objc optional func getEncryptedImage(object:UIImage)
    @objc optional func getDecryptedImage(object:UIImage)
}
class Singleton: NSObject {
    static let sharedInstance = Singleton()
    var delegate : SingletonCallerProtocol?
    var revealDelegate : RevealCallerProtocol?
    
    func writeDataToDisk(UserName userName:String, Password password:String) -> Bool {
        let preferences = UserDefaults.standard
        preferences.set(userName , forKey: USERNAME_KEY)
        preferences.set(password, forKey: PASSWORD_KEY)
        let didSave = preferences.synchronize()
        if !didSave {
            return false
        }
        return true
    }
    
    func checkUsernameAndPassword(UserName userName:String, Password password:String) -> Bool {
        
        let preferences = UserDefaults.standard
        
        
        if preferences.object(forKey: USERNAME_KEY) == nil && preferences.object(forKey: PASSWORD_KEY) == nil {
            return false
        } else {
            let diskUsername = preferences.string(forKey: USERNAME_KEY)
            let diskPassword = preferences.string(forKey: PASSWORD_KEY)
            
            if diskUsername ==  userName && diskPassword == password {
                return true
            }else{
                return false
            }
        }
    }
    
    func getUserName() -> String? {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: USERNAME_KEY) == nil {
            return nil
        } else {
            return preferences.string(forKey: USERNAME_KEY)!

        }
    }
    
    func getPassword() -> String? {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: PASSWORD_KEY) == nil {
            return nil
        } else {
            return preferences.string(forKey: PASSWORD_KEY)!
            
        }
    }
    
    func encryptImage(image: UIImage) {
        let arrayOfPixcels = pixelData(inImage: image)
        let imageHeight = Int(image.size.height)
        let imageWidth = Int(image.size.width)
        var arrayToDecode = [PixelData]()
        arrayToDecode = arrayOfPixcels!
        for _ in 0...ENCRYPTION_CYCLE{
            arrayToDecode  = rotateClockVisePixels(pixels: arrayToDecode)
        }
        let processedImage = imageFromARGB32Bitmap(pixels: arrayToDecode , width: imageWidth, height: imageHeight)!
        
        delegate?.getEncryptedImage!(object: processedImage)
        
    }// encrypt image ends
    
    func pixelData(inImage: UIImage) -> [PixelData]? {
        let size = inImage.size
        let dataSize = size.width * size.height * 4
        var pixelData = [UInt8](repeating: 0, count: Int(dataSize))
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: &pixelData,
                                width: Int(size.width),
                                height: Int(size.height),
                                bitsPerComponent: 8,
                                bytesPerRow: 4 * Int(size.width),
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
        guard let cgImage = inImage.cgImage else { return nil }
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        var pixelsStructureArray = [PixelData]()
        
        var singlePixel = PixelData(a: 255, r: 0, g: 0, b: 0)
        var counter = 0
        
        for color in pixelData{
            switch (counter){
            case 0:
                singlePixel.r = color
                break
            case 1:
                singlePixel.g = color
                break
            case 2:
                singlePixel.b = color
                break
            case 3:
                singlePixel.a = color
                pixelsStructureArray.append(singlePixel)
                singlePixel = PixelData(a: 255, r: 0, g: 0, b: 0)
                counter = -1
                break
            default:
                print("default")
            }
            counter = counter + 1
        }
        return pixelsStructureArray
    }
    
    func rotateClockVisePixels(pixels: [PixelData]) -> [PixelData] {
        
        var arrayToDecode = [PixelData]()
        
        var firstArray = [PixelData]()
        var secondArray = [PixelData]()
        for i in 0...pixels.count-1{
            let obj = pixels[i]
            
            if( i % 2 == 0){
                firstArray.append(obj)
            }else{
                secondArray.append(obj)
            }
        }
        for i in 0...firstArray.count-1{
            arrayToDecode.append(firstArray[i])
        }
        for i in 0...secondArray.count-1{
            arrayToDecode.append(secondArray[i])
        }
        return arrayToDecode
    }
    
    func rotateAntiClokeVisePixels(pixels: [PixelData]) -> [PixelData] {
        var arrayToDecode = [PixelData]()
        var firstArray = [PixelData]()
        var secondArray = [PixelData]()
        let halfCounter = pixels.count/2
        for i in 0...halfCounter-1{
            firstArray.append(pixels[i])
        }
        for i in halfCounter...pixels.count-1{
            secondArray.append(pixels[i])
        }
        var firstArrayCounter = 0
        var secondArrayCounter = 0
        for i in 0...pixels.count-1{
            
            if(i%2==0){
                arrayToDecode.append(firstArray[firstArrayCounter])
                firstArrayCounter += 1
            }else{
                arrayToDecode.append(secondArray[secondArrayCounter])
                secondArrayCounter += 1
            }
        }
        return arrayToDecode
    }
    
    func imageFromARGB32Bitmap(pixels: [PixelData], width: Int, height: Int) -> UIImage? {
        guard width > 0 && height > 0 else { return nil }
        guard pixels.count == width * height else { return nil }
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        let bitsPerComponent = 8
        let bitsPerPixel = 32
        
        var data = pixels // Copy to mutable []
        guard let providerRef = CGDataProvider(data: NSData(bytes: &data,
                                                            length: data.count * MemoryLayout<PixelData>.size)
            )
            else { return nil }
        
        guard let cgim = CGImage(
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bitsPerPixel,
            bytesPerRow: width * MemoryLayout<PixelData>.size,
            space: rgbColorSpace,
            bitmapInfo: bitmapInfo,
            provider: providerRef,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
            )
            else { return nil }
        
        return UIImage(cgImage: cgim)
    }
    func decryptImage(image: UIImage) {
        let arrayOfPixcels = pixelData(inImage: image)
        var arrayToDecode = [PixelData]()
        let imageHeight = Int(image.size.height)
        let imageWidth = Int(image.size.width)
        
        arrayToDecode = arrayOfPixcels!
        for _ in 0...ENCRYPTION_CYCLE{
            arrayToDecode = rotateAntiClokeVisePixels(pixels: arrayToDecode)
        }
        
        let processedImage =  imageFromARGB32Bitmap(pixels: arrayToDecode , width: imageWidth, height: imageHeight)!
        delegate?.getDecryptedImage!(object: processedImage)
        
        
    }
    
}
