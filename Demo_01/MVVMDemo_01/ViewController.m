//
//  ViewController.m
//  MVVMDemo_01
//
//  Created by 伟明 毕 on 15/7/12.
//  Copyright (c) 2015年 Bi Weiming. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"
#import <ReactiveCocoa.h>

@interface ViewController () {
    ViewModel *_viewModel;
}

@property (strong, nonatomic) IBOutlet UITextField *leftOperandTF;      // 左操作数TextField
@property (strong, nonatomic) IBOutlet UITextField *rightOperandTF;     // 右操作数TextField
@property (strong, nonatomic) IBOutlet UISegmentedControl *operationSC; // 操作符SegmentedControl
@property (strong, nonatomic) IBOutlet UILabel *resultLabel;            // 显示结果的Label

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _viewModel = [[ViewModel alloc] init];
    
    RAC(_viewModel, leftOperandValue) = self.leftOperandTF.rac_textSignal;
    RAC(_viewModel, rightOperandValue) = self.rightOperandTF.rac_textSignal;
    RAC(_viewModel, basicOperator) = [self.operationSC rac_newSelectedSegmentIndexChannelWithNilValue:@0];
    RAC(self.resultLabel, text) = RACObserve(_viewModel, resultString);
}


@end
