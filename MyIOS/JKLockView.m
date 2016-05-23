//
//  JKLockView.m
//  MyGesture
//
//  Created by Anna on 16/3/22.
//  Copyright © 2016年 li. All rights reserved.
//

#import "JKLockView.h"

//在.m文件中定义一些私有属性
@interface JKLockView ()
//定义私有的匿名扩展（类的属性、方法）
@property (nonatomic,strong)NSMutableArray *selectedBtns;
@property (nonatomic,assign)CGPoint currentPoint;//得到当前用户的点

@end

@implementation JKLockView

//创建数组，保存用户的所有的按钮数据
-(NSMutableArray *)selectedBtns//初始化数组，判断为空则新建
{
    if (_selectedBtns == nil) {
        _selectedBtns = [NSMutableArray array];
    }
        return _selectedBtns;
}

//const定义当前变量是一个只读，在其他类中不能声明同样的变量名
CGFloat const btnCount = 9;//当前按钮的个数
CGFloat const btnW = 80;//当前按钮的宽度
CGFloat const btnH = 80;//当前按钮的高度
CGFloat const viewY = 400;//装载按钮的视图view的Y轴坐标
int const columnCount = 3;//定义整个行数和列数
#define kScreenWidth [UIScreen mainScreen].bounds.size.width//定义一个常量，当前主界面的宽度

//通过代码创建时就会调用当前这个函数
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame])
    {
        [self AddButton];
    }
    return self;
}

//通过storyboard或XIB创建时调用下面这个方法
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self AddButton];
    }
    return self;
}

-(void)AddButton{
    //按钮的布局
    CGFloat height = 0;
    for (int i = 0; i < btnCount; i++) {
        NSString *str = [NSString stringWithFormat:@"screenshot_%d.png",i+1];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //取消按钮的点击事件
        btn.userInteractionEnabled = NO;
        
        btn.tag = i;
        
        //未选中状态的按钮图片
        [btn setBackgroundImage:[UIImage imageNamed:@"screenshot_0.png"] forState:UIControlStateNormal];
        //选中状态的按钮图片
        [btn setBackgroundImage:[UIImage imageNamed:str] forState:UIControlStateSelected];
        
        int row = i/columnCount;//判断按钮处于第几行
        int column = i%columnCount;//判断按钮处于第几列
        
        //间距
        CGFloat margin = (self.frame.size.width - columnCount *btnW)/(columnCount + 1);
        //X轴坐标
        CGFloat btnX = margin + column*(btnW + margin);
        //Y轴坐标
        CGFloat btnY = row *(btnW + margin);
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        height = btnH + btnY;
        [self addSubview:btn];
    }
    self.frame = CGRectMake(0, viewY, kScreenWidth, height);
}

#pragma mark - 私有方法
-(CGPoint)pointWithTouch:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    return point;
}

-(UIButton *)buttonWithPoint:(CGPoint)point
{
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
        }
    }
    return nil;
}

#pragma mark - 九宫格的触摸方法
//触摸开始的响应事件
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1.拿到触摸的点
    CGPoint point = [self pointWithTouch:touches];
    //2.根据当前的坐标，去找到对应的按钮
    UIButton *btn = [self buttonWithPoint:point];
    //3.设置状态
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectedBtns addObject:btn];
    }
    [self setNeedsDisplay];//曲线的更新和显示
}

//点击移动
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1.拿到触摸的点
    CGPoint point = [self pointWithTouch:touches];
    //2.根据当前的坐标，去找到对应的按钮
    UIButton *btn = [self buttonWithPoint:point];
    //3.设置状态
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectedBtns addObject:btn];
    }else
    {
        self.currentPoint = point;
    }
    [self setNeedsDisplay];//曲线的更新和显示
}

//点击结束
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(lockView:didFinshPath:)]) {
        NSMutableString *path = [NSMutableString string];
        for (UIButton *btn in self.selectedBtns) {
            [path appendFormat:@"%ld",(long)btn.tag];
        }
        [self.delegate lockView:self didFinshPath:path];
    }
    
    //设置当前所有按钮的选择属性为NO
    [self.selectedBtns makeObjectsPerformSelector:@selector(setSelected:)withObject:(NO)];
    [self.selectedBtns removeAllObjects];//清空
    [self setNeedsDisplay];
}

//点击取消
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

#pragma mark - 绘图
-(void)drawRect:(CGRect)rect
{
    if (self.selectedBtns.count == 0) {
        return;
    }
    UIBezierPath *path = [UIBezierPath bezierPath]; //绘制曲线
    path.lineWidth = 8;//线宽
    path.lineJoinStyle = kCGLineCapRound;//连接点的样式
    [[UIColor colorWithRed:32/255.0 green:210/255.0 blue:254/255.0 alpha:0.5]set];//曲线颜色
    //遍历按钮
    for (int i = 0; i<self.selectedBtns.count; i++) {
        UIButton *button = self.selectedBtns[i];
        if (i==0) {
            [path moveToPoint:button.center];//起点则开始
        }else{
            [path addLineToPoint:button.center];//非起点则连线
        }
    }
    [path addLineToPoint:self.currentPoint];
    [path stroke];
}

@end
