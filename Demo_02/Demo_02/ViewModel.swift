//
//  ViewModel.swift
//  Demo_02
//
//  Created by 伟明 毕 on 15/7/15.
//  Copyright (c) 2015年 Bi Weiming. All rights reserved.
//

import UIKit

class ViewModel: NSObject {
    
    let cellIdentity: String = "ProductTableViewCell"
    
    lazy var cellNib: UINib = UINib(nibName: "ProductTableViewCell", bundle: nil)
    
    let productModels: NSMutableArray = NSMutableArray()
    
    let selectedProductModels: NSMutableArray = NSMutableArray()
    
    dynamic var needRefreshTableView:Bool = false
    
    dynamic var isNoMoreData:Bool = false
    
    dynamic var isError = false
    
    dynamic var isEndRefreshing = false
    
    dynamic var isChangePrompt = false
    
    private var currentIndex:Int = 0
    
    private var buyAmount:Int = 0
    
    var prompt: String {
        return "显示总数: \(self.productModels.count)  已选择: \(self.selectedProductModels.count)个  已购买: \(self.buyAmount)个"
    }
    
    func isAddBtnSelectedWithProductTableCellViewModel(viewModel:ProductTableCellViewModel) -> Bool {
        return self.selectedProductModels.containsObject(viewModel)
    }
    
    private var networkingSignal:RACSignal {
        return RACSignal.createSignal({ (subscriber:RACSubscriber!) -> RACDisposable! in
            
            var requestURLString:String = TestAPIWithCurrentIndex(self.currentIndex)
            
            BWMRequestCenter.GET(requestURLString, parameters: nil, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
                if var dict:NSDictionary = responseObject as? NSDictionary {
                    var sequence:RACSequence = dict.objectForKey("productList")!.rac_sequence
                    var resultArray = sequence.map({ (theDict:AnyObject!) -> AnyObject! in
                        var productModel = ProductModel(dict: theDict as! NSDictionary)
                        var subViewModel:ProductTableCellViewModel = ProductTableCellViewModel(model: productModel)
                        return subViewModel
                    }).array
                    subscriber.sendNext(resultArray)
                    subscriber.sendCompleted()
                    self.isEndRefreshing = true
                }
                }, failure: { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                    self.isEndRefreshing = true
                    subscriber.sendError(error)
            })
            
            return nil
        })
    }
    
    func refreshData() {
        self.currentIndex = 1
        self.buyAmount = 0
        self.networkingSignal.deliverOn(RACScheduler.mainThreadScheduler()).subscribeNext({ (responseObject:AnyObject!) -> Void in
            if var models:NSArray = responseObject as? NSArray {
                self.productModels.removeAllObjects()
                self.selectedProductModels.removeAllObjects()
                self.productModels.addObjectsFromArray(models as! Array)
                self.needRefreshTableView = true
                self.isChangePrompt = true
            }
            }, error: { (error:NSError!) -> Void in
                self.isError = true
        }) { () -> Void in
        }
    }
    
    func loadMoreData() {
        self.currentIndex++
        self.networkingSignal.deliverOn(RACScheduler.mainThreadScheduler()).subscribeNext({ (responseObject:AnyObject!) -> Void in
            if var models:NSArray = responseObject as? NSArray {
                if models.count > 0 {
                    self.productModels.addObjectsFromArray(models as! Array)
                    self.needRefreshTableView = true
                    self.isChangePrompt = true
                } else {
                    self.isNoMoreData = true
                }
            }
            }, error: { (error:NSError!) -> Void in
                self.isError = true
                self.currentIndex--
            }) { () -> Void in
        }
        
    }
    
    func addProduct(viewModel:ProductTableCellViewModel) {
        self.selectedProductModels.addObject(viewModel)
        self.isChangePrompt = true
    }
    
    func removeProduct(ViewModel:ProductTableCellViewModel) {
        self.selectedProductModels.removeObject(ViewModel)
        self.isChangePrompt = true
    }
    
    func shopping() -> NSArray {
        var willRemoveIndexPaths:NSArray = self.selectedProductModels.rac_sequence.map { (model:AnyObject!) -> AnyObject! in
            return NSIndexPath(forRow: self.productModels.indexOfObject(model), inSection: 0)
        }.array
        
        self.buyAmount+=willRemoveIndexPaths.count
        
        self.productModels.removeObjectsInArray(self.selectedProductModels as Array)
        
        self.selectedProductModels.removeAllObjects()
        
        self.isChangePrompt = true
        
        return willRemoveIndexPaths
    }
    
    func hasProduct() -> Bool {
        return self.selectedProductModels.count>0
    }
    
}
