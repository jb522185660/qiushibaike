//
//  JokeCellTableViewCell.m
//  qiushibaike
//
//  Created by Singer on 14-7-25.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "JokeCellTableViewCell.h"
#import "AFHTTPRequestOperation.h"
@implementation JokeCellTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    //设置选中的时候没有颜色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}



#pragma mark 初始化cell的内容，填充内容
-(void) initCellData{
    
    
    
    
    self.contentLabel.text  = [self.jockData valueForKey:@"content"];
    NSDictionary *votes = [self.jockData valueForKey:@"votes"];
    self.dingLabel.text = [NSString stringWithFormat:@"顶(%@)",[votes valueForKey:@"up"]];
    self.caiLabel.text = [NSString stringWithFormat:@"踩(%@)",[votes valueForKey:@"down"]];
    self.commentsLabel.text = [NSString stringWithFormat:@"评论(%@)",[self.jockData valueForKey:@"comments_count"]];
    
    //设置头像
    NSDictionary *userDict = [self.jockData valueForKey:@"user"];
    if ((NSNull *)userDict != [NSNull null]) {
        self.nickNameLabel.text = [userDict valueForKey:@"login"];
        NSString *userID = [userDict valueForKey:@"id"];
        NSString *prefixUserID = [userID substringToIndex:4];
        NSString *icon = [userDict valueForKey:@"icon"];
        NSString *touxiangImageURL = [NSString stringWithFormat:@"http://pic.qiushibaike.com/system/avtnew/%@/%@/medium/%@",prefixUserID,userID,icon];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:touxiangImageURL]];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *imageData = responseObject;
            [self.touxiangImageView setImage:[UIImage imageWithData:imageData]];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
        [operation start];
    }
    
    //设置内容中的图片
    NSString *imageURL = [_jockData valueForKey:@"image"];
    if (imageURL != nil) {
        NSString *imageID = [_jockData valueForKey:@"id"];
        NSString *prefiximageId = [imageID substringToIndex:4];
        imageURL = [NSString stringWithFormat:@"http://pic.moumentei.com/system/pictures/%@/%@/small/%@",prefiximageId,imageID,imageURL] ;
        self.largeImageURL =[NSString stringWithFormat:@"http://pic.moumentei.com/system/pictures/%@/%@/medium/%@",prefiximageId,imageID,imageURL] ;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *imageData = responseObject;
            [self.contentImageView setImage:[UIImage imageWithData:imageData]];
          
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
        [operation start];
    }else{
        [self.contentImageView setHidden:YES];
    }
    
    
    
}

//-(CGFloat) cellHeightByData:(NSDictionary *) dataDict{
//    NSString *content  = [dataDict valueForKey:@"content"];
//    CGFloat height = [self stringHeightWithFontSize:17 width:300 string:content];
//    NSString *imageURL = [dataDict valueForKey:@"image"];
//    if (imageURL==nil || imageURL.length == 0) {
//        return 59.0 + height + 40.0;
//    }
//    return 59.0 + height + 5.0 + 112.0 + 40.0;
//}


@end
