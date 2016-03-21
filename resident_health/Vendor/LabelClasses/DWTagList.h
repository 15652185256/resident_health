//
//  DWTagList.h
//
//  Created by Dominic Wroblewski on 07/07/2012.
//  Copyright (c) 2012 Terracoding LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWTagList : UIView
{
    UIView * view;
    NSArray * textArray;
    CGSize sizeFit;
    UIColor * lblBackgroundColor;
}

@property (nonatomic, strong) UIView * view;
@property (nonatomic, strong) NSArray * textArray;

- (CGFloat)setTags:(NSArray *)array;
- (CGFloat)display;
- (CGSize)fittedSize;

//传值
@property(nonatomic,copy)void(^myBlock)(NSInteger);

@end
