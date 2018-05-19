//
//  RTTextFieldTests.m
//  RTTextFieldTests
//
//  Created by ricky on 2018/5/19.
//  Copyright © 2018年 XcoderTips. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RTTextField.h"

@interface RTTextFieldTests : XCTestCase

@end

@implementation RTTextFieldTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testComposedCharacterLength {
    {
        NSString *str = nil;
        XCTAssert(str.rt_composedCharacterLength == 0);
    }

    {
        NSString *str = @"";
        XCTAssert(str.rt_composedCharacterLength == 0);
    }

    {
        NSString *str = @" ";
        XCTAssert(str.rt_composedCharacterLength == 1);
    }

    {
        NSString *str = @"abcd";
        XCTAssert(str.rt_composedCharacterLength == 4);
    }

    {
        NSString *str = @"中文";
        XCTAssert(str.rt_composedCharacterLength == 2);
    }

    {
        NSString *str = @"😃😄😁🤣";
        XCTAssert(str.rt_composedCharacterLength == 4);
    }

    {
        NSString *str = @"😃🤡⛹🏿‍♀️⚫️🤥🤕💪🏾";
        XCTAssert(str.rt_composedCharacterLength == 7);
    }

    {
        NSString *str = @"‱⁇₧₯₪℃❥🀏🀗";
        XCTAssert(str.rt_composedCharacterLength == 9);
    }

    {
        NSString *str = @"abcd中文";
        XCTAssert(str.rt_composedCharacterLength == 6);
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
