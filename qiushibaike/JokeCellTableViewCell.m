//
//  JokeCellTableViewCell.m
//  qiushibaike
//
//  Created by Singer on 14-7-25.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "JokeCellTableViewCell.h"
#import "AFHTTPRequestOperation.h"
#import "UIImageView+WebCache.h"
#import "UIImage+GIF.h"
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
//    [self.commentsLabel setNumberOfLines:0];
//    [self.contentLabel setLineBreakMode:NSLineBreakByClipping];
    NSDictionary *votes = [self.jockData valueForKey:@"votes"];
    self.dingLabel.text = [NSString stringWithFormat:@"顶(%@)",[votes valueForKey:@"up"]];
    self.caiLabel.text = [NSString stringWithFormat:@"踩(%@)",[votes valueForKey:@"down"]];
    self.commentsLabel.text = [NSString stringWithFormat:@"评论(%@)",[self.jockData valueForKey:@"comments_count"]];
    
    
//    UIImage *loadingImage = [UIImage sd_animatedGIFNamed:@"loading.gif"];
    UIImage *touxiangDefaultImage = [UIImage imageNamed:@"avatar.jpg"];
    
    //设置头像
    NSDictionary *userDict = [self.jockData valueForKey:@"user"];
    if ((NSNull *)userDict != [NSNull null]) {
        self.nickNameLabel.text = [userDict valueForKey:@"login"];
        NSString *userID = [userDict valueForKey:@"id"];
        NSString *prefixUserID = [userID substringToIndex:4];
        NSString *icon = [userDict valueForKey:@"icon"];
    
        if ((NSNull *)icon != [NSNull null]) {
            NSString *touxiangImageURL = [NSString stringWithFormat:@"http://pic.qiushibaike.com/system/avtnew/%@/%@/medium/%@",prefixUserID,userID,icon];
            
//            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:touxiangImageURL]];
//            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//                NSData *imageData = responseObject;
//                [self.touxiangImageView setImage:[UIImage imageWithData:imageData]];
//                
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
            //            }];
            //
            //            [operation start];
            
            [self.touxiangImageView
             sd_setImageWithURL:[NSURL URLWithString:touxiangImageURL]
             placeholderImage:touxiangDefaultImage];

        }else{
            [self.touxiangImageView setImage:[UIImage imageNamed:@"avatar.jpg"]];
        }
        
    }else{
        [self.touxiangImageView setImage:[UIImage imageNamed:@"avatar.jpg"]];
        [self.nickNameLabel setText:@"匿名"];
    }
    
    //设置内容中的图片
    NSString *imageName = [_jockData valueForKey:@"image"];
    if (imageName != nil && (NSNull *)imageName != [NSNull null]) {
        NSString *imageID = [_jockData valueForKey:@"id"];
        NSString *prefiximageId = [imageID substringToIndex:4];
        NSString *imageURL = [NSString stringWithFormat:@"http://pic.qiushibaike.com/system/pictures/%@/%@/small/%@",prefiximageId,imageID,imageName] ;
        self.largeImageURL =[NSString stringWithFormat:@"http://pic.qiushibaike.com/system/pictures/%@/%@/medium/%@",prefiximageId,imageID,imageName] ;
        
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
//        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSData *imageData = responseObject;
//            [self.contentImageView setImage:[UIImage imageWithData:imageData]];
//          
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//        }];
//        
//        [operation start];
        
        
        [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:self.contentImageView.image];
        
        //给imageView添加收拾，点击可以放大
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigImage)];
        [self.contentImageView addGestureRecognizer:tap];
        
    }else{
        [self.contentImageView setHidden:YES];
        
    }

}

//放大图片后支持手指缩放
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    for(id subView in scrollView.subviews)
    {
        if([subView isKindOfClass:[UIImageView class]])
        {
            return subView;
        }
    }
    return nil;
}

