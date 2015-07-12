//
//  MVVMDemo_01Tests.m
//  MVVMDemo_01Tests
//
//  Created by 伟明 毕 on 15/7/12.
//  Copyright (c) 2015年 Bi Weiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface MVVMDemo_01Tests : XCTestCase

@end

@implementation MVVMDemo_01Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
