//
//  AppDelegate.m
//  MovieSearch
//
//  Created by Christian Graver Larsen on 03/07/15.
//  Copyright (c) 2015 gravr. All rights reserved.
//

#import "MSAppDelegate.h"
#import "MSSearchViewModel.h"
#import "MSSearchViewController.h"
#import "MSViewModelServicesImpl.h"

@interface MSAppDelegate ()
@property (nonatomic, retain) UINavigationController *navController;
@property (strong, nonatomic) MSSearchViewModel *viewModel;
@property (nonatomic, strong) MSSearchViewController *searchViewController;
@property (strong, nonatomic) MSViewModelServicesImpl *viewModelServices;
@end

@implementation MSAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //create nav controller
     self.navController = [UINavigationController new];
    
    //create instance of viewModelServiceImpl and viewModel
    self.viewModelServices = [[MSViewModelServicesImpl alloc] initWithNavigationController:self.navController];
    self.viewModel = [[MSSearchViewModel alloc] initWithServices:self.viewModelServices];
    
    //create and push init viewcontroller
    self.searchViewController = [[MSSearchViewController alloc] initWithViewModel:self.viewModel];
    [self.navController pushViewController:self.searchViewController animated:NO];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    
    //
    [self styleNavBar];
    [self updateConfigurations];
    
    return YES;
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
}


- (void)styleNavBar {
    UIImage *NavigationPortraitBackground = [[UIImage imageNamed:@"navbarImage"]
                                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UINavigationBar appearance] setBackgroundImage:NavigationPortraitBackground forBarMetrics:UIBarMetricsDefault];
    self.navController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)updateConfigurations {
    NSDate *lastUpdated = [[NSUserDefaults standardUserDefaults] objectForKey:MSTimeSinceLastConfigUpdateKey];
    
    if (([lastUpdated timeIntervalSinceNow] < -172800) || (lastUpdated == nil )) { //more than 48 hours or never set?
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        //get image base URL
        [[[self.viewModelServices getMovieDBSearchService] signalForConfigurationURL] subscribeNext:^(NSDictionary *jsonSearchResult) {
            NSString *baseURL = [jsonSearchResult[@"images"] objectForKey:@"base_url"];
            NSLog(@"config baseURL: %@",baseURL);
            [defaults setObject:baseURL forKey:MSBaseImageURLKey];
        } error:^(NSError *error) {
            NSLog(@"An error occurred: %@", error);
        }];
        
        //get genre array
        [[[self.viewModelServices getMovieDBSearchService] signalForGenreArray] subscribeNext:^(NSDictionary *jsonSearchResult) {
            NSArray *genreArray = jsonSearchResult[@"genres"];
            NSMutableDictionary *genreDictionary = [NSMutableDictionary new];
            for (id object in genreArray){
                NSLog(@"genre: %@",object[@"name"]);
                [genreDictionary setObject:[NSString stringWithFormat: @"%@",object[@"name"]] forKey:[NSString stringWithFormat: @"%@",object[@"id"]]];
            }
            NSLog(@"config genre aray: %@",genreArray);
            [defaults setObject:genreDictionary forKey:MSMovieGenreKey];
        } error:^(NSError *error) {
            NSLog(@"An error occurred: %@", error);
        }];
;
        
        [defaults setObject:[NSDate date] forKey:MSTimeSinceLastConfigUpdateKey];
        [defaults synchronize];
    }
}
@end
