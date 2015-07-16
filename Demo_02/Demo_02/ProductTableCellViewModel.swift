//
//  TableViewCellViewModel.swift
//  Demo_02
//
//  Created by 伟明 毕 on 15/7/15.
//  Copyright (c) 2015年 Bi Weiming. All rights reserved.
//

import UIKit

class ProductTableCellViewModel: NSObject {

    let model:ProductModel
    
    var productImageViewURL:NSURL? {
        if self.model.imageURL == nil {
            return nil
        }
        return NSURL(string: ComplementedToDomainURL(self.model.imageURL!) as String)
    }
    
    var titleLabelText:String? {
        return self.model.productName
    }
    
    var sizeLabelText:String? {
        return self.model.size
    }
    
    var stockLabelText:String? {
        if self.model.storeCount == nil {
            return nil
        }
        return String(format: "%ld", self.model.storeCount!)
    }
    
    var preferentialPriceLabelText:String? {
        if self.model.stockPrice == nil {
            return nil
        }
        return RMBSymbolStringWithDecimal(self.model.stockPrice!)
    }
    
    var marketPriceLabelAttributedText:NSAttributedString? {
        if self.model.marketPrice == nil {
            return nil
        }
        
        var marketPriceStr:NSString =  RMBSymbolStringWithDecimal(self.self.model.marketPrice!).stringByAppendingString(" ")
        
        var attr:NSMutableAttributedString = NSMutableAttributedString(string: marketPriceStr as String)
        attr.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, marketPriceStr.length))
        
        return attr
    }
    
    init(model: ProductModel) {
        self.model = model
        super.init()
    }
    
}
