//
//  TheamsModel.swift
//  Pic Secure
//
//  Created by Talha Ghous on 3/6/18.
//  Copyright © 2018 Talha Ghous. All rights reserved.
//

import UIKit

class TheamsModel: NSObject {

    var color : UIColor!
    var colorName : String!
    
//  static  func TheamsModel(colorObj:UIColor , colorNameObj : String) -> TheamsModel{
//        var obj = TheamsModel()
//        self.color = colorObj
//        self.colorName = colorNameObj
//        return self
//    }
    
     init(colorObj:UIColor , colorNameObj : String) {
        super.init()
        self.color = colorObj
        self.colorName = colorNameObj
        
    }
  static  func initTheamsArray() -> Array<TheamsModel> {
        var array : Array<TheamsModel> = Array()
        var model : TheamsModel = TheamsModel(colorObj: UIColor(displayP3Red: 241/255.0, green: 188/255.0, blue: 157/255.0, alpha: 1), colorNameObj: "Cream")
        array.append(model)
        
        model = TheamsModel(colorObj: UIColor(displayP3Red: 230/255.0, green: 133/255.0, blue: 129/255.0, alpha: 1), colorNameObj: "Redish")
        array.append(model)
        
        model = TheamsModel(colorObj: UIColor(displayP3Red: 123/255.0, green: 63/255.0, blue: 97/255.0, alpha: 1), colorNameObj: "Purple")
        array.append(model)
        
        model = TheamsModel(colorObj: UIColor(displayP3Red: 196/255.0, green: 219/255.0, blue: 230/255.0, alpha: 1), colorNameObj: "Sky Blue")
        array.append(model)
        
        model = TheamsModel(colorObj: UIColor(displayP3Red: 152/255.0, green: 140/255.0, blue: 151/255.0, alpha: 1), colorNameObj: "Gachi")
        array.append(model)
    
        model = TheamsModel(colorObj: UIColor(displayP3Red: 83/255.0, green: 123/255.0, blue: 49/255.0, alpha: 1), colorNameObj: "Green")
        array.append(model)
    
    model = TheamsModel(colorObj: UIColor(displayP3Red: 123/255.0, green: 89/255.0, blue: 33/255.0, alpha: 1), colorNameObj: "Brown")
    array.append(model)
    
    model = TheamsModel(colorObj: UIColor(displayP3Red: 121/255.0, green: 38/255.0, blue: 23/255.0, alpha: 1), colorNameObj: "Red")
    array.append(model)
    
    model = TheamsModel(colorObj: UIColor(displayP3Red: 72/255.0, green: 12/255.0, blue: 33/255.0, alpha: 1), colorNameObj: "Maroon")
    array.append(model)
    
    model = TheamsModel(colorObj: UIColor(displayP3Red: 20/255.0, green: 1/255.0, blue: 74/255.0, alpha: 1), colorNameObj: "Blue")
    array.append(model)
    
    model = TheamsModel(colorObj: UIColor(displayP3Red: 38/255.0, green: 70/255.0, blue: 100/255.0, alpha: 1), colorNameObj: "Navy Blue")
    array.append(model)
    
    model = TheamsModel(colorObj: UIColor(displayP3Red: 255/255.0, green: 140/255.0, blue: 1/255.0, alpha: 1), colorNameObj: "Dark Orange")
    array.append(model)
    
    model = TheamsModel(colorObj: UIColor(displayP3Red: 255/255.0, green: 1/255.0, blue: 255/255.0, alpha: 1), colorNameObj: "Magenta")
    array.append(model)
    
    model = TheamsModel(colorObj: UIColor(displayP3Red: 255/255.0, green: 105/255.0, blue: 180/255.0, alpha: 1), colorNameObj: "Hot Pink")
    array.append(model)
    
    model = TheamsModel(colorObj: UIColor(displayP3Red: 75/255.0, green: 1/255.0, blue: 130/255.0, alpha: 1), colorNameObj: "Indigo")
    array.append(model)
    
    model = TheamsModel(colorObj: UIColor(displayP3Red: 1/255.0, green: 255/255.0, blue: 1/255.0, alpha: 1), colorNameObj: "Lime")
    array.append(model)
        
        
        
        
        return array
        
    }
    
}
