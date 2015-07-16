//
//  ProductModel.swift
//  Demo_02
//
//  Created by 伟明 毕 on 15/7/15.
//  Copyright (c) 2015年 Bi Weiming. All rights reserved.
//

import UIKit

class ProductModel: NSObject {
    
    var productID:String?     // 产品ID
    var imageURL:String?         // 产品图片
    var productName:String?   // 产品名称
    var size:String?          // 规格
    var storeCount:NSInteger?   // 库存数量
    var stockPrice:Double?      // 优惠价格
    var marketPrice:Double?     // 市场价格
    var saleNum:NSInteger?      // 销售数 
    var startSaleDate:String? // 开始销售的时间
    
    init(dict:NSDictionary) {

        self.productID = dict["id"] as? String
        self.imageURL = dict["mainImgUrl"] as? String
        self.productName = dict["productName"] as? String
        self.size = dict["_size"] as? String
        self.storeCount = dict["_number"]?.integerValue
        self.stockPrice = dict["_finalPrice"]?.doubleValue
        self.marketPrice = dict["_marketPrice"]?.doubleValue
        self.saleNum = dict["saleNum"]?.integerValue
        self.startSaleDate = dict["onSaleDate"] as? String
        
        super.init()
    }
    
}
