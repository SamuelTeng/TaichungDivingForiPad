//
//  ScheduleTableViewController.h
//  TaichungDivingForiPad
//
//  Created by Samuel Teng on 2015/1/20.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,UISplitViewControllerDelegate>

@property(nonatomic,strong) NSMutableArray * domesticTour;


@end
