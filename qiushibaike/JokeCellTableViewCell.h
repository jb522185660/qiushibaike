//
//  JokeCellTableViewCell.h
//  qiushibaike
//
//  Created by Singer on 14-7-25.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JokeCellTableViewCell : UITableViewCell <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *touxiangImageView;

@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *dingLabel;
@property (weak, nonatomic) IBOutlet UILabel *caiLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (nonatomic,copy) NSString *largeImageURL;
@property (nonatomic,strong) NSDictionary *jockData;
-(void) initCellData;

@property (weak, nonatomic) IBOutlet UIView *dccView;


+(CGFloat) cellHeightByData:(NSDictionary *) dataDict;

@end
