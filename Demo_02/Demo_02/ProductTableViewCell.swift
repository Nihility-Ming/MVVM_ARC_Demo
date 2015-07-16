//
//  ProductTableViewCell.swift
//  Demo_02
//
//  Created by 伟明 毕 on 15/7/15.
//  Copyright (c) 2015年 Bi Weiming. All rights reserved.
//

import UIKit

protocol ProductTableViewCellDelegate: NSObjectProtocol {
    func productTableViewCell(cell:ProductTableViewCell, addBtnClicked:UIButton, targetModel:ProductTableCellViewModel)
    func productTableViewCell(cell:ProductTableViewCell, copyBtnClicked:UIButton, targetModel:ProductTableCellViewModel)
    func productTableViewCell(cell:ProductTableViewCell, sharedBtnClicked:UIButton, targetModel:ProductTableCellViewModel)
}

class ProductTableViewCell: UITableViewCell {
    
    var viewModel: ProductTableCellViewModel!
    
    @IBOutlet var mainBGView: UIView!
    @IBOutlet var toolView: UIView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet var stockLabel: UILabel!
    @IBOutlet var preferentialPriceLabel: UILabel!
    @IBOutlet var marketPriceLabel: UILabel!
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var copyBtn: UIButton!
    @IBOutlet var sharedBtn: UIButton!
    
    weak var delegate:ProductTableViewCellDelegate?
    
    func updateWithViewModel(viewModel:ProductTableCellViewModel?) -> (Void) {
        if viewModel == nil { return }
        
        self.viewModel = viewModel
        
        self.productImageView.sd_setImageWithURL(self.viewModel.productImageViewURL, placeholderImage: kDefaultPlaceholderImage, options: .RefreshCached)
        self.titleLabel.text = self.viewModel.titleLabelText
        self.sizeLabel.text = self.viewModel.sizeLabelText
        self.stockLabel.text = self.viewModel.stockLabelText
        self.preferentialPriceLabel.text = self.viewModel.preferentialPriceLabelText
        self.marketPriceLabel.attributedText = self.viewModel.marketPriceLabelAttributedText
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clearColor()
        self.titleLabel.preferredMaxLayoutWidth = AUTO_MATE_WIDTH(self.titleLabel.frame.size.width)
        
    }
    
    func heightWithViewModel(viewModel:ProductTableCellViewModel) -> CGFloat {
        self.updateWithViewModel(viewModel)
        return self.mainBGView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height + self.toolView.frame.size.height + 10.0
    }
    
    @IBAction func addBtnClicked(sender: UIButton) {
        sender.selected = !sender.selected
        
        self.delegate?.productTableViewCell(self, addBtnClicked: sender, targetModel: self.viewModel)
        
        self.productImageView.bwm_transferToPoint(CGPointMake(SCREEN_WIDTH-20.0, 50.0))
    }
    
    @IBAction func copyBtnClicked(sender: UIButton) {
        self.delegate?.productTableViewCell(self, copyBtnClicked: sender, targetModel: self.viewModel)
    }
    
    @IBAction func sharedBtnClicked(sender: UIButton) {
        self.delegate?.productTableViewCell(self, sharedBtnClicked: sender, targetModel: self.viewModel)
    }

}
