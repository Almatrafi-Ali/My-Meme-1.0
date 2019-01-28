//
//  customCell.swift
//  test
//
//  Created by Ali Fahad on 02/04/1440 AH.
//  Copyright © 1440 Ali Fahad. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var buttomText: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCell(_ meme: Meme) {
        
        // update cells
        imgView.image = meme.memedImage
        topText.text = meme.topText as String?
        buttomText.text = meme.bottomText as String?
    }
    
}

