//
//  UIImageExtension.swift
//  TestSwiftCycleImageTools
//
//  Created by  Mazy on 2017/4/20.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

extension UIImage {
    
    func scaleRoundImage(size: CGSize, radius: CGFloat = 0) -> UIImage {
        
        let newImage: UIImage?
        let imageSize = self.size
        let width = imageSize.width
        let height = imageSize.height
        let targetWidth = size.width
        let targetHeight = size.height
        var scaleFactor: CGFloat = 0.0
        var scaledWidth = targetWidth
        var scaledHeight = targetHeight
        var thumbnailPoint = CGPoint(x: 0, y: 0)
        
        
        if(__CGSizeEqualToSize(imageSize, size) == false){
            
            let widthFactor = targetWidth / width
            let heightFactor = targetHeight / height
            
            if(widthFactor > heightFactor){
                scaleFactor = widthFactor
                
            }
            else{
                scaleFactor = heightFactor
            }
            scaledWidth = width * scaleFactor
            scaledHeight = height * scaleFactor
            
            if(widthFactor > heightFactor){
                
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            }else if(widthFactor < heightFactor){
                
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
        
        var thumbnailRect = CGRect.zero
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width = scaledWidth
        thumbnailRect.size.height = scaledHeight
        
        if radius != 0 {
            
            UIColor.red.setFill()
            let path = UIBezierPath(roundedRect: CGRect(origin: CGPoint.zero, size: size), cornerRadius: radius)
            path.addClip()
        }
        
        self.draw(in: thumbnailRect)
        
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        if(newImage == nil){
            print("scale image fail")
        }
        UIGraphicsEndImageContext()
        
        guard let image = newImage else {
            return UIImage()
        }
        
        return image
    }
}
