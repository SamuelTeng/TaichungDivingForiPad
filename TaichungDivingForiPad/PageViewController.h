//
//  PageViewController.h
//  TaichungDivingForiPad
//
//  Created by Samuel Teng on 2015/2/2.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewController : UIPageViewController<UIPageViewControllerDelegate>

@property (nonatomic) NSUInteger startPage;
@property (nonatomic) NSUInteger _section;


@end
