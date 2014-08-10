//
//  RWTAppDelegate.m
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 20/05/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTAppDelegate.h"
#import "RWTFlickrSearchViewController.h"
#import "RWTFlickrSearchViewModel.h"
#import "RWTFlickrSearch-Swift.h"
#import "RWTViewModelServicesImpl.h"

@interface RWTAppDelegate ()

// private properties
@property (nonatomic, retain) UINavigationController *navigationController;
@property (strong, nonatomic) SwiftFlickrSearchViewModel *viewModel;
@property (strong, nonatomic) RWTViewModelServicesImpl *viewModelServices;

@end

@implementation RWTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // create a navigation controller and perform some simple styling
    self.navigationController = [UINavigationController new];
    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
  
    // create and navigate to a view controller
    SwiftFlickrSearchViewController *viewController = [self createInitialViewController];
    NSLog(@"view controller %@", viewController);
    NSLog(@"%@", viewController.searchButton);
    [self.navigationController pushViewController:viewController animated:YES];

    // show the navigation controller
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (SwiftFlickrSearchViewController *)createInitialViewController {
    self.viewModelServices = [RWTViewModelServicesImpl new];
    self.viewModel = [[SwiftFlickrSearchViewModel alloc] initWithServices:self.viewModelServices];
    return [[SwiftFlickrSearchViewController alloc] initWithViewModel:self.viewModel];
}

@end
