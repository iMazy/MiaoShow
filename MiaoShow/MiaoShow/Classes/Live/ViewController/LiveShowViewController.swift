//
//  LiveShowViewController.swift
//  MiaoShow
//
//  Created by  Mazy on 2017/4/9.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import IJKMediaFramework
import SDWebImage

private let collectionReuse = "collectionIdentifier"
private let tableViewReuse = "tableViewIdentifier"

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
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
       let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.itemSize = CGSize(width: 36, height: 36)
        flowLayout.minimumLineSpacing = 5
        return flowLayout
    }()
    
    @IBOutlet weak var placeholderImage: UIImageView!
    
    var moviePlayer: IJKFFMoviePlayerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.placeholderImage.image = liveModel?.bigImage
        self.topLeftContentView.layer.cornerRadius = self.topLeftContentView.bounds.size.height/2
        self.followButton.layer.cornerRadius = self.followButton.bounds.size.height/2
        self.userIconImageView.layer.cornerRadius = self.userIconImageView.bounds.size.height/2
        self.userIconImageView.layer.masksToBounds = true
        
        
        
        collectionView.backgroundColor = .clear
        self.collectionView.setCollectionViewLayout(flowLayout, animated: true)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionReuse)
        collectionView.showsHorizontalScrollIndicator = false
        
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewReuse)
        
        // 开始
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

// MARK: - UICollectionViewDataSource,UICollectionViewDelegate
extension LiveShowViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionReuse, for: indexPath)
        cell.backgroundColor = .red
        cell.layer.cornerRadius = cell.bounds.size.width/2
        return cell
    }
}

// MARK: - UICollectionViewDataSource
extension LiveShowViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewReuse)!
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
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
        
//        self.placeholderImage.removeFromSuperview()
//        self.placeholderImage = nil
        
        initObserver()
        
    }
    
    func initObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didFinish), name: NSNotification.Name.IJKMPMediaPlaybackIsPreparedToPlayDidChange, object: nil)
    }
    
    func didFinish() {
        // 播放完之后, 继续重播
//        self.moviePlayer?.play()
        self.placeholderImage.removeFromSuperview()
        self.placeholderImage = nil
    }
}

