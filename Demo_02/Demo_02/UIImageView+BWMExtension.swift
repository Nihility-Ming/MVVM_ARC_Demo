//
//  UIImageView+BWMExtension.swift
//  Demo_02
//
//  Created by 伟明 毕 on 15/7/16.
//  Copyright (c) 2015年 Bi Weiming. All rights reserved.
//

import Foundation

extension UIImageView {
    
    /*** 添加移动到指定Point的动画 */
    func bwm_transferToPoint(targetPoint:CGPoint) -> Void {
        var window:UIWindow = UIApplication.sharedApplication().keyWindow!
        let rootFrame:CGRect = window.convertRect(self.frame, fromView: self.superview)
        
        var newImage:UIImageView = UIImageView(image: self.image)
        newImage.frame = rootFrame
        newImage.backgroundColor = self.backgroundColor
        newImage.layer.cornerRadius = self.layer.cornerRadius
        newImage.layer.masksToBounds = self.layer.masksToBounds
        UIApplication.sharedApplication().keyWindow?.addSubview(newImage)
        
        UIView.animateWithDuration(1.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            newImage.center = targetPoint
            newImage.alpha = 0.0
            newImage.transform = CGAffineTransformScale(newImage.transform, 0.2, 0.2)
            }) { (finish:Bool) -> Void in
                if finish {
                    newImage.removeFromSuperview()
                }
        }
    }
    
}