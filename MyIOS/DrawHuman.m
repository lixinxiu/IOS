//
//  DrawHuman.m
//  QuartHuman
//
//  Created by Anna on 16/4/5.
//  Copyright © 2016年 li. All rights reserved.
//

#import "DrawHuman.h"

#define JKRadius 70
#define JKTopY 100
#define JKColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@implementation DrawHuman


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //1.获取图形的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.图形绘制
    drawBody(context, rect);
    drawMouse(context, rect);
    drawEyes(context, rect);
    drawfoot(context, rect);
    drawclothes(context, rect);
    drawhand(context, rect);
}


//身体绘制
void drawBody(CGContextRef context,CGRect rect){
    //上半圆
    CGFloat topX = rect.size.width *0.5;
    CGFloat topY = JKTopY;
    CGFloat topRadius = JKRadius;
    CGContextAddArc(context, topX, topY, topRadius, 0, M_PI, 1);
    
    //线条的向下延伸
    CGFloat middleX = topX - topRadius;
    CGFloat middleH = JKTopY;
    CGFloat middleY = topY + middleH;
    CGContextAddLineToPoint(context, middleX, middleY);
    
    //下半圆
    CGFloat bottomX = topX;
    CGFloat bottomY = middleY;
    CGFloat bottomRedius = topRadius;
    CGContextAddArc(context, bottomX, bottomY, bottomRedius, M_PI, 0, 1);
    
    //合并路径
    CGContextClosePath(context);
    
    //设置颜色
    [JKColor(252, 218, 0)set];
    
    //显示
    CGContextFillPath(context);
}

//手绘制
void drawhand(CGContextRef context,CGRect rect){
    CGFloat startX = rect.size.width*0.5 - JKRadius;
    CGFloat startY = JKTopY * 1.5;
    CGFloat middleX = rect.size.width*0.5 - JKRadius*1.45;
    CGFloat middleY = JKTopY * 1.85;
    CGFloat endX = rect.size.width*0.5 - JKRadius;
    CGFloat endY = JKTopY * 2.1;
    CGFloat handRedius = 25;
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextMoveToPoint(context, rect.size.width*0.5 + JKRadius - 5, startY);
    CGContextAddLineToPoint(context, rect.size.width*0.5 + JKRadius*1.45, middleY);
    CGContextAddLineToPoint(context, rect.size.width*0.5 + JKRadius, endY);
    CGContextAddEllipseInRect(context, CGRectMake(rect.size.width*0.5 + JKRadius -15, endY, 15, 15));
    [JKColor(252, 218, 0)set];
    CGContextStrokePath(context);
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextMoveToPoint(context, startX+5, startY);
    CGContextAddLineToPoint(context, middleX, middleY);
    CGContextAddLineToPoint(context, endX, endY);
    CGContextAddEllipseInRect(context, CGRectMake(endX, endY, 15, 15));
    [JKColor(252, 218, 0)set];
    CGContextStrokePath(context);
}

//脚绘制
void drawfoot(CGContextRef context,CGRect rect){
    
    CGFloat startX = rect.size.width * 0.5 - JKRadius;
    CGFloat startY = JKTopY * 2;
    CGFloat endX = rect.size.width * 0.5;
    CGFloat endY = JKTopY * 2 +JKRadius;
    CGFloat middleX = rect.size.width * 0.5 - 40;
    CGFloat middleY = JKTopY * 2 + 80;
    CGFloat leftbottomX = rect.size.width * 0.5 - 80;
    CGFloat leftbottomY = JKTopY * 3;
    CGFloat controlX = rect.size.width * 0.5 -JKRadius;
    CGFloat controlY = JKTopY * 3 - 20;
    CGFloat rightbottomX = rect.size.width * 0.5 - 10;
    CGFloat rightbottomY = JKTopY * 3;
    
    CGContextMoveToPoint(context, startX, startY);
    CGContextAddLineToPoint(context, middleX, middleY);
    CGContextAddQuadCurveToPoint(context, controlX, controlY, leftbottomX, leftbottomY);
    CGContextAddLineToPoint(context, rightbottomX, rightbottomY);
    CGContextAddLineToPoint(context, endX, endY);
    
    CGContextAddLineToPoint(context, rect.size.width*0.5+10, rightbottomY);
    CGContextAddLineToPoint(context, rect.size.width*0.5+80, leftbottomY);
    CGContextAddQuadCurveToPoint(context, rect.size.width*0.5+JKRadius, controlY, rect.size.width*0.5+40, middleY);
    CGContextAddLineToPoint(context, rect.size.width*0.5+JKRadius, startY);
    
    
    CGContextClosePath(context);
    [JKColor(252, 218, 0)set];
    CGContextFillPath(context);
}

//衣服绘制
void drawclothes(CGContextRef context,CGRect rect){
    CGFloat startX = rect.size.width*0.5 - JKRadius;
    CGFloat startY = JKTopY * 1.8;
    CGFloat control1X = rect.size.width*0.5 - 80;
    CGFloat control1Y = JKTopY*2 + JKRadius;
    CGFloat middleX = rect.size.width*0.5;
    CGFloat middleY = JKTopY*2 + JKRadius;
    CGFloat control2X = rect.size.width*0.5 + 80;
    CGFloat control2Y = JKTopY*2 + JKRadius;
    CGFloat endX = rect.size.width*0.5 + JKRadius;
    CGFloat endY = JKTopY * 1.8;
    
    
    CGContextMoveToPoint(context, startX, startY);
    CGContextAddQuadCurveToPoint(context, control1X, control1Y, middleX, middleY);
    CGContextAddQuadCurveToPoint(context, control2X, control2Y, endX, endY);
    CGContextAddLineToPoint(context, endX, endY);
    CGContextClosePath(context);
    [JKColor(20, 100, 150)set];
    CGContextFillPath(context);
    
    CGContextMoveToPoint(context, rect.size.width*0.5 - 25, JKTopY * 2 + 20);
    CGContextAddArc(context, rect.size.width*0.5, JKTopY * 2 + 20, 25, M_PI, 0, 1);
    CGContextClosePath(context);
    [JKColor(120, 100, 20)set];
    CGContextFillPath(context);
}

