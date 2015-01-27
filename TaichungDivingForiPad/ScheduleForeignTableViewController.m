//
//  ScheduleForeignTableViewController.m
//  TaichungDivingForiPad
//
//  Created by Samuel Teng on 2015/1/27.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import "ScheduleForeignTableViewController.h"
#import "TourDetailViewController.h"
#import "AppDelegate.h"

@interface ScheduleForeignTableViewController (){
    AppDelegate *appDelegate;
    TourDetailViewController *tourDetailView;
    
}


@end

@implementation ScheduleForeignTableViewController

@synthesize foreignTour;

-(id)init
{
    self = [super init];
    if (self) {
        self.title = @"國內旅遊";
        appDelegate = [[UIApplication sharedApplication] delegate];
        foreignTour=[[NSMutableArray alloc]init];
        
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"馬爾地夫船宿潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=G1_9D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"斯米蘭船宿潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=G3_6D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"蘇祿海船宿潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=G4_7D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"大堡礁潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F05_9D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"明多洛潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F10_6D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"帛琉潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F12_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"西巴丹潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F16_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"刁曼島潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F18_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"莫亞礁潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F19_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"阿尼洛潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F01_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"杜馬蓋地潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F03_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"薄荷島潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F02_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"沖繩島潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F11_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"普吉島潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F13_5D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"馬拉杜阿潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F21_6D",@"url", nil]];
        [foreignTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"土蘭奔潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=F20_6D",@"url", nil]];
        
        tourDetailView = [[TourDetailViewController alloc] init];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [foreignTour count];
}
                                

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier=@"DivingTour";
    UITableViewCell *cell=[tableView1 dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    NSArray *current;
    current=foreignTour;
    
    NSDictionary *rowData=[current objectAtIndex:indexPath.row];
    cell.textLabel.text=[rowData objectForKey:@"page"];
    cell.detailTextLabel.text=[rowData objectForKey:@"url"];
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *current=foreignTour;
    NSDictionary *selectedPage=[current objectAtIndex:indexPath.row];
            
            
    tourDetailView.pageData=selectedPage;
    [self.navigationController pushViewController:tourDetailView animated:YES];
}
                                
                                
#pragma mark UISplitViewController delegate
- (void)splitViewController:(UISplitViewController *)svc
willHideViewController:(UIViewController *)aViewController
withBarButtonItem:(UIBarButtonItem *)barButtonItem
forPopoverController:(UIPopoverController *)pc
{
   [barButtonItem setTitle:@"非潛Book"];
   [[self navigationItem] setLeftBarButtonItem:barButtonItem];
    appDelegate.rootPopoverButtonItem = barButtonItem;
}
                                
- (void)splitViewController:(UISplitViewController *)svc
willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode
{
    /*used in ios8 and later*/
    NSLog(@"ios version is 8.0 or above");
            
    if (displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
      [[self navigationItem] setLeftBarButtonItem:svc.displayModeButtonItem];
      appDelegate.rootPopoverButtonItem = svc.displayModeButtonItem;
    }else{
      [[self navigationItem] setLeftBarButtonItem:nil];
      appDelegate.rootPopoverButtonItem = nil;
    }
}
                                
- (void)splitViewController:(UISplitViewController *)svc
willShowViewController:(UIViewController *)aViewController
invalidatingBarButtonItem:(UIBarButtonItem *)button
{
   [[self navigationItem] setLeftBarButtonItem:nil];
   appDelegate.rootPopoverButtonItem = nil;
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
