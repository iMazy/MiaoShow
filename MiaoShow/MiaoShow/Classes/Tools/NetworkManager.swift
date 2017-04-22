//
//  NetworkManager.swift
//  MiaoShow
//
//  Created by  Mazy on 2017/4/22.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import Foundation
import Alamofire

let liveURL = "http://live.9158.com/Fans/GetHotLive?page="

class NetworkManager {
    
    /// singleton
    static let shared = NetworkManager()
    
    var page: Int = 1
    
    func get(pullup: Bool, completed:@escaping (_ results: [LiveModel])->()) {
        
        if pullup {
            page += 1
        } else {
            page = 1
        }
        
        let url = liveURL + "\(page)"
        
        Alamofire.request(url).responseJSON { (response) in
            if let JSON:[String:AnyObject] = response.result.value as! [String : AnyObject]? {
                
                var liveModels: [LiveModel] = [LiveModel]()
                
                let infoDict = JSON["data"]?["list"] as! [AnyObject]
                
                for item in infoDict {
                    let m = LiveModel(fromJSONDictionary: item as! [String: AnyObject])
                    liveModels.append(m)
                }
                
                completed(liveModels)
            }
        }
    }
}
