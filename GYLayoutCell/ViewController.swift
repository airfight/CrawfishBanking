//
//  ViewController.swift
//  GYLayoutCell
//
//  Created by macpro on 2017/10/13.
//  Copyright © 2017年 macpro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let gy = GYIndexPathHeightCache()
        gy.cacheHeightByIndexPath(50, indexPath: IndexPath(row: 0, section: 0))
        
        print(gy.heightsBySectionForCurrentOrientation())
        print(gy.automaticallyInvalidateEnabled)
        print(gy.heightForIndexPath(IndexPath(row: 0, section: 0)))
        
        gy.invalidateAllHeightCache()
        print(gy.heightsBySectionForCurrentOrientation())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