-(void) showBigImage{
    
    
    UIScrollView *bigImageScrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    bigImageScrollView.backgroundColor = [UIColor colorWithPatternImage:self.contentImageView.image];
    bigImageScrollView.backgroundColor = [UIColor darkGrayColor];
    bigImageScrollView.minimumZoomScale = 0.5;
    bigImageScrollView.maximumZoomScale = 2;
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.largeImageURL]];
//   
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
   
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] init];
    CGRect rect = [[UIScreen mainScreen]bounds];
    
    activityView.center = CGPointMake(rect.size.width*0.5, rect.size.height*0.5);
    CGRect activityViewFrame = activityView.frame;
    activityViewFrame.size.width = 20;
    activityViewFrame.size.height = 20;
    [activityView setFrame:activityViewFrame];
    
    CGFloat scrollWidth = bigImageScrollView.frame.size.width;
    CGFloat scrollHeight = bigImageScrollView.frame.size.height;
    [self.window addSubview:bigImageScrollView];
    
    [bigImageScrollView addSubview:activityView];
    
    
    [activityView startAnimating];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeBigImageView:)];

    [bigImageScrollView addGestureRecognizer:tap];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [activityView stopAnimating];
//        NSData *imageData = responseObject;
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:imageData]];
//
//        [imageView setFrame:CGRectMake(0, 0, scrollWidth, scrollHeight)];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeBigImageView:)];
//        [bigImageScrollView addGestureRecognizer:tap];
//        [bigImageScrollView addSubview:imageView];
//        [imageView setContentMode:UIViewContentModeScaleAspectFit];
//        [bigImageScrollView setContentSize:imageView.frame.size];
//        bigImageScrollView.delegate = self;
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"图片加载失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alertView show];
//        [bigImageScrollView removeFromSuperview];
//    }];
//    
//    [operation start];
    
    UIImageView *bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrollWidth, scrollHeight)];
   [bigImageView setContentMode:UIViewContentModeScaleAspectFit];
    [bigImageView sd_setImageWithURL:[NSURL URLWithString:self.largeImageURL] placeholderImage:self.touxiangImageView.image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            [bigImageScrollView removeFromSuperview];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"图片加载失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
            
        }else{
            [activityView removeFromSuperview];
            [bigImageView setImage:image];
            [bigImageScrollView addSubview:bigImageView];
            [bigImageScrollView setContentSize:bigImageView.bounds.size];
            bigImageScrollView.delegate = self;
        }
        
    }];
}

-(void) closeBigImageView:(UITapGestureRecognizer *) tap{
    [tap.view removeFromSuperview];
}



-(void)layoutSubviews{
    
    [super layoutSubviews];
    [self initCellData];
    NSString *content  = [_jockData valueForKey:@"content"];
    
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(296, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect contentLabelFrame = self.contentLabel.frame;
    contentLabelFrame.size.height = size.height;
    [self.contentLabel setFrame:contentLabelFrame];
    CGFloat height = contentLabelFrame.origin.y + contentLabelFrame.size.height;
    
    NSString *imageURL = [_jockData valueForKey:@"image"];
    
    if (imageURL == nil || (NSNull *)imageURL== [NSNull null]) {
        self.contentImageView.hidden = YES;
        CGRect dccViewFrame = self.dccView.frame;
        dccViewFrame.origin.y = height + 10 ;
        [self.dccView setFrame:dccViewFrame];
        
    }else{
        
        CGRect contentImageFrame = self.contentImageView.frame;
        contentImageFrame.origin.y = height + 5;
        [self.contentImageView setFrame:contentImageFrame];
        
        height = contentImageFrame.origin.y + contentImageFrame.size.height;
    }
    
}


+(CGFloat) cellHeightByData:(NSDictionary *) dataDict{
    NSString *content  = [dataDict valueForKey:@"content"];
    NSString *imageURL = [dataDict valueForKey:@"image"];
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(296, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    if (imageURL==nil || (NSNull *)imageURL == [NSNull null] ) {
        return 56 + size.height + 59 + 10;
    }
   
    return 56 + size.height + 5 + 59 + 96 + 10;
}



@end
