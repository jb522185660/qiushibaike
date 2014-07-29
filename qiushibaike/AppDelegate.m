//
//  AppDelegate.m
//  qiushibaike
//
//  Created by Singer on 14-7-23.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "AppDelegate.h"
#import "JokeListViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    JokeListViewController *v1 = [[JokeListViewController alloc]initWithNibName:@"JokeListViewController" bundle:nil];
    v1.title = @"最热";
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:v1];
    
    JokeListViewController *v2 = [[JokeListViewController alloc]initWithNibName:@"JokeListViewController" bundle:nil];
    v2.title = @"最新";
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:v2];
    
    JokeListViewController *v3 = [[JokeListViewController alloc]initWithNibName:@"JokeListViewController" bundle:nil];
    v3.title = @"真相";
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:v3];
    
    UITabBarController *tabvc = [[UITabBarController alloc]init];
    tabvc.viewControllers = @[nav1,nav2,nav3];
    self.window.rootViewController = tabvc;
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
