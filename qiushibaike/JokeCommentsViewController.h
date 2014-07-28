//
//  JokeCommentsViewController.h
//  qiushibaike
//
//  Created by Singer on 14-7-28.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JokeCommentsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSDictionary *jokeDict;
@end
