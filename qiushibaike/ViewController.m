//
//  ViewController.m
//  qiushibaike
//
//  Created by Singer on 14-7-23.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "ViewController.h"
#import "JokeListViewController.h"
@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad
{
    
    JokeListViewController *jockVC = self.viewControllers[0];
    self.title = jockVC.tabBarItem.title;
    [super viewDidLoad];
  
	
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    self.title = item.title;
}

@end
