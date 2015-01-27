//
//  DetailViewController.m
//  TaichungDivingForiPad
//
//  Created by Samuel Teng on 2015/1/14.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController (){
    
    AppDelegate *appDelegate;
}

@end

@implementation DetailViewController

-(void)loadView
{
    [super loadView];
    appDelegate = [[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
