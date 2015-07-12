//
//  ViewModel.h
//  MVVMDemo_01
//
//  Created by 伟明 毕 on 15/7/12.
//  Copyright (c) 2015年 Bi Weiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OperatorEnum.h"

@class RACCommand;


@interface ViewModel : NSObject

@property (strong, nonatomic, readonly) NSString *leftOperandValue;
@property (strong, nonatomic, readonly) NSString *rightOperandValue;
@property (assign, nonatomic, readonly) BasicOperator basicOperator;
@property (strong, nonatomic, readonly) NSString *resultString;

@end
