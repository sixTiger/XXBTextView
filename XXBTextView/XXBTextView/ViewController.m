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
    self.textView = [[XXBTextView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:self.textView];
    self.textView.text = @"a";
    
    self.textView.placeHoder = @"请输入请输入请输入请输入请输入请输入请输入请输入请输入请输入请输入请输入请输入";
}
@end
