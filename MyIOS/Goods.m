//
//  Goods.m
//  MyIOS
//
//  Created by Anna on 16/5/21.
//  Copyright © 2016年 li. All rights reserved.
//

#import "Goods.h"

@implementation Goods

- (instancetype) initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype) goodsWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
