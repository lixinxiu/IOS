//
//  FooterView.h
//  MyIOS
//
//  Created by Anna on 16/5/21.
//  Copyright © 2016年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FooterView;

@protocol FooterViewDelegate <NSObject, UIScrollViewDelegate>
@required
- (void)footerViewUpdateData:(FooterView *)footerView;

@end

@interface FooterView : UIView

+ (instancetype)footerView;

@property (nonatomic, weak) id<FooterViewDelegate>delegate;

@end
