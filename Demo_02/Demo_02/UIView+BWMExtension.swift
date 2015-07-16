//
//  UIView+BWMExtension.swift
//  Demo_02
//
//  Created by 伟明 毕 on 15/7/15.
//  Copyright (c) 2015年 Bi Weiming. All rights reserved.
//

import Foundation

extension UIView {

    func bwm_drawingDefaultStyleShadow() {
        var shadowPath:UIBezierPath = UIBezierPath(rect: CGRectMake(0, 0, AUTO_MATE_WIDTH(self.frame.size.width), self.frame.size.height))
        self.layer.masksToBounds = false;
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSizeMake(0.0, 3.0)
        self.layer.shadowOpacity = 0.15;
        self.layer.shadowPath = shadowPath.CGPath;
    }
    
}