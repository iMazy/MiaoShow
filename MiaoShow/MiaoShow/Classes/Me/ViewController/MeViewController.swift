//
//  MeViewController.swift
//  MiaoShow
//
//  Created by  Mazy on 2017/4/7.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class MeViewController: XMBaseViewController {
    
    let tableView: UITableView = {
        return UITableView(frame: UIScreen.main.bounds, style: .grouped)
    }()
    
    var imageArray = [[String]]()
    var titleArray = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
        titleArray = [["我的喵币","直播间管理","我的短视频"],["我的收益","游戏中心"],["设置"]]
        imageArray = [["my_coin","live_manager","shortVideo"],["income","game_center"],["setting"]]
        
        let headerView = Bundle.main.loadNibNamed("MeHeaderViwe", owner: nil, options: [:])?.last as? MeHeaderViwe
        
        
        headerView?.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: view.bounds.width, height: 200))
        tableView.tableHeaderView = headerView
        
        tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0)
        
        tableView.sectionFooterHeight = 0
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

extension MeViewController: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.accessoryType = .disclosureIndicator
        cell?.imageView?.image = UIImage(named: imageArray[indexPath.section][indexPath.row])
        cell?.textLabel?.text = titleArray[indexPath.section][indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
