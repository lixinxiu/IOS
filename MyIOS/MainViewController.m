//
//  MainViewController.m
//  MyIOS
//
//  Created by Anna on 16/5/21.
//  Copyright © 2016年 li. All rights reserved.
//

#import "MainViewController.h"
#import "Goods.h"
#import "GoodsCell.h"
#import "FooterView.h"
#import "HeaderView.h"

@interface MainViewController () <UITableViewDataSource, FooterViewDelegate>

@property (nonatomic, strong)NSMutableArray *goods;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)backAction:(id)sender;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.rowHeight = 50;
    
    FooterView *footerView = [FooterView footerView];
    
    //设置footerView代理
    footerView.delegate = self;
    
    self.tableView.tableFooterView = footerView;
    
    //创建HeaderView
    HeaderView *headerView = [HeaderView headerView];
    self.tableView.tableHeaderView = headerView;
    
    self.navigationController.navigationBarHidden = NO;

}

- (NSMutableArray *)goods{
    if (_goods == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"tgs.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict in arrayDict) {
            Goods *model= [Goods goodsWithDict:dict];
            [arrayModels addObject:model];
        }
        _goods = arrayModels;
    }
    return _goods;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goods.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取模型数据
    Goods *model = self.goods[indexPath.row];
    
    //创建单元格
    GoodsCell *cell = [GoodsCell goodsCellWithTableView:tableView];
    
    //把模型数据设置给单元格
    cell.goods = model;
    
    //返回单元格
    return cell;
}

//隐藏状态栏
- (BOOL) prefersStatusBarHidden{
    return YES;
}

//FooterView的代理方法
- (void)footerViewUpdateData:(FooterView *)footerView{
    //增加一条数据
    
    //创建一个模型对象
    Goods *model = [[Goods alloc]init];
    model.title = @"糯米网";
    model.price = @"11";
    model.buyCount = @"123";
    model.icon = @"103.png";
    
    //把模型对象添加到控制器的goods集合当中
    [self.goods addObject:model];
    
    //刷新UITableView
    [self.tableView reloadData];
    
    //向上滚动数据
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:self.goods.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backAction:(id)sender {
    //统一的使用如下关键词
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否注销" message:@"这里是详细说明" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    //显示当前的提示卡
    [self presentViewController:alert animated:YES completion:NULL];
}
@end
