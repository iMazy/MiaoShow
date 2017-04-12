//
//  XMNavigationController.swift
//  MiaoShow
//
//  Created by  Mazy on 2017/4/7.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class XMNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = UIColor.init(colorLiteralRed: 255/255.0, green: 46/255.0, blue: 148/255.0, alpha: 1.0)
        
        navigationBar.barStyle = .black

        // Do any additional setup after loading the view.
    }

    override func show(_ vc: UIViewController, sender: Any?) {
        if childViewControllers.count > 0 {
            vc.hidesBottomBarWhenPushed = true
        }
        super.show(vc, sender: sender)
    }

}
