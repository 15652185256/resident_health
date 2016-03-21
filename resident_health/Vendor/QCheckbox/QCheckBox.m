//
//  EICheckBox.m
//  EInsure
//
//  Created by ivan on 13-7-9.
//  Copyright (c) 2013年 ivan. All rights reserved.
//

#import "QCheckBox.h"

#define Q_CHECK_ICON_WH                    (19.0)
#define Q_ICON_TITLE_MARGIN                (3.0)

@implementation QCheckBox

@synthesize delegate = _delegate;
@synthesize checked = _checked;
@synthesize userInfo = _userInfo;

- (id)initWithDelegate:(id)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        
        self.exclusiveTouch = YES;
        [self setImage:[UIImage imageNamed:@"checkbox1_unchecked@2x"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"checkbox1_checked@2x"] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(checkboxBtnChecked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setChecked:(BOOL)checked {
    if (_checked == checked) {
        return;
    }
    
    _checked = checked;
    self.selected = checked;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCheckBox:checked:)]) {
        [_delegate didSelectedCheckBox:self checked:self.selected];
    }
}

- (void)checkboxBtnChecked {
    self.selected = !self.selected;
    _checked = self.selected;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCheckBox:checked:)]) {
        [_delegate didSelectedCheckBox:self checked:self.selected];
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    if (WIDTH>320) {
        return CGRectMake(0, PAGESIZE(8), Q_CHECK_ICON_WH, Q_CHECK_ICON_WH+1);
    }
    else{
        return CGRectMake(0, PAGESIZE(6), Q_CHECK_ICON_WH, Q_CHECK_ICON_WH+1);
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(Q_CHECK_ICON_WH + Q_ICON_TITLE_MARGIN, 0,
                      CGRectGetWidth(contentRect) - Q_CHECK_ICON_WH - Q_ICON_TITLE_MARGIN,
                      CGRectGetHeight(contentRect));
}


@end
