//
//  SentMemeCollectionViewCell.swift
//  test
//
//  Created by Ali Fahad on 30/04/1440 AH.
//  Copyright © 1440 Ali Fahad. All rights reserved.
//

import UIKit

class SentMemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    func updateCell(_ meme: Meme) {
        
        //update cell's view
        imgView.image = meme.memedImage
    }
}
