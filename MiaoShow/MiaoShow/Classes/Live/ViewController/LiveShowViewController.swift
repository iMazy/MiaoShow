//
//  LiveShowViewController.swift
//  MiaoShow
//
//  Created by  Mazy on 2017/4/9.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import IJKMediaFramework

class LiveShowViewController: XMBaseViewController {
    // 左上角内容视图
    @IBOutlet weak var topLeftContentView: UIView!
    // 用户图像
    @IBOutlet weak var userIconImageView: UIButton!
    // 用户名称
    @IBOutlet weak var userNameLabel: UILabel!
    // 观看人数
    @IBOutlet weak var watchCountLabel: UILabel!
    // 关注按钮
    @IBOutlet weak var followButton: UIButton!
    // 右上角观看用户混动视图
    @IBOutlet weak var collectionView: UICollectionView!
    // 聊天展示视图
    @IBOutlet weak var tableView: UITableView!
    
    var liveModel: LiveModel?
    
    var moviePlayer: IJKFFMoviePlayerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        playWithFLV(flv: (liveModel?.flv)!)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        moviePlayer?.shutdown()
        moviePlayer?.view.removeFromSuperview()
        moviePlayer = nil
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func leaveRoom() {
        _ = navigationController?.popViewController(animated: true)
    }
}

// MARK: - 直播播放
extension LiveShowViewController {
    
    func playWithFLV(flv: String) {
        let options = IJKFFOptions.byDefault()
        options?.setPlayerOptionIntValue(1, forKey: "videotoolbox")
        // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
        options?.setPlayerOptionIntValue(Int64(29.97), forKey: "r")
        // -vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
        options?.setPlayerOptionIntValue(512, forKey: "vol")
        
        moviePlayer = IJKFFMoviePlayerController(contentURLString: flv, with: options)
        moviePlayer?.view.frame = UIScreen.main.bounds
        // 视图填充样式
        moviePlayer?.scalingMode = .fill
        // 设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
        moviePlayer?.shouldAutoplay = true
        moviePlayer?.shouldShowHudView = false
        view.insertSubview((moviePlayer?.view)!, at: 0)
        
        moviePlayer?.prepareToPlay()
        
    }
}

