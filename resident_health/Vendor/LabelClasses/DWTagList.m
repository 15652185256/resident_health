//
//  DWTagList.m
//
//  Created by Dominic Wroblewski on 07/07/2012.
//  Copyright (c) 2012 Terracoding LTD. All rights reserved.
//

#import "DWTagList.h"
#import <QuartzCore/QuartzCore.h>

#define CORNER_RADIUS 6.0f
#define LABEL_MARGIN 20.0f
#define BOTTOM_MARGIN 17.0f
#define FONT_SIZE 15.0f
#define HORIZONTAL_PADDING 12.0f
#define VERTICAL_PADDING 9.0f
#define BACKGROUND_COLOR CREATECOLOR(246, 246, 246, 1)
#define TEXT_COLOR CREATECOLOR(51, 51, 51, 1)
#define BORDER_COLOR CREATECOLOR(214, 214, 214, 1).CGColor
#define BORDER_WIDTH 1.0f

@implementation DWTagList

@synthesize view, textArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:view];
    }
    return self;
}

- (CGFloat)setTags:(NSArray *)array
{
    textArray = [[NSArray alloc] initWithArray:array];
    sizeFit = CGSizeZero;
    return [self display];
}

- (CGFloat)display
{
    for (UILabel *subview in [self subviews]) {
        [subview removeFromSuperview];
    }
    float totalHeight = 0;
    CGRect previousFrame = CGRectZero;
    BOOL gotPreviousFrame = NO;
    int tapNumber=0;
    for (NSString * text in textArray) {
        CGSize textSize;
        if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0) {
            textSize = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:CGSizeMake(self.frame.size.width, 1500) lineBreakMode:NSLineBreakByCharWrapping];
        }
        else
        {
            textSize = [text boundingRectWithSize:CGSizeMake(self.frame.size.width, 1500) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]} context:nil].size;
        }
        textSize.width += HORIZONTAL_PADDING * 2;
        textSize.height += VERTICAL_PADDING * 2;
        UILabel * label = nil;
        if (!gotPreviousFrame) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
            totalHeight = textSize.height;
        } else {
            CGRect newRect = CGRectZero;
            if (previousFrame.origin.x + previousFrame.size.width + textSize.width + LABEL_MARGIN > self.frame.size.width) {
                newRect.origin = CGPointMake(0, previousFrame.origin.y + textSize.height + BOTTOM_MARGIN);
                totalHeight += textSize.height + BOTTOM_MARGIN;
            } else {
                newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + LABEL_MARGIN, previousFrame.origin.y);
            }
            newRect.size = textSize;
            label = [[UILabel alloc] initWithFrame:newRect];
        }
        previousFrame = label.frame;
        gotPreviousFrame = YES;
        
        label.font=[UIFont systemFontOfSize:FONT_SIZE];
        label.backgroundColor=BACKGROUND_COLOR;
        label.textColor=TEXT_COLOR;
        label.text=text;
        label.textAlignment=NSTextAlignmentCenter;
        
        label.layer.masksToBounds = YES ;
        label.layer.cornerRadius =CORNER_RADIUS;
        label.layer.borderColor=BORDER_COLOR;
        label.layer.borderWidth=BORDER_WIDTH;
        
        [self addSubview:label];
        label.tag=3000+tapNumber;
        label.userInteractionEnabled=YES;
        
        UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1Action:)];
        //设置点击次数
        tap1.numberOfTapsRequired = 1;
        //设置几根胡萝卜有效
        tap1.numberOfTouchesRequired = 1;
        [label addGestureRecognizer:tap1];
        
        tapNumber++;
    }
    sizeFit = CGSizeMake(self.frame.size.width, totalHeight + 1.0f);
    
    return totalHeight;
}


//收起键盘
-(void)tap1Action:(UITapGestureRecognizer*)tap
{
    //NSLog(@"%ld",tap.view.tag-3000);
    if (self.myBlock) {
        self.myBlock(tap.view.tag-3000);
    }
}


- (CGSize)fittedSize
{
    return sizeFit;
}

@end
