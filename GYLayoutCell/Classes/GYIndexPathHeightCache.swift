//
//  GYIndexPathHeightCache.swift
//  GYLayoutCell
//
//  Created by ZGY on 2017/10/13.
//Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/10/13  下午2:24
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

typealias GYIndexPathHeightsBySection = [[NSNumber]]

class GYIndexPathHeightCache: NSObject {
    
    var automaticallyInvalidateEnabled:Bool = false
    /// 横屏
    private var heightsBySectionForPortrait:GYIndexPathHeightsBySection!
    /// 竖屏
    private var heightsBySectionForLandscape:GYIndexPathHeightsBySection!
    
    override init() {
        super.init()
        heightsBySectionForPortrait = [[]]
        heightsBySectionForLandscape = [[]]
    }
    
    func cacheHeightByIndexPath(_ height:CGFloat,indexPath:IndexPath){
        
        automaticallyInvalidateEnabled = true
        
        cachesIndexPathIfNeeded([indexPath])
        var heights = heightsBySectionForCurrentOrientation()
//        heights.append([NSNumber.init(value: Float(height))])
        heights[indexPath.section][indexPath.row] = NSNumber.init(value: Float(height))
        
    }
    
    /// Height cache
    ///
    /// - Parameter indexPath: Key
    /// - Returns: result
    func existsHeightAtIndexPath(_ indexPath:IndexPath) -> Bool {
        
        cachesIndexPathIfNeeded([indexPath])
        let number = heightsBySectionForCurrentOrientation()[indexPath.section][indexPath.row]
        
        return !number.isEqual(to: -1)
    }
    
    func heightForIndexPath(_ indexPath:IndexPath) -> CGFloat {
        
        cachesIndexPathIfNeeded([indexPath])
        
        let number = heightsBySectionForCurrentOrientation()[indexPath.section][indexPath.row]
        
        return CGFloat(truncating: number)
        
    }
    
    
    /// the fixed indexPath cached invalidated
    ///
    /// - Parameter indexPath:
    func invalidateHeightAtIndexPath(_ indexPath:IndexPath ) {
        cachesIndexPathIfNeeded([indexPath])
        
        forEachAllOrientUsingBlock { (index) in
            var heightsBySection = index
            heightsBySection[indexPath.section][indexPath.row] = -1
        }
    }
    
    func invalidateAllHeightCache() {
        
        forEachAllOrientUsingBlock { (index) in
            var heightsBySection = index
            heightsBySection.removeAll()
        }
        
    }
    
    
    /// if need caches
    ///
    /// - Parameter indexPaths:
    fileprivate func cachesIndexPathIfNeeded(_ indexPaths:[IndexPath]) {
        
        indexPaths.forEach { (indexPath) in
            sectionsIfNeed(indexPath.row)
            rowsIfNeeded(indexPath.row, section: indexPath.section)
        }
        
    }
    
    /// Sections if needed cache
    ///
    /// - Parameter section:
    fileprivate func sectionsIfNeed(_ section:Int) {
        
        forEachAllOrientUsingBlock { (index:GYIndexPathHeightsBySection) in
            
            var heightsBySection = index
            
            for i in 0...section {
                if i >= index.count {
                    heightsBySection[section] = []
                }
            }
            
        }
        
    }
    
    /// Cache by Row
    ///
    /// - Parameters:
    ///   - targetRow:
    ///   - section:
    fileprivate func rowsIfNeeded(_ targetRow:Int,section:Int) {
        
        forEachAllOrientUsingBlock { (index) in
            
            var heightsByRow = index[section]
            
            for i in 0...section {
                if i >= index.count {
                    heightsByRow[i] = -1
                }
            }
            
        }
        
    }
    
    /// block
    ///
    /// - Parameter block:
    fileprivate func forEachAllOrientUsingBlock(_ block:((GYIndexPathHeightsBySection)->Void)) {
        
        block(heightsBySectionForPortrait)
        block(heightsBySectionForLandscape)
    }
    
    /// Portrait or Landscape
    ///
    /// - Returns: Type
 func  heightsBySectionForCurrentOrientation() -> GYIndexPathHeightsBySection {
    
        return UIDeviceOrientationIsPortrait(UIDevice.current.orientation) ? heightsBySectionForPortrait : heightsBySectionForLandscape
    }
    
    
}
