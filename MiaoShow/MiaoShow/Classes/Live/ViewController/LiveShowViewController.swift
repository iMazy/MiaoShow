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

private let collectionReuse = "userCell"
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
    
    var userInfoView: UserInfoView?
    var coverViews: UIView?
    
    var liveModel: LiveModel?
    lazy var userSource = [UserModel]()
    
    lazy var emitterLayer = {
        return CAEmitterLayer()
    }()
    
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
        
        placeholderImage.sd_setImage(with: URL(string: (liveModel?.bigpic!)!)) { (image, _, _, _) in
            let newImage = image?.scaleRoundImage(size: CGSize(width: self.view.bounds.width, height: self.view.bounds.height), radius: 0)
            self.placeholderImage.image = newImage
        }
        
        
        self.topLeftContentView.layer.cornerRadius = self.topLeftContentView.bounds.size.height/2
        self.followButton.layer.cornerRadius = self.followButton.bounds.size.height/2
        
        if let iconImage = liveModel?.smallpic {
            userIconImageView.sd_setBackgroundImage(with: URL(string: iconImage), for: .normal, completed: { (image, _, _, _) in
                let newImage = image?.scaleRoundImage(size: CGSize(width: 30, height: 30), radius: 15)
                self.userIconImageView.setBackgroundImage(newImage, for: .normal)
            })
            
            
        }
        
        self.userNameLabel.text = liveModel?.myname
        self.watchCountLabel.text = "\(liveModel?.allnum ?? 0)人"
        
        collectionView.backgroundColor = .clear
        self.collectionView.setCollectionViewLayout(flowLayout, animated: true)
        collectionView.dataSource = self
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionReuse)
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(UINib(nibName: "UserCollectionCell", bundle: nil), forCellWithReuseIdentifier: collectionReuse)
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewReuse)
        
        
        if let path = Bundle.main.path(forResource: "user.plist", ofType: nil),let userArray = NSArray(contentsOfFile: path) {
    
            let users = Users(users: userArray as! [[String : AnyObject]])
            userSource = users.userArray
        }
        
        
        // 开始
        playWithFLV(flv: (liveModel?.flv)!)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        
       _ = setupEmitterLayer()
        
        self.collectionView.reloadData()
        
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
    
    
    @IBAction func userIconClick() {
        
        let window = UIApplication.shared.keyWindow
        let coverView = UIView(frame: (window?.bounds)!)
        coverView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(dismissInfoView))
        coverView.addGestureRecognizer(tapGes)
        coverViews = coverView
        window?.addSubview(coverView)
        
        
        let infoView = Bundle.main.loadNibNamed("UserInfoView", owner: self, options: [:])?.last as! UserInfoView
        infoView.isUserInteractionEnabled = false
        userInfoView = infoView
        
        infoView.center = view.center
        let x: CGFloat = 20
        let h: CGFloat = 420
        let w: CGFloat = view.bounds.width-2*x
        let y: CGFloat = (view.bounds.height - h)/2
        
        infoView.frame = CGRect(x: x, y: y, width: w, height: h)
        
        coverView.addSubview(infoView)
        
        self.view.bringSubview(toFront: infoView)
        infoView.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.25, delay: 0, options: [], animations: {
        infoView.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        
        
    }
    
    func dismissInfoView() {
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.userInfoView?.transform = CGAffineTransform(scaleX: 0, y: 0)
            
        }) { (_) in
        
            self.coverViews?.removeFromSuperview()
        }
    }
    
}

// MARK: - UICollectionViewDataSource,UICollectionViewDelegate
extension LiveShowViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionReuse, for: indexPath) as! UserCollectionCell
        cell.userM = userSource[indexPath.item]
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

extension LiveShowViewController {
    func setupEmitterLayer() {
        
        // 发射器在xy平面的中心位置
        emitterLayer.emitterPosition = CGPoint(x: UIScreen.main.bounds.width-50, y: UIScreen.main.bounds.height-50)
        // 发射器的尺寸大小
        emitterLayer.emitterSize = CGSize(width: 50, height: 50)
        // 渲染模式
        emitterLayer.renderMode = kCAEmitterLayerUnordered
        // 开启三维效果
        emitterLayer.preservesDepth = true
        var array = [CAEmitterCell]()
        for i in 0..<10 {
            // 发射单元
            let stepCell = CAEmitterCell()
            stepCell.birthRate = 1
            // 粒子的创建速率，默认为1/s
            stepCell.blueSpeed = 1
            // 粒子存活时间
            stepCell.lifetime = Float(arc4random_uniform(4)+1)
            // 粒子的生存时间容差
            stepCell.lifetimeRange = 1.5
            // good3_30x30
            let image = UIImage(named: "good\(i)_30x30")
            stepCell.contents = image?.cgImage
            // 粒子的运动速度
            stepCell.velocity = CGFloat(arc4random_uniform(100)+100)
            // 粒子速度的容差
            stepCell.velocityRange = 80
            // 粒子在xy平面的发射角度
            stepCell.emissionLongitude = CGFloat(M_PI + M_PI_2)
            // 粒子发射角度的容差
            stepCell.emissionRange = CGFloat(M_PI_2/6)
            // 缩放比例
            stepCell.scale = 0.5
            array.append(stepCell)
        }
        
        emitterLayer.emitterCells = array
        moviePlayer?.view.layer.addSublayer(emitterLayer)
        
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
        
        initObserver()
        
    }
    
    func initObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didFinish), name: NSNotification.Name.IJKMPMediaPlaybackIsPreparedToPlayDidChange, object: nil)
    }
    
    func didFinish() {
        // 播放完之后, 继续重播
//        self.moviePlayer?.play()
        self.placeholderImage.isHidden = true
//        self.placeholderImage = nil
    }
}

