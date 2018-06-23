//
//  ViewController.m
//  RTTextField
//
//  Created by ricky on 2018/5/19.
//  Copyright © 2018年 XcoderTips. All rights reserved.
//

#import <RTTextField/RTTextField.h>

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    __block CGFloat y = 24.f;

    NSArray <NSDictionary <NSString *, NSString *> *> *array = @[@{@"placeholder": @"只能输入手机号",
                                                                   @"pattern": RTInputTypeChineseCellPhone,
                                                                   },
                                                                 @{@"placeholder": @"只能输入价格（两位小数的浮点）",
                                                                   @"pattern": RTInputTypePrice,
                                                                   },
                                                                 @{@"placeholder": @"只能输入数字",
                                                                   @"pattern": RTInputTypeDigit,
                                                                   },
                                                                 @{@"placeholder": @"只能输入非负整数",
                                                                   @"pattern": RTInputTypeNonnegtiveInterger,
                                                                   },
                                                                 @{@"placeholder": @"只能输入非负浮点数",
                                                                   @"pattern": RTInputTypeNonnegtiveFloat,
                                                                   },
                                                                 @{@"placeholder": @"只能输入拉丁字母",
                                                                   @"pattern": RTInputTypeAlphabet,
                                                                   },
                                                                 @{@"placeholder": @"只能输入简体中文",
                                                                   @"pattern": RTInputTypeChineseSimplified,
                                                                   }];
    [array enumerateObjectsUsingBlock:^(NSDictionary<NSString *,NSString *> * obj, NSUInteger idx, BOOL * stop) {
        RTTextField *textField = [[RTTextField alloc] initWithFrame:CGRectMake(20, y, self.view.bounds.size.width - 40, 36)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.font = [UIFont systemFontOfSize:18];
        textField.placeholder = obj[@"placeholder"];
        textField.inputPattern = obj[@"pattern"];
        [self.view addSubview:textField];
        y = CGRectGetMaxY(textField.frame) + 8;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
