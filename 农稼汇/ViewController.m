//
//  ViewController.m
//  农稼汇
//
//  Created by Anna on 16/5/20.
//  Copyright © 2016年 li. All rights reserved.
//

#import "ViewController.h"
#import "News.h"
#import "NewsCell.h"
#import "FooterView.h"
#import "HeaderView.h"

@interface ViewController ()<UITableViewDataSource, FooterViewDelegate>

@property (nonatomic, strong)NSMutableArray *news;

@property (nonatomic,assign)BOOL *loginSign;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)clickRightBtn:(id)sender;

- (IBAction)clickLeftBtn:(id)sender;


@end

@implementation ViewController

- (NSMutableArray *)news{
    if (_news == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"news.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict in arrayDict) {
            News *model= [News newsWithDict:dict];
            [arrayModels addObject:model];
        }
        _news = arrayModels;
    }
    return _news;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.news.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取模型数据
    News *model = self.news[indexPath.row];
    
    //创建单元格
    NewsCell *cell = [NewsCell newsCellWithTableView:tableView];
    
    //把模型数据设置给单元格
    cell.news = model;
    
    //返回单元格
    return cell;
}

//隐藏状态栏
- (BOOL) prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 100;
    
    self.loginSign = false;
    
    FooterView *footerView = [FooterView footerView];
    
    //设置footerView代理
    footerView.delegate = self;
    
    self.tableView.tableFooterView = footerView;
    
    //创建HeaderView
    HeaderView *headerView = [HeaderView headerView];
    self.tableView.tableHeaderView = headerView;
    
    self.loginSign = 1;
}

//CZFooterView的代理方法
- (void)footerViewUpdateData:(FooterView *)footerView{
    //增加一条数据
    
    //创建一个模型对象
    News *model = [[News alloc]init];
    model.title = @"敦煌科学种田";
    model.attention = @"围观0";
    model.source = @"中国农机网";
    model.time = @"21分钟前";
    model.image = @"大暑.jpg";
    
    //把模型对象添加到控制器的goods集合当中
    [self.news addObject:model];
    
    //刷新UITableView
    [self.tableView reloadData];
    
    //向上滚动数据
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:self.news.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickRightBtn:(id)sender{
    if (self.loginSign) {
        [self performSegueWithIdentifier:@"MainToOwn" sender:nil];
        
    }else{
        [self performSegueWithIdentifier:@"MainToLogin" sender:nil];
    }
}

- (IBAction)clickLeftBtn:(id)sender {
}

@end
