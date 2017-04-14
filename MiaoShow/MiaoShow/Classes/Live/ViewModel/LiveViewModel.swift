//
//  LiveViewModel.swift
//  MiaoShow
//
//  Created by  Mazy on 2017/4/8.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

import Alamofire
import MJExtension
import SDWebImage

class LiveViewModel: NSObject {
    
    lazy var liveList = [LiveModel]()
    
    func loadListData(complite:@escaping ()->()) {
        
        Alamofire.request("http://live.9158.com/Fans/GetHotLive?page=1").responseJSON { (response) in
            if let JSON:[String:AnyObject] = response.result.value as! [String : AnyObject]? {
                
                let array = JSON["data"]?["list"] as! [[String: AnyObject]]
        
                for list in array {
                    let model = LiveModel.mj_object(withKeyValues: list)
                    self.liveList.append(model!)
                }
                
            }
            
            complite()
        }
        
    }
    
    
    
    
}
