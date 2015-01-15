//
//  RootViewController.h
//  TaichungDivingForiPad
//
//  Created by Samuel Teng on 2015/1/14.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>



@property (nonatomic,strong) NSMutableArray *logArr;
@property (nonatomic,strong) NSMutableArray *weatherArr;
@property (nonatomic,strong) NSMutableArray *tourArr;



@end
