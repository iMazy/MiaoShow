//
//  LiveModel.swift
//  MiaoShow
//
//  Created by  Mazy on 2017/4/8.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import SDWebImage

class LiveModel: NSObject {
    
    var allnum: Int64 = 0
    var gps: String?
    var flv: String?
    var starlevel: Int = 0
    var userId: String?
    var gender: Int = 0
    var myname: String?
    var bigpic: String? {
        didSet {
            SDWebImageDownloader.shared().downloadImage(with: URL(string: bigpic ?? ""), options: [], progress: nil, completed: { (image, _, _, _) in
                self.bigImage = image
            })
        }
    }
    var smallpic: String?
    var signatures: String?
    var bigImage: UIImage?
}
