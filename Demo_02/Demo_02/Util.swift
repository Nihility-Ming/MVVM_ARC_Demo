//
//  Util.swift
//  Demo_02
//
//  Created by 伟明 毕 on 15/7/15.
//  Copyright (c) 2015年 Bi Weiming. All rights reserved.
//

import Foundation

let kAPIDomain:String = "http://server.e-soon.cn/"

let kDefaultPlaceholderImage = UIImage(named: "default_placeholder")

func TestAPIWithCurrentIndex(currentIndex:Int) -> String {
    return kAPIDomain.stringByAppendingFormat("json/index.ashx?aim=getproduct&seller=55531bb30012&use=1&size=15&index=%d", currentIndex)
}

func ComplementedToDomainURL<T>(URL:T) -> T {
    if URL is NSURL {
        var newURL:NSURL = URL as! NSURL
        var str:String = kAPIDomain.stringByAppendingPathComponent(newURL.absoluteString!)
        return NSURL(string: str) as! T
    } else {
        var str:String = kAPIDomain.stringByAppendingPathComponent(URL as! String)
        return str as! T
    }
}

func RMBSymbolStringWithDecimal(decimal:Double) -> String {
    return String(format: "￥%.2f", decimal)
}

let SCREEN_WIDTH: CGFloat = UIScreen.mainScreen().bounds.width
let SCREEN_HEIGHT: CGFloat = UIScreen.mainScreen().bounds.height

func AUTO_MATE_WIDTH(width: CGFloat) -> CGFloat {
    return ((width) * SCREEN_WIDTH / 320.0)
}

func AUTO_MATE_HEIGHT(height: CGFloat) -> CGFloat {
    return ((height) * SCREEN_HEIGHT / 480.0)
}
