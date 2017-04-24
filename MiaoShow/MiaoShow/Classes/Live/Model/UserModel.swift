//
//  UserModel.swift
//  MiaoShow
//
//  Created by  Mazy on 2017/4/24.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

struct Users {
    
    var userArray = [UserModel]()
    
    init(users dictArray: [[String: AnyObject]]) {
        
        for dict in dictArray {
            let user = UserModel(infoDictionary: dict)
            userArray.append(user)
        }
        
    }
    
}

struct UserModel {
    var photo: String?
    
    init(infoDictionary info: [String: AnyObject]) {
        if let ph = info["photo"] as? String {
            self.photo = ph
        }
    }
}
