//
//  LiveRecordController.swift
//  MiaoShow
//
//  Created by  Mazy on 2017/4/18.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class LiveRecordController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: false, completion: nil)
    }
}
