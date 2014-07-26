//
//  JokeListViewController.m
//  qiushibaike
//
//  Created by Singer on 14-7-23.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "JokeListViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFURLConnectionOperation.h"
#import "JokeCellTableViewCell.h"
@interface JokeListViewController ()
{
//    NSMutableDictionary *_dictData;
    UITableView *_tableView;
    NSMutableArray *_arrayData;
}
@end

@implementation JokeListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    
    
}

- (void)viewDidLoad
{
    
    NSURL *url = [NSURL URLWithString:@"http://m2.qiushibaike.com/article/list/suggest?count=30&page=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //请求成功
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        _arrayData = [NSMutableArray arrayWithArray:[dictData valueForKeyPath:@"items"]];
        //NSLog(@"%@",_dictData);
        if (_tableView == nil) {
            CGFloat width = self.view.frame.size.width;
            CGFloat height = self.view.frame.size.height;
            CGRect frame = CGRectMake(0,64,width,height-49-64);
            _tableView = [[UITableView alloc]initWithFrame:frame];
            _tableView.delegate =self;
            _tableView.dataSource = self;
            [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            [self.view addSubview:_tableView];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败
    }];
    
    [operation start];
    
    [super viewDidLoad];
    NSLog(@"title:%@",self.tabBarItem.title);
    
}



-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    return _arrayData.count;
}

#pragma mark 每当有一个cell进入屏幕视野范围内就会被调用 返回当前这行显示的cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //用static 只会初始化一次
    static NSString *ID = @"JokeCellTableViewCell";
    //拿到一个标示符先去缓存池中查找对应的cell
    JokeCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //如果缓存池中没有，才需要传入一个标识创建新的cell
    if (cell == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSArray *array = [bundle loadNibNamed:@"JokeCellTableViewCell" owner:self options:nil];
        cell = [array lastObject];

       // cell = [[JokeCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    
    NSDictionary *item = (NSDictionary *)_arrayData[indexPath.row];
    //覆盖数据
    cell.jockData = item;
   // [cell cellHeightByData:item];
    //[cell initCellData];
    return cell;
}


#pragma mark 选中cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dict = _arrayData[indexPath.row];
    return [JokeCellTableViewCell cellHeightByData:dict];

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
