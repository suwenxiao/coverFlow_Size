//
//  KRFlowLayout.swift
//  CoverFlowDemo
//
//  Created by 苏文潇 on 2017/9/12.
//  Copyright © 2017年 Koalareading. All rights reserved.
//

import UIKit

class KRFlowLayout: UICollectionViewFlowLayout {
    
//    collectionView的itemSize的大小
    var itemsSize: CGSize?
    var collecCellIndexCallBack: ((IndexPath)->())?
    
    override func prepare() {
        super.prepare()
        
    
        let itemSize = CGSize(width: 320, height: 500)
        
        self.itemSize = itemSize
        self.minimumInteritemSpacing = 0
        self.minimumLineSpacing = 10
        self.scrollDirection = .horizontal
        
    }

    //    MARK: 获取所有的格子，设置格子的相关属性
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let array: [UICollectionViewLayoutAttributes] = super.layoutAttributesForElements(in: rect)!
//        1.设置距离中心线的总距离
        let middleDistance: CGFloat = UIScreen.main.bounds.size.width * 0.5 + (self.collectionView?.contentOffset.x ?? 0)
        
        for values in array
        {
//            2.计算每个格子到中心线之间的距离
            let distance: CGFloat = values.center.x - middleDistance
//            3.根据距离计算缩放比 -- 距离越远 越小
            let scale = 1 - abs(distance)/UIScreen.main.bounds.width
            values.center.y = values.center.y - scale * 40
        }
        
        return array
    }
    
    //    MARK: 根据手指的力度，来判断当前的滚动惯性没确定最终的停止位置
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//        根据惯性计算最终的位置
        var loc: CGPoint = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
//        计算将来的位置
        var rect: CGRect = CGRect.zero
        rect.origin = proposedContentOffset
        rect.size =  (self.collectionView?.bounds.size)!  
//        根据将来的区域  获取区域内的格子
        let array: [UICollectionViewLayoutAttributes] = self.layoutAttributesForElements(in: rect)!
//        计算  里面的格子 哪一个离中心线最近， 格子离中心线的距离最短代表最近
        let featureDistance: CGFloat = UIScreen.main.bounds.size.width * 0.5 + proposedContentOffset.x
        
        var min: CGFloat = CGFloat.greatestFiniteMagnitude
        
        var shortDistance: CGFloat = 0
        
        var collecCell:  UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes()
        
        for values in array
        {
            let distance: CGFloat = values.center.x - featureDistance
            if abs(distance) < min
            {
                min = abs(distance)
                shortDistance = distance
                collecCell = values
            }
        }
        
//        修正  当前的展示位置
        loc = CGPoint(x: loc.x + shortDistance, y: loc.y)
        
        collecCellIndexCallBack?(collecCell.indexPath)
        
        return loc
    }
    
    
//   MARK:  告诉系统实时更新
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}






