//
//  LiveTableViewCell.swift
//  MiaoShow
//
//  Created by  Mazy on 2017/4/8.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import SDWebImage

class LiveTableViewCell: UITableViewCell {
    
    var liveModel: LiveModel? {
        didSet {
            anchorImageView.sd_setImage(with: URL(string: (liveModel?.bigpic)!))
            anchorIconView.sd_setImage(with: URL(string:(liveModel?.smallpic)!), placeholderImage: UIImage(named:"placeholder_head"))
            
            anchorNameLabel.text = liveModel?.myname ?? ""
            anchorGpsLabel.text = liveModel?.gps ?? ""
            viewdNumLabel.text = "\(liveModel?.allnum ?? 0)"
            
        }
    }
    
    /// 主播封面图片
    @IBOutlet weak var anchorImageView: UIImageView!
    /// 主播图像
    @IBOutlet weak var anchorIconView: UIImageView!
    /// 主播昵称
    @IBOutlet weak var anchorNameLabel: UILabel!
    /// 主播位置
    @IBOutlet weak var anchorGpsLabel: UILabel!
    /// 直播的等级
    @IBOutlet weak var anchorStarImage: UIImageView!
    /// 当前观看人数
    @IBOutlet weak var viewdNumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
