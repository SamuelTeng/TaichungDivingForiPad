//
//  RootViewController.m
//  TaichungDivingForiPad
//
//  Created by Samuel Teng on 2015/1/14.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import "RootViewController.h"
#import "AppDelegate.h"
#import "Forecast_ShoreViewController.h"
#import "Forecast_ToursiteViewController.h"
#import "ScheduleTableViewController.h"
#import "ScheduleForeignTableViewController.h"
#import "LogBookTableViewController.h"

#define kSection 3
#define kLog 0
#define kWeather 1
#define kTour 2

@interface RootViewController (){
    
    AppDelegate *appDelegate;
    Forecast_ShoreViewController *shore_forecast;
    Forecast_ToursiteViewController *toursite_forecast;
    ScheduleTableViewController *domesticTour;
    ScheduleForeignTableViewController *foreignTour;
    LogBookTableViewController *logbookTable;
}

@end

@implementation RootViewController

@synthesize logArr,weatherArr,tourArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

-(id)init
{
    self = [super init];
    if (self) {
        self.title = @"非潛Book";
        
        logArr = [[NSMutableArray alloc] init];
        weatherArr = [[NSMutableArray alloc] init];
        tourArr = [[NSMutableArray alloc] init];
        
        [logArr addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"日誌首頁",@"title", nil]];
        [logArr addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"一般空氣",@"title", nil]];
        [logArr addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"高氧",@"title", nil]];
        [logArr addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"循環水肺",@"title", nil]];
        
        [weatherArr addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"海面天氣",@"title", nil]];
        [weatherArr addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"旅遊天氣",@"title", nil]];
        
        [tourArr addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"國內旅遊",@"title", nil]];
        [tourArr addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"海外旅遊",@"title", nil]];
        
        appDelegate = [[UIApplication sharedApplication] delegate];
        shore_forecast = [[Forecast_ShoreViewController alloc] init];
        toursite_forecast = [[Forecast_ToursiteViewController alloc] init];
        domesticTour = [[ScheduleTableViewController alloc] init];
        foreignTour = [[ScheduleForeignTableViewController alloc] init];
        logbookTable = [[LogBookTableViewController alloc] init];
        
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return kSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case kLog:
            return [logArr count];
            break;
            
        case kWeather:
            
            return [weatherArr count];
            break;
            
        case kTour:
            
            return [tourArr count];
            
        default:
            return 0;
            break;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"catalog";
    
    UITableViewCell *cell=[tableView1 dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    NSArray *current;
    switch (indexPath.section) {
        case kLog:
            current = logArr;
            break;
            
        case kWeather:
            current = weatherArr;
            break;
            
        case kTour:
            current = tourArr;
            break;
            
        default:
            break;
    }
    NSDictionary *rowData=[current objectAtIndex:indexPath.row];
    cell.textLabel.text=[rowData objectForKey:@"title"];
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case kLog:
            return @"潛水日誌";
            break;
            
        case kWeather:
            return @"氣象資訊";
            break;
            
        case kTour:
            return @"旅遊行程";
            break;
            
        default:
            return nil;
            break;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUInteger row = indexPath.row;
    [appDelegate.splitviewcontroller viewWillDisappear:YES];
    NSMutableArray *viewControllerArray = [[NSMutableArray alloc] initWithArray:[[appDelegate.splitviewcontroller.viewControllers objectAtIndex:1] viewControllers]];
    [viewControllerArray removeLastObject];
    
    switch (indexPath.section) {
        case kLog:
            if (row == 0) {
                [viewControllerArray addObject:logbookTable];
                appDelegate.splitviewcontroller.delegate = logbookTable;
            }
            
            break;
        case kWeather:
            
            if (row == 0) {
                [viewControllerArray addObject:shore_forecast];
                appDelegate.splitviewcontroller.delegate = shore_forecast;
            }else if (row == 1){
                [viewControllerArray addObject:toursite_forecast];
                appDelegate.splitviewcontroller.delegate = toursite_forecast;
            }
            break;
        case kTour:
            
            if (row == 0) {
                [viewControllerArray addObject:domesticTour];
                appDelegate.splitviewcontroller.delegate = domesticTour;
            }else if (row == 1){
                [viewControllerArray addObject:foreignTour];
                appDelegate.splitviewcontroller.delegate = foreignTour;
            }
            
            break;
            
        default:
            break;
    }
    
    [[appDelegate.splitviewcontroller.viewControllers objectAtIndex:1] setViewControllers:viewControllerArray animated:NO];
    [appDelegate.splitviewcontroller viewWillAppear:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
