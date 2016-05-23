//
//  GoodsCell.h
//  MyIOS
//
//  Created by Anna on 16/5/21.
//  Copyright © 2016年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Goods;

@interface GoodsCell : UITableViewCell

@property (nonatomic, strong) Goods *goods;

+ (instancetype)goodsCellWithTableView:(UITableView *)tableView;

@end
