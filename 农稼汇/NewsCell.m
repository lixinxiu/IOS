//
//  NewsCell.m
//  农稼汇
//
//  Created by Anna on 16/5/20.
//  Copyright © 2016年 li. All rights reserved.
//

#import "NewsCell.h"
#import "News.h"

@interface NewsCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblAttention;

@property (weak, nonatomic) IBOutlet UILabel *lblSource;

@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@property (weak, nonatomic) IBOutlet UIImageView *lblImage;

@end

@implementation NewsCell

+ (instancetype)newsCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"news_cell";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:nil options:nil]firstObject];
    }
    return cell;
}

- (void) setNews:(News *)news{
    _news = news;
    self.lblTitle.text = news.title;
    self.lblAttention.text = [NSString stringWithFormat:@"%@", news.attention];
    self.lblSource.text = [NSString stringWithFormat:@"%@", news.source];
    self.lblTime.text = [NSString stringWithFormat:@"%@", news.time];
    self.lblImage.image = [UIImage imageNamed:news.image];
    [self particularClick];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - Tap 点击
-(void) particularClick{
    /*一个手指单击*/
    //初始化
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
    //点击次数
    tap.numberOfTapsRequired = 1;
    //使用手指数
    tap.numberOfTouchesRequired = 1;
    //添加手势
    [self.contentView addGestureRecognizer:tap];
}

//一个手指单击回调函数
-(void)SingleTap:(UITapGestureRecognizer *)tap{
    NSLog(@"进入详情界面");
}

@end