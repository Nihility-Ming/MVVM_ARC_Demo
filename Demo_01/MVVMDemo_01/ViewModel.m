//
//  ViewModel.m
//  MVVMDemo_01
//
//  Created by 伟明 毕 on 15/7/12.
//  Copyright (c) 2015年 Bi Weiming. All rights reserved.
//

#import "ViewModel.h"
#import <ReactiveCocoa.h>

@interface ViewModel() {
    
}

@property (strong, nonatomic, readwrite) NSString *leftOperandValue;
@property (strong, nonatomic, readwrite) NSString *rightOperandValue;
@property (assign, nonatomic, readwrite) BasicOperator basicOperator;
@property (strong, nonatomic, readwrite) NSString *resultString;
@property (strong, nonatomic, readwrite) RACCommand *calculateCommand;

@end

@implementation ViewModel


- (instancetype)init {
    if (self = [super init]) {
        @weakify(self);
        RAC(self, resultString) = [RACSignal combineLatest:@[RACObserve(self, leftOperandValue),RACObserve(self, rightOperandValue), RACObserve(self, basicOperator)] reduce:^id(NSString *v1, NSString *v2){
            @strongify(self);
            if(v1.length > 0 && v2.length > 0) {
                return [self p_calculate];
            } else {
                return nil;
            }
        }];
    }
    return self;
}

- (NSString *)p_calculate {
    NSDecimalNumber *left = [NSDecimalNumber decimalNumberWithString:self.leftOperandValue];
    NSDecimalNumber *right = [NSDecimalNumber decimalNumberWithString:self.rightOperandValue];
    switch (self.basicOperator) {
        case BasicOperatorAdd:
            self.resultString = [left decimalNumberByAdding:right].stringValue;
            break;
        case BasicOperatorSubstract:
            self.resultString = [left decimalNumberBySubtracting:right].stringValue;
            break;
        case BasicOperatorMultiply:
            self.resultString = [left decimalNumberByMultiplyingBy:right].stringValue;
            break;
        case BasicOperatorDivide:
            self.resultString = [left decimalNumberByDividingBy:right].stringValue;
            break;
        default:
            self.resultString = @"未知结果";
    }
    
    return self.resultString;
}

@end
