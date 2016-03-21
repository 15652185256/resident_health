//
//  FullScreenViewController.m
//  MyFullScreenNavigation
//
//  Created by 朱封毅 on 02/08/15.
//  Copyright (c) 2015年 card. All rights reserved.
//

#import "FullScreenViewController.h"

@interface FullScreenViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation FullScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    //创建一个全屏滑动手势，调用系统的自带滑动手势的action方法
    UIPanGestureRecognizer  * pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate =self;
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = NO;
}

-(void)handleNavigationTransition:(UIPanGestureRecognizer*)tap
{
    
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    /**
     *  跟视图控制器的时候不需要全屏
     */
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
