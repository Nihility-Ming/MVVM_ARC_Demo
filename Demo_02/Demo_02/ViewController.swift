//
//  ViewController.swift
//  Demo_02
//
//  Created by 伟明 毕 on 15/7/15.
//  Copyright (c) 2015年 Bi Weiming. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var viewModel: ViewModel = ViewModel()

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configUI()
        self.bindData()
        self.actions()
    }
    
    private func configUI() {
        self.tableView.registerNib(viewModel.cellNib, forCellReuseIdentifier: viewModel.cellIdentity)
        
        self.tableView.footer = MJRefreshAutoNormalFooter(refreshingBlock: { () -> Void in
            self.viewModel.loadMoreData()
        })
        
        self.tableView.footer.hidden = true
        
        self.tableView.header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            self.viewModel.refreshData()
        })
        
    }
    
    private func bindData() {
        
        RACObserve(self.viewModel, "needRefreshTableView").ignore(false).deliverOn(RACScheduler.mainThreadScheduler()).subscribeNext { (needRefreshTableView:AnyObject!) -> Void in
            self.tableView.reloadData()
        }
        
        RACObserve(self.viewModel, "isNoMoreData").ignore(false).deliverOn(RACScheduler.mainThreadScheduler()).subscribeNext { (isNoMoreData:AnyObject!) -> Void in
            self.tableView.footer.noticeNoMoreData()
        }
        
        RACObserve(self.viewModel, "isError").ignore(false).deliverOn(RACScheduler.mainThreadScheduler()).subscribeNext { (isError:AnyObject!) -> Void in
            BWMMBProgressHUD.showTitle(kBWMMBProgressHUDLoadErrorMsg, toView: self.view, hideAfter: kBWMMBProgressHUDHideTimeInterval, msgType: .Error)
        }
        
        RACObserve(self.viewModel, "isEndRefreshing").ignore(false).deliverOn(RACScheduler.mainThreadScheduler()).subscribeNext { (isError:AnyObject!) -> Void in
            self.tableView.footer.hidden = false
            self.tableView.header.endRefreshing()
            self.tableView.footer.endRefreshing()
        }
        
        RACObserve(self.viewModel, "isChangePrompt").ignore(false).deliverOn(RACScheduler.mainThreadScheduler()).subscribeNext { (isChangePrompt:AnyObject!) -> Void in
            self.navigationItem.prompt = self.viewModel.prompt
        }
        
    }
    
    private func actions() {
        self.tableView.header.beginRefreshing()
    }
    
    @IBAction func openMenu(sender: UIBarButtonItem) {
        if self.viewModel.hasProduct() {
            UIActionSheet(title: "购买商品?", delegate: self, cancelButtonTitle: "放弃", destructiveButtonTitle: "我要购买").showInView(self.view)
        } else {
            BWMMBProgressHUD.showTitle("还没选择商品", toView: self.view, hideAfter: kBWMMBProgressHUDHideTimeInterval, msgType: .Warning)
        }
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.productModels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: ProductTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.viewModel.cellIdentity) as! ProductTableViewCell
        var cellViewModel:ProductTableCellViewModel = self.viewModel.productModels.objectAtIndex(indexPath.row) as! ProductTableCellViewModel
        cell.updateWithViewModel(cellViewModel)
        cell.delegate = self
        cell.addBtn.selected = self.viewModel.isAddBtnSelectedWithProductTableCellViewModel(cellViewModel)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var cellViewModel:ProductTableCellViewModel = self.viewModel.productModels.objectAtIndex(indexPath.row) as! ProductTableCellViewModel
        
        struct Static {
            static var cell:ProductTableViewCell?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token, { () -> Void in
            Static.cell = tableView.dequeueReusableCellWithIdentifier(self.viewModel.cellIdentity) as? ProductTableViewCell
        })
        
        return Static.cell!.heightWithViewModel(cellViewModel)
    }
    
}

extension ViewController : ProductTableViewCellDelegate {
    func productTableViewCell(cell:ProductTableViewCell, addBtnClicked:UIButton, targetModel:ProductTableCellViewModel) {
        if addBtnClicked.selected {
            self.viewModel.addProduct(targetModel)
        } else {
            self.viewModel.removeProduct(targetModel)
        }
    }
    
    func productTableViewCell(cell:ProductTableViewCell, copyBtnClicked:UIButton, targetModel:ProductTableCellViewModel) {
        BWMMBProgressHUD.showTitle("复制成功", toView: self.view, hideAfter: kBWMMBProgressHUDHideTimeInterval, msgType: BWMMBProgressHUDMsgType.Successful)
    }
    
    func productTableViewCell(cell:ProductTableViewCell, sharedBtnClicked:UIButton, targetModel:ProductTableCellViewModel) {
        BWMMBProgressHUD.showTitle("分享成功", toView: self.view, hideAfter: kBWMMBProgressHUDHideTimeInterval, msgType: BWMMBProgressHUDMsgType.Successful)
    }
}

extension ViewController: UIActionSheetDelegate {
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == actionSheet.destructiveButtonIndex {
            self.tableView.deleteRowsAtIndexPaths(self.viewModel.shopping() as Array, withRowAnimation: .Fade)
        }
    }
}
