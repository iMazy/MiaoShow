//
//  XMTabBarController.swift
//  MiaoShow
//
//  Created by  Mazy on 2017/4/7.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class XMTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置颜色
        tabBar.tintColor = UIColor.init(colorLiteralRed: 255/255.0, green: 48/255.0, blue: 148/255.0, alpha: 1.0)
        
        addChildVC(className: "LiveViewController", title: "直播", image: "toolbar_home")
        addChildVC(className: "VideoViewController", title: "视频", image: "toolbar_video")
        addChildVC(className: "ShowViewController", title: "", image: "toolbar_live")
        addChildVC(className: "GameViewController", title: "游戏", image: "toolbar_game")
        addChildVC(className: "MeViewController", title: "我的", image: "toolbar_me")
        
        self.delegate = self
    }
    
    private func addChildVC(className:String, title: String, image:String) {
        
        /// 通过映射创建控制器
        guard let cls = NSClassFromString(Bundle.main.nameSpace + "." + className) as?
            XMBaseViewController.Type else { return }
        let vc = cls.init()
        
        // 如果是录制直播，不设置title和选中图像
        if (title != "") {
            vc.title = title
            vc.tabBarItem.selectedImage = UIImage(named: image + "_sel")?.withRenderingMode(.alwaysOriginal)
        }
        vc.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        let nav = XMNavigationController(rootViewController: vc)
        self.addChildViewController(nav)
        
    }
    
    /// 获取中间的UITabBarButton 并将位置下移动
    override func viewWillLayoutSubviews() {
        
        let tabbarbtn = self.tabBar.subviews[3]
        tabbarbtn.frame.origin.y = 7
        
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if self.selectedIndex == 3 {
            print("点击了直播按钮")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension XMTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if (viewController as! UINavigationController).title == nil  {
            let liveRD = LiveRecordController()
            liveRD.providesPresentationContextTransitionStyle = true
            liveRD.definesPresentationContext = true
            liveRD.modalPresentationStyle = .overCurrentContext
            present(liveRD, animated: false, completion: nil)
            return false
        } else {
            return true
        }
    }
    
    /// 
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let transition =  CATransition()
        transition.type = kCATransitionFade
        view.layer.add(transition, forKey: nil)
    }
}