//嘴巴绘制
void drawMouse(CGContextRef context,CGRect rect){
    //设置1个控制点
    CGFloat controlX = rect.size.width *0.5;
    CGFloat controlY = rect.size.height *0.5;
    
    //设置当前点
    CGFloat marginX = 20;
    CGFloat marginY = 10;
    CGFloat currentX = controlX - marginX;
    CGFloat currentY = controlY - marginY;
    CGContextMoveToPoint(context, currentX, currentY);
    
    //设置结束点
    CGFloat endX = controlX + marginX;
    CGFloat endY = currentY;
    
    CGContextSetLineWidth(context, 3);
    
    //绘制贝塞尔曲线
    CGContextAddQuadCurveToPoint(context, controlX, controlY, endX, endY);
    
    //设置颜色
    [[UIColor blackColor]set];
    
    //显示
    CGContextStrokePath(context);
}

//眼睛绘制
void drawEyes(CGContextRef context,CGRect rect){
    // 1.黑色绑带
    CGFloat startX = rect.size.width * 0.5 - JKRadius;
    CGFloat startY = JKTopY;
    CGContextMoveToPoint(context, startX, startY);
    CGFloat endX = startX + 2 * JKRadius;
    CGFloat endY = startY;
    CGContextAddLineToPoint(context, endX, endY);
    CGContextSetLineWidth(context, 15);
    [[UIColor blackColor] set];
    // 绘制线条
    CGContextStrokePath(context);
    
    // 2.最外圈的镜框
    [JKColor(61, 62, 66) set];
    CGFloat kuangRadius = JKRadius * 0.4;
    CGFloat kuangY = startY;
    CGFloat kuangX = rect.size.width * 0.5 - kuangRadius;
    CGContextAddArc(context, kuangX, kuangY, kuangRadius, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    
    [JKColor(61, 62, 66) set];
    CGFloat kuangRadius1 = JKRadius * 0.4;
    CGFloat kuangY1 = startY;
    CGFloat kuangX1 = rect.size.width * 0.5 + kuangRadius;
    CGContextAddArc(context, kuangX1, kuangY1, kuangRadius1, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    
    // 3.里面的白色框
    [[UIColor whiteColor] set];
    CGFloat whiteRadius = kuangRadius * 0.7;
    CGFloat whiteX = kuangX;
    CGFloat whiteY = kuangY;
    CGContextAddArc(context, whiteX, whiteY, whiteRadius, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    
    [[UIColor whiteColor] set];
    CGFloat whiteRadius1 = kuangRadius * 0.7;
    CGFloat whiteX1 = kuangX+2*kuangRadius;
    CGFloat whiteY1 = kuangY;
    CGContextAddArc(context, whiteX1, whiteY1, whiteRadius1, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    
    //4.棕色眼球
    [JKColor(76, 23, 13) set];
    CGFloat brownRadius = kuangRadius * 0.4;
    CGFloat brownX = kuangX+2*kuangRadius-6;
    CGFloat brownY = kuangY;
    CGContextAddArc(context, brownX, brownY, brownRadius, 0, M_PI*2 , 0);
    CGContextFillPath(context);
    
    [JKColor(76, 23, 13) set];
    CGFloat brownRadius1 = kuangRadius * 0.4;
    CGFloat brownX1 = kuangX+6;
    CGFloat brownY1 = kuangY;
    CGContextAddArc(context, brownX1, brownY1, brownRadius1, 0, M_PI*2, 0);
    CGContextFillPath(context);
    
    //5.黑色瞳孔
    [[UIColor blackColor] set];
    CGFloat blackRadius = kuangRadius * 0.2;
    CGFloat blackX = kuangX+2*kuangRadius-6;
    CGFloat blackY = kuangY;
    CGContextAddArc(context, blackX, blackY, blackRadius, 0, M_PI*2 , 0);
    CGContextFillPath(context);
    
    [[UIColor blackColor] set];
    CGFloat blackRadius1 = kuangRadius * 0.2;
    CGFloat blackX1 = kuangX+6;
    CGFloat blackY1 = kuangY;
    CGContextAddArc(context, blackX1, blackY1, blackRadius1, 0, M_PI*2, 0);
    CGContextFillPath(context);
    
    //6.白色反光
    [[UIColor whiteColor] set];
    CGFloat lightRadius = kuangRadius * 0.1;
    CGFloat lightX = kuangX+2*kuangRadius;
    CGFloat lightY = kuangY;
    CGContextAddArc(context, lightX, lightY, lightRadius, 0, M_PI*2 , 0);
    CGContextFillPath(context);
    
    
    [[UIColor whiteColor] set];
    CGFloat lightRadius1 = kuangRadius * 0.1;
    CGFloat lightX1 = kuangX+2*kuangRadius-45;
    CGFloat lightY1 = kuangY;
    CGContextAddArc(context, lightX1, lightY1, lightRadius1, 0, M_PI*2 , 0);
    CGContextFillPath(context);

}

@end
