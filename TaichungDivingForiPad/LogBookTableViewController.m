//
//  LogBookTableViewController.m
//  TaichungDivingForiPad
//
//  Created by Samuel Teng on 2015/2/2.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import "LogBookTableViewController.h"
#import "AppDelegate.h"
#import "DiveLog.h"
#import "PageViewController.h"


@interface LogBookTableViewController (){
    
    AppDelegate *delegate_logbook;
    DiveLog *diveLog;
    PageViewController *pageViewController;
}

@end

@implementation LogBookTableViewController

@synthesize resultController;

-(void)fetchData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"DiveLog" inManagedObjectContext:delegate_logbook.managedObjectContext]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:descriptors];
    
    NSError *error;
    resultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:delegate_logbook.managedObjectContext sectionNameKeyPath:@"date" cacheName:nil];
    resultController.delegate = self;
    if (![resultController performFetch:&error]) {
        NSLog(@"error : %@", [error localizedFailureReason]);
    }
}

-(void)loadView
{
    [super loadView];
     delegate_logbook = [[UIApplication sharedApplication] delegate];
    pageViewController = [[PageViewController alloc] init];
    
    /*the below is not helpful*/
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchData];
    
    if (! resultController.fetchedObjects.count) {
        UIAlertView *noLog = [[UIAlertView alloc] initWithTitle:@"無日誌記錄" message:@"沒有日誌記錄，請選擇邊欄任一類別日誌新增一筆日誌或\"取消\"回到主頁面" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [noLog show];
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUInteger count = resultController.fetchedObjects.count;
    NSString *countOfLogs = [NSString stringWithFormat:@"目前支數:%lu",(unsigned long)count];
    self.navigationItem.title = countOfLogs;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return [[resultController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [[[resultController sections] objectAtIndex:section]numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basic cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"basic cell"];
    }
    
    NSManagedObject *managedObject = [resultController objectAtIndexPath:indexPath];
    
    NSString *timeStr = [managedObject valueForKey:@"date"];
    
    
    cell.textLabel.text = timeStr;
    
    // Configure the cell...
    
    
    
    
    
    return cell;

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSError *error = nil;
        [delegate_logbook.managedObjectContext deleteObject:[resultController objectAtIndexPath:indexPath]];
        if (![delegate_logbook.managedObjectContext save:&error]) {
            NSLog(@"Error: %@", [error localizedFailureReason]);
        }
        
        //[_logDatabase fetchData];
        
        [self fetchData];
        
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    pageViewController.startPage = indexPath.row;//*((int *)indexPath.row);
    pageViewController._section = indexPath.section;//*((int *)indexPath.section);
    [delegate_logbook.naviDetail pushViewController:pageViewController animated:YES];
    
    //NSLog(@"table: row= %i section = %i", indexPath.row, indexPath.section);
}

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
    [barButtonItem setTitle:@"非潛Book"];
    [[self navigationItem] setLeftBarButtonItem:barButtonItem];
    delegate_logbook.rootPopoverButtonItem = barButtonItem;
}

- (void)splitViewController:(UISplitViewController *)svc
    willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode
{
    /*used in ios8 and later*/
    NSLog(@"ios version is 8.0 or above");
    
    if (displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
        [svc.displayModeButtonItem setTitle:@"非潛Book"];
        [[self navigationItem] setLeftBarButtonItem:svc.displayModeButtonItem];
        //self.navigationItem.leftBarButtonItem = svc.displayModeButtonItem;
        //self.navigationItem.leftItemsSupplementBackButton = true;
        delegate_logbook.rootPopoverButtonItem = svc.displayModeButtonItem;
    }else{
        [[self navigationItem] setLeftBarButtonItem:nil];
        delegate_logbook.rootPopoverButtonItem = nil;
    }
}

- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)button
{
    [[self navigationItem] setLeftBarButtonItem:nil];
    delegate_logbook.rootPopoverButtonItem = nil;
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
