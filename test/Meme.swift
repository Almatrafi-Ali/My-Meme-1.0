//
//  Meme.swift
//  test
//
//  Created by Ali Fahad on 11/03/1440 AH.
//  Copyright © 1440 Ali Fahad. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    
    var topText:String
    var bottomText: String
    var originalImage: UIImage!
    var memedImage: UIImage
    
    // count all Memes
    static func count() -> Int {
        return getMemeStorage().memes.count
    }
    
    // find  Meme storage location
    static func getMemeStorage() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    
}
