//
//  UserInfoView.swift
//  MiaoShow
//
//  Created by  Mazy on 2017/4/29.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import SDWebImage

class UserInfoView: UIView {
    
    var userModel: LiveModel? {
        didSet {
            iconImageView.sd_setImage(with: URL(string: (userModel?.smallpic!)!))
            anchorName.text = userModel?.myname
            idxLabel.text = "IDX: \(userModel?.allnum ?? 0)"
            location.text = userModel?.gps
            signatures.text = userModel?.signatures
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var anchorName: UILabel!
    
    @IBOutlet weak var idxLabel: UILabel!
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var signatures: UILabel!
    
    var userClose:(() -> Void)?
    
    @IBAction func userCloseAction(_ sender: UIButton) {
        
        if let userClose = userClose {
            userClose()
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = iconImageView.bounds.width/2
        iconImageView.layer.masksToBounds = true
        
        
    }
   
}
