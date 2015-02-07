//
//  Forecast_ShoreViewController.m
//  TaichungDivingForiPad
//
//  Created by Samuel Teng on 2015/1/15.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import "Forecast_ShoreViewController.h"
#import "AppDelegate.h"

@interface Forecast_ShoreViewController (){
    
    UIToolbar *toolBar;
    UIBarButtonItem *forwardButton;
    UIBarButtonItem *backwardButton;
    UIBarButtonItem *refereshButton;
    UIBarButtonItem *stopButton;
    UIBarButtonItem *fixedSpace;
    UIBarButtonItem *flexibleSpace;
    
    UIActivityIndicatorView *spinner;
    
    AppDelegate *appDelegate;
}

@end

@implementation Forecast_ShoreViewController

@synthesize webView,popoverBarButton;

-(void)loadView
{
    [super loadView];
    
    self.title = @"海面天氣";
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    self.webView.delegate = self;
    NSString *addressString = @"http://www.cwb.gov.tw/V7/forecast/fishery/NSea.htm";
    NSURL *addressUrl = [NSURL URLWithString:addressString];
    NSURLRequest* addressRequest = [NSURLRequest requestWithURL:addressUrl];
    [self.webView loadRequest:addressRequest];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    
    //UIInterfaceOrientation deviceOrientation;
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(deviceOrientation)) {
        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44)];
    }else{
        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-44, [[UIScreen mainScreen] bounds].size.width, 44)];
    }
    [self updateBarBunttonItems];
    spinner=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [self.view addSubview:self.webView];
    [self.webView addSubview:toolBar];
    //self.view.autoresizesSubviews = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.webView.frame=self.view.bounds;
    self.webView.scalesPageToFit = YES;
    spinner.frame=self.view.bounds;
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(deviceOrientation)) {
        toolBar.frame = CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44);
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    //used in ios8 and later
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    //used before rotation happen
    
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    //used during rotation
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        self.webView.frame=self.view.bounds;
        self.webView.scalesPageToFit = YES;
        spinner.frame=self.view.bounds;
        toolBar.frame = CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44);
        //NSLog(@"%ld",toolBar.barPosition);
    }else if (interfaceOrientation == UIInterfaceOrientationMaskPortrait){
        self.webView.frame=self.view.bounds;
        self.webView.scalesPageToFit = YES;
        spinner.frame=self.view.bounds;
        toolBar.frame = CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-44, [[UIScreen mainScreen] bounds].size.width, 44);
        //NSLog(@"%ld",toolBar.barPosition);
    }else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        self.webView.frame=self.view.bounds;
        self.webView.scalesPageToFit = YES;
        spinner.frame=self.view.bounds;
        toolBar.frame = CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44);
        //NSLog(@"%ld",toolBar.barPosition);
    }else{
        self.webView.frame=self.view.bounds;
        self.webView.scalesPageToFit = YES;
        spinner.frame=self.view.bounds;
        toolBar.frame = CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-44, [[UIScreen mainScreen] bounds].size.width, 44);
        //NSLog(@"%ld",toolBar.barPosition);
    }
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //used after rotation done
    /*
    if (fromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        self.webView.frame = CGRectZero;
    }else if (fromInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        self.webView.frame = CGRectZero;
    }
    */
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
}
/*
#pragma mark orientation change

-(void)orientationChanged:(NSNotification *)notification
{
    
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    
    if (UIDeviceOrientationIsLandscape(deviceOrientation)) {
        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-44, [[UIScreen mainScreen] bounds].size.width, 44)];
        [self updateBarBunttonItems];
        NSLog(@"device is Landscape");

    }else if (UIDeviceOrientationIsPortrait(deviceOrientation)){
        
        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-60, [[UIScreen mainScreen] bounds].size.width, 44)];
        [self updateBarBunttonItems];
        NSLog(@"device is portrait");
    }
    
}
*/
#pragma mark UIWebView delegate

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [spinner stopAnimating];
    [self updateBarBunttonItems];
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    spinner.color=[UIColor blackColor];
    [self.view addSubview:spinner];
    [spinner startAnimating];
    [self updateBarBunttonItems];
}

#pragma mark UIToolbar methods

-(void)updateBarBunttonItems
{
    UIBarButtonItem *refreshAndStopButton = self.webView.isLoading ? self.stopBarButton : self.refreshBarButton;
    
    fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    forwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icons.bundle/SVWebViewControllerNext"] style:UIBarButtonItemStylePlain target:self action:@selector(goForwardTapped:)];
    forwardButton.enabled = self.webView.canGoForward;
    backwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icons.bundle/SVWebViewControllerBack"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackwardTapped:)];
    backwardButton.enabled = self.webView.canGoBack;
    
    NSArray* items = [NSArray arrayWithObjects:fixedSpace,backwardButton,flexibleSpace,forwardButton,flexibleSpace,refreshAndStopButton,fixedSpace, nil];
    toolBar.barStyle= self.navigationController.navigationBar.barStyle;
    toolBar.tintColor = self.navigationController.navigationBar.tintColor;
    toolBar.items = items;
    
}

-(UIBarButtonItem*)refreshBarButton
{
    if (!refereshButton) {
        refereshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadTapped:)];
    }
    return refereshButton;
}

-(UIBarButtonItem *)stopBarButton
{
    if (!stopButton) {
        stopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopTapped:)];
    }
    return stopButton;
}

-(void)reloadTapped:(UIBarButtonItem*)sender
{
    [self.webView reload];
}

-(void)stopTapped:(UIBarButtonItem *)sender
{
    [self.webView stopLoading];
}

-(void)goForwardTapped:(UIBarButtonItem*)sender
{
    [self.webView goForward];
}

-(void)goBackwardTapped:(UIBarButtonItem*)sender
{
    [self.webView goBack];
}


#pragma mark UISplitViewController delegate
- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
    [barButtonItem setTitle:@"非潛Book "];
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
    stopButton = nil;
    refereshButton = nil;
    forwardButton = nil;
    backwardButton = nil;
    self.webView = nil;
    spinner = nil;
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
