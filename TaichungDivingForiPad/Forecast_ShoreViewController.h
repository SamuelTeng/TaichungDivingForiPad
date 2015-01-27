//
//  Forecast_ShoreViewController.h
//  TaichungDivingForiPad
//
//  Created by Samuel Teng on 2015/1/15.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Forecast_ShoreViewController : UIViewController<UISplitViewControllerDelegate,UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)UIBarButtonItem *popoverBarButton;

-(UIBarButtonItem*)refreshBarButton;
-(UIBarButtonItem *)stopBarButton;


@end
