//
//  JokeCommentTableViewCell.m
//  qiushibaike
//
//  Created by Singer on 14-7-28.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "JokeCommentTableViewCell.h"
#import  "UIImageView+WebCache.h"
@implementation JokeCommentTableViewCell

- (void)awakeFromNib
{
   
    [super awakeFromNib];
    
    //设置选中的时候没有颜色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImage *touxiangDefaultImage = [UIImage imageNamed:@"avatar.jpg"];
    NSDictionary *userDict = _commentDict[@"user"];
    if ((NSNull *)userDict != [NSNull null]){
        [self.nickNameLabel setText:userDict[@"login"]];
        NSString *userID = [userDict valueForKey:@"id"];
        NSString *prefixUserID = [userID substringToIndex:4];
        NSString *icon = [userDict valueForKey:@"icon"];
        if ((NSNull *)icon != [NSNull null]) {
            NSString *touxiangImageURL = [NSString stringWithFormat:@"http://pic.qiushibaike.com/system/avtnew/%@/%@/medium/%@",prefixUserID,userID,icon];
            NSURL *touxiangURL = [NSURL URLWithString:touxiangImageURL];
            [self.touxiangImageView sd_setImageWithURL:touxiangURL placeholderImage:touxiangDefaultImage];
        }
    }else{
    
        [self.nickNameLabel setText:@"匿名"];
        [self.touxiangImageView setImage:touxiangDefaultImage];
    }
    
    [self.commentLabel setText:_commentDict[@"content"]];
    [self.commentFloorLabel setText:_commentDict[@"floor"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}



@end
