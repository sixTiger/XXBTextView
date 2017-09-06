//
//  XXBTextView.m
//  PIX72
//
//  Created by 杨小兵 on 15/4/21.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBTextView.h"

@interface XXBTextView()<XXBTextViewDelegate>
@property(nonatomic , weak)id<XXBTextViewDelegate> XXBTextViewdelegate;
@property(nonatomic , weak)UILabel *placeHoderLable;
@end

@implementation XXBTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupXXBTextView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupXXBTextView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.placeHoder) {
        [self p_updateLayout];
    }
}
- (void)setupXXBTextView {
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
- (void)setDelegate:(id<XXBTextViewDelegate>)delegate {
    if (delegate != nil) {
        [super setDelegate:self];
    }
    if(delegate != self) {
        _XXBTextViewdelegate = delegate;
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([self.XXBTextViewdelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [self.XXBTextViewdelegate textViewShouldBeginEditing:self];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([self.XXBTextViewdelegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.XXBTextViewdelegate textViewShouldEndEditing:self];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([self.XXBTextViewdelegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.XXBTextViewdelegate textViewDidBeginEditing:self];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([self.XXBTextViewdelegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.XXBTextViewdelegate textViewDidEndEditing:self];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([self.XXBTextViewdelegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.XXBTextViewdelegate textView:self shouldChangeTextInRange:range replacementText:text];
    }
    NSString *sumLengthString = textView.text;
    UITextRange *selectRange = [textView markedTextRange];
    UITextPosition *position = [textView positionFromPosition:selectRange.start offset:0];
    if (position) {
    } else {
        if (sumLengthString.length >= self.textLengthLimit && text.length > range.length) {
            if ([self.XXBTextViewdelegate respondsToSelector:@selector(textViewTextBeyondLengthLimit:)]) {
                [self.XXBTextViewdelegate textViewTextBeyondLengthLimit:self];
            }
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
        if ([self.XXBTextViewdelegate respondsToSelector:@selector(textViewTextBeyondLengthLimit:)]) {
            [self.XXBTextViewdelegate textViewTextBeyondLengthLimit:self];
        }
        NSString *tostring = textView.text;
        NSRange rangeRange = [tostring rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.textLengthLimit)];
        textView.text = [tostring substringWithRange:rangeRange];
    }
    
    if ([self.XXBTextViewdelegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.XXBTextViewdelegate textViewDidChange:self];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if ([self.XXBTextViewdelegate respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        [self.XXBTextViewdelegate textViewDidChangeSelection:self];
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
