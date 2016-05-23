//
//  Goods.h
//  MyIOS
//
//  Created by Anna on 16/5/21.
//  Copyright © 2016年 li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goods : NSObject

@property (nonatomic, copy) NSString *buyCount;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;

- (instancetype) initWithDict:(NSDictionary *)dict;
+ (instancetype) goodsWithDict:(NSDictionary *)dict;

@end
