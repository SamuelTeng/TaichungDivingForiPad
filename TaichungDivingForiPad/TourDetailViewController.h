//
//  TourDetailViewController.h
//  TaichungDivingForiPad
//
//  Created by Samuel Teng on 2015/1/20.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TourDetailViewController : UIViewController<UIWebViewDelegate,UISplitViewControllerDelegate>

@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)NSDictionary *pageData;

@end
