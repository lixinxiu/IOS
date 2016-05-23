//
//  JKLockView.h
//  MyGesture
//
//  Created by Anna on 16/3/22.
//  Copyright © 2016年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JKLockView;
@protocol JKLockViewDelegate <NSObject>

@optional
-(void)lockView:(JKLockView *)lockView didFinshPath:(NSString *)path;

@end

@interface JKLockView : UIView

@property(nonatomic,assign) IBOutlet id<JKLockViewDelegate>delegate;

@end
