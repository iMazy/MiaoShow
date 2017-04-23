//
//  FilterImageViewController.swift
//  MiaoShow
//
//  Created by  Mazy on 2017/4/23.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import GPUImage

class FilterImageViewController: UIViewController {
    
    var closeAction: (()->())?
    
    // 创建视频源
    // SessionPreset:屏幕分辨率，AVCaptureSessionPresetHigh会自适应高分辨率
    // cameraPosition:摄像头方向
    let videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPresetHigh, cameraPosition: AVCaptureDevicePosition.front)
    // 创建最终预览View
    let captureVideoPreview = GPUImageView(frame: UIScreen.main.bounds)
    
    // 磨皮滤镜(美颜)
    let bilateralFilter = GPUImageBilateralFilter()
    // 美白滤镜
    let brightnessFilter = GPUImageBrightnessFilter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置为竖屏
        videoCamera?.outputImageOrientation = .portrait
        // 添加预览图层到最一个
        view.insertSubview(captureVideoPreview, at: 0)
        
        let groupFilter = GPUImageFilterGroup()
        // 将磨皮和美白滤镜加入到滤镜组
        groupFilter.addTarget(bilateralFilter)
        groupFilter.addTarget(brightnessFilter)
        
        // 设置滤镜组链
        bilateralFilter.addTarget(brightnessFilter)
        // 设置起始的滤镜
        groupFilter.initialFilters = [bilateralFilter]
        // 设置最后一个滤镜
        groupFilter.terminalFilter = brightnessFilter
        
        videoCamera?.addTarget(groupFilter)
        groupFilter.addTarget(captureVideoPreview)
        
        videoCamera?.startCapture()
        
    }
    
    /// 重写touchBegin 阻止响应链
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    @IBAction func closeCapture(_ sender: UIButton) {
        videoCamera?.stopCapture()
        captureVideoPreview.removeFromSuperview()
        dismiss(animated: true) { 
             self.closeAction!()
        }
    }
    
    /// 切换摄像头
    @IBAction func switctAction(_ sender: UIButton) {
        videoCamera?.rotateCamera()
    }

}
