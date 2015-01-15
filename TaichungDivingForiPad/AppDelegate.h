//
//  AppDelegate.h
//  TaichungDivingForiPad
//
//  Created by Samuel Teng on 2015/1/14.
//  Copyright (c) 2015年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "RootViewController.h"
#import "DetailViewController.h"

#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    Reachability *reachability;

}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) UISplitViewController *splitviewcontroller;
@property (nonatomic,strong) UINavigationController *naviRoot;
@property (nonatomic,strong) UINavigationController *naviDetail;
@property (nonatomic,strong) RootViewController *rootViewController;
@property (nonatomic,strong) DetailViewController *detailViewController;
@property (nonatomic,strong) UIBarButtonItem *rootPopoverButtonItem;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

