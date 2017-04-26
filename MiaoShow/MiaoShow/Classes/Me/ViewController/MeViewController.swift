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
    
    var array = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
        array = [["我的喵币","直播间管理","我的短视频"],["我的收益","游戏中心"],["设置"]]
        
    }
}

extension MeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = array[indexPath.section][indexPath.row]
        return cell!
    }
}
