//
//  XXBTextView.h
//  PIX72
//
//  Created by 杨小兵 on 15/4/21.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXBTextView : UITextView
/**
 *  占位文本
 */
@property(nonatomic , copy)NSString         *placeHoder;
/**
 *  占位文本的颜色
 */
@property(nonatomic , strong)UIColor        *placeHoderColor;
/**
 *  文本的长度
 */
@property(nonatomic , assign)NSInteger      textLengthLimit;
@end
