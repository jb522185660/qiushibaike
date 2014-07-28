//
//  JokeCommentsViewController.m
//  qiushibaike
//
//  Created by Singer on 14-7-28.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "JokeCommentsViewController.h"
#import "JokeCellTableViewCell.h"
#import "JokeCommentTableViewCell.h"
#import "AFHTTPRequestOperation.h"
#import "AFURLConnectionOperation.h"
@interface JokeCommentsViewController ()
{
    NSInteger _page;
    UITableView *_commentsTableView;
    NSMutableArray *_commentsArray;
    BOOL _isFirst;
}
@end

@implementation JokeCommentsViewController

-(void) loadCommentsData{
    if (_commentsArray ==  nil) {
        _commentsArray = [[NSMutableArray alloc] init];
        [_commentsArray addObject:self.jokeDict];
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"http://m2.qiushibaike.com/article/%@/comments?count=20&page=%d",_jokeDict[@"id"],_page];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
   
//    responseData = [responseData dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
    
    
    [_commentsArray addObjectsFromArray:dictData[@"items"]];
    _page++;
    
    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //请求成功
//        NSString *requestTmp = [NSString stringWithString:operation.responseString];
//        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
//        //系统自带JSON解析
//        NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
//        
//        [_commentsArray addObjectsFromArray:dictData[@"items"]];
//        _page++;
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"加载评论出错%@",error);
//    }];
//    [operation start];
    
    
    


}


- (void)viewDidLoad
{
    _page = 1;
    
    if (_commentsTableView == nil) {
        CGFloat width = self.view.frame.size.width;
        CGFloat height = self.view.frame.size.height;
        CGRect frame = CGRectMake(0,64,width,height-49-64);
        _commentsTableView = [[UITableView alloc]initWithFrame:frame];
        _commentsTableView.delegate =self;
        _commentsTableView.dataSource = self;
//        [_commentsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.view addSubview:_commentsTableView];
        
        
        _commentsTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _commentsTableView.bounds.size.width, 0.01f)];
//        [_commentsTableView.tableHeaderView setBackgroundColor:[UIColor redColor]];

        
    }
    [self loadCommentsData];
    _isFirst = NO;
    [super viewDidLoad];
}





-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"行数：%d",_commentsArray.count);
//    if (_isFirst) {
//        return _commentsArray.count+1;
//    }else{
//        return _commentsArray.count+3;
//    }
    return _commentsArray.count;
   
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return  [JokeCellTableViewCell cellHeightByData:self.jokeDict];
    }
    return 142.0f;
}

//-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.1f;
//}

#pragma mark 每当有一个cell进入屏幕视野范围内就会被调用 返回当前这行显示的cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //用static 只会初始化一次
    static NSString *JokeCellTableViewCellID = @"JokeCellTableViewCell";
    static NSString *JokeCommentTableViewCellID = @"JokeCommentTableViewCell";
    //拿到一个标示符先去缓存池中查找对应的cell
    UITableViewCell *cell ;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:JokeCellTableViewCellID];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:JokeCommentTableViewCellID];
    }
    
    
    //如果缓存池中没有，才需要传入一个标识创建新的cell
    
    
    if (cell == nil) {
        if (indexPath.row == 0) {
            NSBundle *bundle = [NSBundle mainBundle];
            NSArray *array = [bundle loadNibNamed:@"JokeCellTableViewCell" owner:self options:nil];
            JokeCellTableViewCell *headCell = [array lastObject];
            headCell.jockData = self.jokeDict;
//            [headCell setBackgroundColor:[UIColor redColor]];
            return  headCell;
        }else{
            
            NSBundle *bundle = [NSBundle mainBundle];
            NSArray *array = [bundle loadNibNamed:@"JokeCommentTableViewCell" owner:self options:nil];
          
            JokeCommentTableViewCell *commentCell = [array lastObject];
            commentCell.commentDict = _commentsArray[indexPath.row];
//            [commentCell.nickNameLabel setText:@"bbbbb"];
//            [commentCell setBackgroundColor:[UIColor blueColor]];
            cell = commentCell;
            
            
            return cell;
        }
        
    }
    
    //设置数据
   // [cell.textLabel setText:@"123124"];
    return cell;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
