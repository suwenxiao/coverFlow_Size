//
//  ViewController.swift
//  CoverFlowDemo
//
//  Created by 苏文潇 on 2017/9/12.
//  Copyright © 2017年 Koalareading. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    var collectionView: UICollectionView!
    var flowLayout: KRFlowLayout!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setControllerView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    private func setControllerView()
    {
        let flowLayout: KRFlowLayout = KRFlowLayout()
        self.flowLayout = flowLayout
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: 700)
        collectionView.backgroundColor = UIColor.orange
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.bounces = false
        
        let lens: CGFloat = UIScreen.main.bounds.size.width/2 - 160
        collectionView.contentInset = UIEdgeInsets(top: 0, left: lens, bottom: -60, right: lens)
        collectionView.showsHorizontalScrollIndicator = false
        self.collectionView = collectionView
//        告诉系统使用之前的生命周期，解决了ios的bug
        collectionView.isPrefetchingEnabled = false
//        collectionView.center = self.view.center
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cellID")
        
        self.view.addSubview(collectionView)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10//(一定要多两个，否则效果会出现问题)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)

            cell.isUserInteractionEnabled = true
            cell.layer.borderWidth = 3
            cell.layer.borderColor = UIColor.white.cgColor
            cell.backgroundView = UIImageView.init(image: UIImage(named: "1"))
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)

    }
    
    
}






