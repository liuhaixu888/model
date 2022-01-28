//
//  RSCheckBox.m
//  RSCheckBox
//
//  Created by founderbn on 16/6/6.
//  Copyright © 2016年 founderbn. All rights reserved.
//

#import "RSCheckBox.h"

@implementation RSCheckBox

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)setText:(NSString *)text
{
    if (_text!=text) {
        _text=text;
        [self setTitle:text forState:UIControlStateNormal];
    }
    
}
-(void)setTextColor:(UIColor *)textColor
{
    if (_textColor!=textColor) {
        _textColor=textColor;
        [self setTitleColor:textColor forState:UIControlStateNormal];
    }
    
}
-(void)setTextFont:(UIFont *)textFont
{
    if (_textFont!=textFont) {
        _textFont=textFont;
        self.titleLabel.font=textFont;
    }
}
-(void)setSelectedImgName:(NSString *)selectedImgName
{
    if (_selectedImgName!=selectedImgName) {
        _selectedImgName=selectedImgName;
        [self setImage:[UIImage imageNamed:selectedImgName] forState:UIControlStateSelected];
    }
}
-(void)setUnSelectedImgName:(NSString *)unSelectedImgName
{
    if (_unSelectedImgName!=unSelectedImgName) {
        _unSelectedImgName=unSelectedImgName;
        [self setImage:[UIImage imageNamed:unSelectedImgName] forState:UIControlStateNormal];
    }
}

-(void)commonInit
{
    [self setTitle:_text forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font=[UIFont systemFontOfSize:17];
    [self setImage:[UIImage imageNamed:@"checkbox1_unchecked"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"checkbox1_checked"] forState:UIControlStateSelected];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(10, (CGRectGetHeight(contentRect) - Q_CHECK_ICON_WH)/2.0, Q_CHECK_ICON_WH, Q_CHECK_ICON_WH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(Q_CHECK_ICON_WH + Q_ICON_TITLE_MARGIN+10, 0,
                      CGRectGetWidth(contentRect) - Q_CHECK_ICON_WH - Q_ICON_TITLE_MARGIN,
                      CGRectGetHeight(contentRect));
}


@end
