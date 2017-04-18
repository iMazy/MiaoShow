//
//  LiveRecordController.swift
//  MiaoShow
//
//  Created by  Mazy on 2017/4/18.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class LiveRecordController: UIViewController {

    
    @IBOutlet weak var bottomContentView: UIImageView!
    @IBOutlet weak var bottomContraint: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        bottomContentView.layoutIfNeeded()
        bottomContentView.setNeedsLayout()


        
        
//        bottomContentView.transform = CGAffineTransform(translationX: 0, y: bottomContentView.bounds.height)
        bottomContentView.frame.origin.y += bottomContentView.bounds.height
        bottomContraint.constant -= bottomContentView.bounds.height
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 1, delay: 0, options: [.curveLinear], animations: { 
            
        }) { (_) in
            self.bottomContraint.constant += self.bottomContentView.bounds.height
        }
        
//        UIView.animate(withDuration: 0.3, delay: 0, options: [UIViewAnimationOptions.curveLinear], animations: {
////            self.bottomContentView.transform = .identity
////            self.bottomContentView.frame.origin.y -= self.bottomContentView.bounds.height
//            self.bottomContraint.constant += self.bottomContentView.bounds.height
//        }, dismiss(animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>))
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: false, completion: nil)
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
