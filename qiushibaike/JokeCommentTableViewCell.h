//
//  JokeCommentTableViewCell.h
//  qiushibaike
//
//  Created by Singer on 14-7-28.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JokeCommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *touxiangImageView;

@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentFloorLabel;
@property (weak, nonatomic) IBOutlet UIView *separatorView;

@property (strong, nonatomic) NSDictionary *commentDict;
-(void) initCellData;
@end
