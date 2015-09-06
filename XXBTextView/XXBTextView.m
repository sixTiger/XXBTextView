//
//  XXBTextView.m
//  PIX72
//
//  Created by 杨小兵 on 15/4/21.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBTextView.h"

@interface XXBTextView()<UITextViewDelegate>
@property(nonatomic , weak)id<UITextViewDelegate> XXBTextViewdelegate;
@property(nonatomic , weak)UILabel *placeHoderLable;
@end

@implementation XXBTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupXXBTextView];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupXXBTextView];
    }
    return self;
}
- (void)setupXXBTextView
{
    [self setDelegate:self];
    self.textLengthLimit = NSIntegerMax;
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeHoderLable.font = font;
    if (self.placeHoder)
    {
        [self adjustPlacehoderFrame];
    }
}
- (void)setPlaceHoderColor:(UIColor *)placeHoderColor
{
    _placeHoderColor = placeHoderColor;
    self.placeHoderLable.textColor = placeHoderColor;
}
- (void)setPlaceHoder:(NSString *)placeHoder
{
    _placeHoder = [placeHoder copy];
    self.placeHoderLable.text = _placeHoder;
    if(self.font)
    {
        [self adjustPlacehoderFrame];
    }
}
- (void)adjustPlacehoderFrame
{
    UIEdgeInsets edgeInset = self.textContainerInset;
    CGRect rect = self.bounds;
    CGSize placehoderSize = [self sizeWithSting:_placeHoder Fount:self.font withMaxSize:CGSizeMake(rect.size.width - edgeInset.right - edgeInset.left - 5, MAXFLOAT)];
    self.placeHoderLable.frame = CGRectMake(edgeInset.left + 5, edgeInset.top, placehoderSize.width, placehoderSize.height);
}
#pragma mark - 代理处理
- (void)setDelegate:(id<UITextViewDelegate>)delegate
{
    [super setDelegate:self];
    if(delegate != self)
    {
        _XXBTextViewdelegate = delegate;
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.XXBTextViewdelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [self.XXBTextViewdelegate textViewShouldBeginEditing:self];
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([self.XXBTextViewdelegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.XXBTextViewdelegate textViewShouldEndEditing:self];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.XXBTextViewdelegate respondsToSelector:@selector(textViewDidBeginEditing:)])
    {
        [self.XXBTextViewdelegate textViewDidBeginEditing:self];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self.XXBTextViewdelegate respondsToSelector:@selector(textViewDidEndEditing:)])
    {
        [self.XXBTextViewdelegate textViewDidEndEditing:self];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([self.XXBTextViewdelegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.XXBTextViewdelegate textView:self shouldChangeTextInRange:range replacementText:text];
    }
    if (textView.text.length >= self.textLengthLimit && text.length > range.length) {
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (self.text.length >0)
    {
        self.placeHoderLable.hidden = YES;
    }
    else
    {
        self.placeHoderLable.hidden = NO;
    }
    if (textView.markedTextRange == nil && self.textLengthLimit > 0 && self.text.length > self.textLengthLimit)
    {
        textView.text = [textView.text substringToIndex:self.textLengthLimit];
    }
    if ([self.XXBTextViewdelegate respondsToSelector:@selector(textViewDidChange:)])
    {
        [self.XXBTextViewdelegate textViewDidChange:self];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if ([self.XXBTextViewdelegate respondsToSelector:@selector(textViewDidChangeSelection:)])
    {
        [self.XXBTextViewdelegate textViewDidChangeSelection:self];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    return YES;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    if (attributedText.string.length > 0)
    {
        self.placeHoderLable.hidden = YES;
    }
    else
    {
        self.placeHoderLable.hidden = NO;
    }
}
- (void)setText:(NSString *)text
{
    [super setText:text];
    if (text.length > 0)
    {
        self.placeHoderLable.hidden = YES;
    }
    else
    {
        self.placeHoderLable.hidden = NO;
    }
}
- (UILabel *)placeHoderLable
{
    if(_placeHoderLable == nil)
    {
        UILabel *placeHoderLable = [[UILabel alloc] initWithFrame:self.bounds];
        placeHoderLable.numberOfLines = 0;
        placeHoderLable.font = self.font;
        [self addSubview:placeHoderLable];
        _placeHoderLable = placeHoderLable;
    }
    return _placeHoderLable;
}
- (CGSize)sizeWithSting:(NSString *)string Fount:(UIFont *)fount withMaxSize:(CGSize)maxSize;
{
    NSDictionary *attrs = @{NSFontAttributeName : fount};
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
