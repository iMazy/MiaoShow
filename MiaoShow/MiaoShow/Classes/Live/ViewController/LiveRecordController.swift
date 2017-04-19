//
//  LiveRecordController.swift
//  MiaoShow
//
//  Created by  Mazy on 2017/4/18.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class LiveRecordController: UIViewController {

    
    @IBOutlet weak var bottomContentView: UIView!    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)

        bottomContentView.transform = CGAffineTransform(translationX: 0, y: bottomContentView.bounds.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear], animations: {
            self.bottomContentView.transform =  .identity
        })
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3, animations: { 
            self.bottomContentView.transform = CGAffineTransform(translationX: 0, y: self.bottomContentView.bounds.height)
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    
    @IBAction func beginRecord() {
        print("录制直播")
    }
    
    @IBAction func shortVideoAction() {
        print("短视频")
    }
    
    @IBAction func uploadAction() {
        print("上传")
    }
    
}
