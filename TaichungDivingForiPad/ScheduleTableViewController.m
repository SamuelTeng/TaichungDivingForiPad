//
//  ScheduleTableViewController.m
//  TaichungDivingForiPad
//
//  Created by Samuel Teng on 2015/1/20.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import "ScheduleTableViewController.h"
#import "TourDetailViewController.h"
#import "AppDelegate.h"


@interface ScheduleTableViewController (){
    AppDelegate *appDelegate;
    TourDetailViewController *tourDetailView;

}

@end

@implementation ScheduleTableViewController
@synthesize domesticTour;

-(id)init
{
    self = [super init];
    if (self) {
        self.title = @"國內旅遊";
        appDelegate = [[UIApplication sharedApplication] delegate];
        domesticTour=[[NSMutableArray alloc]init];
        
        [domesticTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"東北角潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=E5_2D",@"url", nil]];
        [domesticTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"琉球嶼潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=E2_2D",@"url", nil]];
        [domesticTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"綠島潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=E3_3D",@"url", nil]];
        [domesticTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"蘭嶼潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=E4_3D",@"url", nil]];
        [domesticTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"澎湖潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=E6_2D",@"url", nil]];
        [domesticTour addObject:[[NSDictionary alloc]initWithObjectsAndKeys:@"墾丁潛水旅遊",@"page",@"http://www.td-club.com.tw/Travels.asp?ID=E1_2D",@"url", nil]];
        
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

    // Return the number of rows in the section.
    return [domesticTour count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier=@"DivingTour";
    UITableViewCell *cell=[tableView1 dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    NSArray *current;
    current=domesticTour;
    
    NSDictionary *rowData=[current objectAtIndex:indexPath.row];
    cell.textLabel.text=[rowData objectForKey:@"page"];
    cell.detailTextLabel.text=[rowData objectForKey:@"url"];
    cell.detailTextLabel.textColor=[UIColor whiteColor];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *current=domesticTour;
    NSDictionary *selectedPage=[current objectAtIndex:indexPath.row];
    
    
    tourDetailView.pageData=selectedPage;
    [self.navigationController pushViewController:tourDetailView animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark UISplitViewController delegate
- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
    [barButtonItem setTitle:@"目錄"];
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
