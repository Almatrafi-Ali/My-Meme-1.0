//
//  SentMemtTableViewVC.swift
//  test
//
//  Created by Ali Fahad on 02/04/1440 AH.
//  Copyright © 1440 Ali Fahad. All rights reserved.
//

import UIKit

class SentMemtTableViewVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var memes : [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
        
        // Reload Table with memes data
        tableView!.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  Meme.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        let meme = Meme.getMemeStorage().memes[indexPath.row]
        cell.updateCell(meme)

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        let memeDetail = self.storyboard?.instantiateViewController(withIdentifier: "memeDetail") as! MemeDetailsVC
        
        memeDetail.memePic = memes[indexPath.row]
        
        navigationController?.pushViewController(memeDetail, animated: true)

    }

}
