//
//  LiveModel.swift
//  MiaoShow
//
//  Created by  Mazy on 2017/4/8.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import Foundation

struct LiveModel {
    var allnum: Int64 = 0
    var gps: String?
    var flv: String?
    var starlevel: Int = 0
    var userId: String?
    var gender: Int = 0
    var myname: String?
    var bigpic: String?
    var smallpic: String?
    var signatures: String?
    
    init(fromJSONDictionary info: [String: AnyObject]) {
        if let allnum = info["allnum"] as? Int64,
            let gps = info["gps"] as? String,
            let flv = info["flv"] as? String,
            let starlevel = info["starlevel"] as? Int,
            let userId = info["userId"] as? String,
            let gender = info["gender"] as? Int,
            let myname = info["myname"] as? String,
            let bigpic = info["bigpic"] as? String,
            let smallpic = info["smallpic"] as? String,
            let signatures = info["signatures"] as? String {
            self.allnum = allnum
            self.gps = gps
            self.flv = flv
            self.starlevel = starlevel
            self.userId = userId
            self.gender = gender
            self.myname = myname
            self.bigpic = bigpic
            self.smallpic = smallpic
            self.signatures = signatures
        }
    }
    
}
