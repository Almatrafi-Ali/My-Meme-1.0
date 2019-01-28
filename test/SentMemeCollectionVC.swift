//
//  SentMemeCollectionVC.swift
//  test
//
//  Created by Ali Fahad on 30/04/1440 AH.
//  Copyright © 1440 Ali Fahad. All rights reserved.
//

import UIKit

class SentMemeCollectionVC: UIViewController,UICollectionViewDataSource , UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var memes : [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let space: CGFloat
        let dimension: CGFloat
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        if UIDevice.current.orientation.isPortrait { 
            space = 3.0
            dimension = (view.frame.size.width - (2 * space)) / 3
        } else {
            space = 1.0
            dimension = (view.frame.size.width - (1 * space)) / 5
        }
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
        
        collectionView?.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return Meme.count()

    }
    
    //MARK: UICollectionViews Delegates
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SentMemeCollectionViewCell
        
        let meme = Meme.getMemeStorage().memes[indexPath.item]
        
        cell.updateCell(meme)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let memeDetail = self.storyboard?.instantiateViewController(withIdentifier: "memeDetail") as! MemeDetailsVC
        
        memeDetail.memePic = memes[indexPath.row]
        
        navigationController?.pushViewController(memeDetail, animated: true)

    }
    
}
