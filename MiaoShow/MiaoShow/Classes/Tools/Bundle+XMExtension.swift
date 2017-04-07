//
//  Bundle+XMExtension.swift
//  TestWeibo_Swift
//
//  Created by TwtMac on 16/12/13.
//  Copyright © 2016年 Mazy. All rights reserved.
//

import Foundation

extension Bundle {
    // 计算性属性,没有参数,没有返回值
    var nameSpace: String {
        return infoDictionary?["CFBundleExecutable"] as? String ?? ""
    }
}
