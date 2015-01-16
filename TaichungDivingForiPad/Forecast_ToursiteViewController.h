//
//  Forecast_ToursiteViewController.h
//  TaichungDivingForiPad
//
//  Created by Samuel Teng on 2015/1/16.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Forecast_ToursiteViewController : UIViewController<UISplitViewControllerDelegate,UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *webView;

-(UIBarButtonItem*)refreshBarButton;
-(UIBarButtonItem *)stopBarButton;


@end
