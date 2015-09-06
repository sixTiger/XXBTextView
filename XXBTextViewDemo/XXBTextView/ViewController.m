//
//  ViewController.m
//  XXBTextView
//
//  Created by 杨小兵 on 15/4/22.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "ViewController.h"
#import "XXBTextView.h"

@interface ViewController ()
@property (strong, nonatomic) XXBTextView *textView;

@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textView = [[XXBTextView alloc] initWithFrame:CGRectMake(10, 64, [UIScreen mainScreen].bounds.size.width - 20, 100)];
    [self.view addSubview:self.textView];
    self.textView.font = [UIFont systemFontOfSize:20];
    self.textView.text = @"a";
    self.textView.placeHoder = @"请输入请输入请输入请输入请输入请输入请输入请输入请输入请输入请输入请输入请输入";
    self.textView.placeHoderColor = [UIColor grayColor];
}
@end
