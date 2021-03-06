//
//  AppDelegate.m
//  TaichungDivingForiPad
//
//  Created by Samuel Teng on 2015/1/14.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize splitviewcontroller,rootViewController,detailViewController,naviDetail,naviRoot;
@synthesize rootPopoverButtonItem;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.splitviewcontroller = [[UISplitViewController alloc] init];
    self.splitviewcontroller.presentsWithGesture = YES;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        NSLog(@"os version above ios7.1");
        self.splitviewcontroller.preferredDisplayMode = UISplitViewControllerDisplayModeAutomatic;
    }
    self.rootViewController = [[RootViewController alloc] init];
    self.detailViewController = [[DetailViewController alloc] init];
    self.naviRoot = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    
    self.naviDetail = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    
    self.splitviewcontroller.viewControllers = [NSArray arrayWithObjects:naviRoot,naviDetail, nil];
    self.splitviewcontroller.delegate = self.detailViewController;
    
    self.window.rootViewController = self.splitviewcontroller;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

/*Called by Reachability whenever status changes.*/
-(void)reachabilityChanged:(NSNotification *)note
{
    
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability: curReach];
}

/*Implementation for Network status notification*/
- (void)updateInterfaceWithReachability:(Reachability *)curReach
{
    NetworkStatus curStatus;
    
    BOOL m_bReachableViaWWAN;
    BOOL m_bReachableViaWifi;
    BOOL m_bReachable;
    //  According to curReach, modify current internal flags
    
    //  Internet reachability
    //  Need network status to know real reachability method
    curStatus = [curReach currentReachabilityStatus];
    
    //  Modify current network status flags
    if (curStatus == ReachableViaWWAN) {
        m_bReachableViaWWAN = true;
    } else {
        m_bReachableViaWWAN = false;
    }
    
    if (curStatus == ReachableViaWiFi) {
        m_bReachableViaWifi = true;
    } else {
        m_bReachableViaWifi = false;
    }
    
    //  Reachable is the OR result of two internal connection flags
    m_bReachable = (m_bReachableViaWifi || m_bReachableViaWWAN);
    
    if (!m_bReachable) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"注意" message:@"無法連結網路\n請檢查wifi或行動網路設定" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [av show];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "ST.TaichungDivingForiPad" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TaichungDivingForiPad" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TaichungDivingForiPad.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
