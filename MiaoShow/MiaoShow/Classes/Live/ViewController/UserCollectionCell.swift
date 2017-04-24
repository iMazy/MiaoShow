//
//  UserCollectionCell.swift
//  MiaoShow
//
//  Created by  Mazy on 2017/4/24.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import SDWebImage

class UserCollectionCell: UICollectionViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    
    var userM: UserModel? {
        didSet {
            if let imageUrl = userM?.photo {
                userIcon.sd_setImage(with: URL(string: imageUrl))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = self.contentView.bounds.width/2
        layer.masksToBounds = true
        
    }

}
