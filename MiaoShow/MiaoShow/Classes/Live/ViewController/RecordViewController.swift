//
//  RecordViewController.swift
//  MiaoShow
//
//  Created by  Mazy on 2017/4/19.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

/// 导入框架
import AVFoundation

class RecordViewController: UIViewController {
    
    var closeAction: (()->())?
    
    /// 懒加载session任务
    fileprivate lazy var session:AVCaptureSession = AVCaptureSession()
    /// 懒加载预览视图
    fileprivate lazy var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    
    /// 设置音视频采集的现场，防止线程结束
    fileprivate lazy var videoQueue = DispatchQueue.global()
    fileprivate lazy var audioQueue = DispatchQueue.global()
    /// 保存输入输出源
    fileprivate var videoIpt: AVCaptureDeviceInput?
    fileprivate var videoOpt: AVCaptureVideoDataOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 开始录制
        startCapture()
        
    }
}

// MARK: - 视频的开始采集&停止采集
extension RecordViewController {
    
    /// 开始采集
    fileprivate func startCapture() {
        
        // 1.设置视频的输入输出
        setupVideo()
        // 2.设置音频的输入输出
        setupAudio()
        // 3.给用户看见一个预览图层（可选）
        previewLayer.frame = UIScreen.main.bounds
        view.layer.insertSublayer(previewLayer, at: 0)
        // 4.开始采集
        session.startRunning()
        
    }
    
    
    /// 停止采集
    @IBAction func stopCapture() {
        session.stopRunning()
        previewLayer.removeFromSuperlayer()
        
        session.removeInput(videoIpt)
        session.removeOutput(videoOpt)
        
        
        dismiss(animated: true) {
            self.closeAction!()
        }
        
    }
    
    
    /// 切换前后摄像头
    @IBAction func switchCamera() {
        // 1.获取之前的镜头
        guard var position = videoIpt?.device.position else {
            return
        }
        // 2.获取当前应该显示的镜头
        position = position == .front ? .back : .front
        // 3.根据当前镜头创建新的Device
        let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as? [AVCaptureDevice]
        guard let device = devices?.filter({ $0.position == position}).first else {
            return
        }
        // 4.根据新的Device创建新的Input
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else {
            return
        }
        
        // 5.在session中切换Input
        session.beginConfiguration() // 开始配置
        session.removeInput(self.videoIpt) // 移除输入源
        session.addInput(videoInput)        // 添加输入源
        session.commitConfiguration() // 完成配置
        
        self.videoIpt = videoInput
    }
    
}

// MARK: - Description
extension RecordViewController {
    
    /// 设置视频相关
    fileprivate func setupVideo() {
        
        // 1.给捕捉回话设置输入源
        // 1.1 获取摄像头设备
        guard let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as? [AVCaptureDevice] else {
            return
        }
        /*
         let divice = devices.filter { (device: AVCaptureDevice) -> Bool in
         return device.position == .front
         }.first
         */
        // $0意思是取出闭包的第一个参数
        let device = devices.filter({$0.position == .front}).first
        // 1.2 通过device创建AVCaptureInput对象
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else {
            return
        }
        videoIpt = videoInput
        // 1.3 将input添加到会话中
        session.addInput(videoInput)
        // 2.给捕捉会话设置输出源
        let videoOutput = AVCaptureVideoDataOutput()
        videoOpt = videoOutput
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        session.addOutput(videoOutput)
        
        // 3.获取video对应的connection
        //        connection = videoOutput.connection(withMediaType: AVMediaTypeVideo)
        
    }
    
    /// 设置音频相关
    fileprivate func setupAudio() {
        // 1.设置音频的输入（话筒）
        // 1.1 获取话筒设备
        guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio) else {
            return
        }
        // 1.2 根据device创建AVCaptureInput
        guard let audioInput = try? AVCaptureDeviceInput(device: device) else {
            return
        }
        // 1.3 将input添加到会话中
        session.addInput(audioInput)
        // 2 给会话设置音频输出源
        let audioOutput = AVCaptureAudioDataOutput()
        audioOutput.setSampleBufferDelegate(self, queue: audioQueue)
        session.addOutput(audioOutput)

    }
}


// MARK: - 获取数据
extension RecordViewController: AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate {
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        
        if connection == self.videoOpt?.connection(withMediaType: AVMediaTypeVideo) {
            print("采集到视频画面")
        } else {
            print("采集到音频画面")
        }
    }
}
