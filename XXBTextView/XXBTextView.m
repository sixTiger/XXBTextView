//
//  XXBTextView.m
//  PIX72
//
//  Created by 杨小兵 on 15/4/21.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBTextView.h"

@interface XXBTextView()<UITextViewDelegate>
@property(nonatomic , weak)id<UITextViewDelegate> XXBTextViewDelegate;
@property(nonatomic , weak)UILabel *placeHoderLable;
@end

@implementation XXBTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupMTTextView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupMTTextView];
    }
    return self;
}

- (void)setupMTTextView {
    [self setDelegate:self];
    self.textLengthLimit = NSIntegerMax;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeHoderLable.font = font;
    if (self.placeHoder) {
        [self p_updateLayout];
    }
}

- (void)setPlaceHoderColor:(UIColor *)placeHoderColor {
    _placeHoderColor = placeHoderColor;
    self.placeHoderLable.textColor = placeHoderColor;
}

- (void)setPlaceHoder:(NSString *)placeHoder {
    _placeHoder = [placeHoder copy];
    self.placeHoderLable.text = _placeHoder;
    if(self.font) {
        [self p_updateLayout];
    }
}

- (void)p_updateLayout {
    CGFloat pading = 5;
    UIEdgeInsets edgeInset = self.textContainerInset;
    CGRect rect = self.bounds;
    CGSize placehoderSize = [self sizeWithSting:_placeHoder Fount:self.font withMaxSize:CGSizeMake(rect.size.width - edgeInset.right - edgeInset.left - pading * 2, MAXFLOAT)];
    self.placeHoderLable.frame = CGRectMake(edgeInset.left + pading, edgeInset.top, placehoderSize.width, placehoderSize.height);
}
#pragma mark - 代理处理
- (void)setDelegate:(id<UITextViewDelegate>)delegate {
    if (delegate != nil) {
        [super setDelegate:self];
    }
    if(delegate != self) {
        _XXBTextViewDelegate = delegate;
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([self.XXBTextViewDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [self.XXBTextViewDelegate textViewShouldBeginEditing:self];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([self.XXBTextViewDelegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.XXBTextViewDelegate textViewShouldEndEditing:self];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([self.XXBTextViewDelegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.XXBTextViewDelegate textViewDidBeginEditing:self];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([self.XXBTextViewDelegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.XXBTextViewDelegate textViewDidEndEditing:self];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([self.XXBTextViewDelegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.XXBTextViewDelegate textView:self shouldChangeTextInRange:range replacementText:text];
    }
    NSString *sumLengthString = textView.text;
    UITextRange *selectRange = [textView markedTextRange];
    UITextPosition *position = [textView positionFromPosition:selectRange.start offset:0];
    if (position) {
    } else {
        if (sumLengthString.length >= self.textLengthLimit && text.length > range.length) {
            return NO;
        }
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
    if (self.text.length >0) {
        self.placeHoderLable.hidden = YES;
    } else {
        self.placeHoderLable.hidden = NO;
    }
    
    if (textView.markedTextRange == nil && self.textLengthLimit > 0 && self.text.length > self.textLengthLimit) {
        NSString *tostring = textView.text;
        NSRange rangeRange = [tostring rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.textLengthLimit)];
        textView.text = [tostring substringWithRange:rangeRange];
    }
    
    if ([self.XXBTextViewDelegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.XXBTextViewDelegate textViewDidChange:self];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if ([self.XXBTextViewDelegate respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        [self.XXBTextViewDelegate textViewDidChangeSelection:self];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange {
    return YES;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    if (attributedText.string.length > 0) {
        self.placeHoderLable.hidden = YES;
    } else {
        self.placeHoderLable.hidden = NO;
    }
}

- (void)setText:(NSString *)text {
    [super setText:text];
    if (text.length > 0) {
        self.placeHoderLable.hidden = YES;
    } else {
        self.placeHoderLable.hidden = NO;
    }
}

- (UILabel *)placeHoderLable {
    if(_placeHoderLable == nil) {
        UILabel *placeHoderLable = [[UILabel alloc] initWithFrame:self.bounds];
        placeHoderLable.numberOfLines = 0;
        placeHoderLable.font = self.font;
        [self addSubview:placeHoderLable];
        _placeHoderLable = placeHoderLable;
    }
    return _placeHoderLable;
}

/**
 *  计算字符串所占的位置的大小
 *
 *  @param string  要计算大小的字符串
 *  @param fount   文字的
 *  @param maxSize 预设的最大的大小
 *
 *  @return 计算好的大小
 */
- (CGSize)sizeWithSting:(NSString *)string Fount:(UIFont *)fount withMaxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : fount};
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
