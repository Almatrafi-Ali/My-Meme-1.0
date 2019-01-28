//
//  MemeDetailsVC.swift
//  test
//
//  Created by Ali Fahad on 11/04/1440 AH.
//  Copyright © 1440 Ali Fahad. All rights reserved.
//

import UIKit

class MemeDetailsVC: UIViewController {
    
    var memePic: Meme!
    var detailText:String!
    
    @IBOutlet weak var detailImg: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.detailImg!.image = memePic!.memedImage
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = true
        
    }
}
