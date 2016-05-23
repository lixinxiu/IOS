//
//  GoodsCell.m
//  MyIOS
//
//  Created by Anna on 16/5/21.
//  Copyright © 2016年 li. All rights reserved.
//

#import "GoodsCell.h"
#import "Goods.h"

@interface GoodsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgViewIcon;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblPrice;

@property (weak, nonatomic) IBOutlet UILabel *lblBuyCount;

@end


@implementation GoodsCell

+ (instancetype)goodsCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"goods_cell";
    GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsCell" owner:nil options:nil]firstObject];
    }
    return cell;
}

- (void) setGoods:(Goods *)goods{
    _goods = goods;
    self.imgViewIcon.image = [UIImage imageNamed:goods.icon];
    self.lblTitle.text = goods.title;
    self.lblPrice.text = [NSString stringWithFormat:@"¥ %@", goods.price];
    self.lblBuyCount.text = [NSString stringWithFormat:@"%@人已购买", goods.buyCount];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
