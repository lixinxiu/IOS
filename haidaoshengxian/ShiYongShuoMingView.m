//
//  ShiYongShuoMingView.m
//  haidaoshengxian_pro
//
//  Created by Galahad on 15/11/29.
//  Copyright (c) 2015年 Galahad. All rights reserved.
//

#import "ShiYongShuoMingView.h"

@interface ShiYongShuoMingView ()

@end

@implementation ShiYongShuoMingView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *store=[[UIWebView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/22, self.view.frame.size.width,self.view.frame.size.height/22*21)];
    NSURL *storeURL;
    storeURL=[[NSURL alloc]initWithString:@"http://www.haidaofresh.com/hdsx/mobile/article.php?id=4"];
    [store loadRequest:[NSURLRequest requestWithURL:storeURL]];
    // 加载网页
    store.delegate=self;
    
    [self.view addSubview:store];
    
    [self rollbutton];
    
    [self PinchGesture];
}
-(void)rollbutton
{
    _btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btn.frame = CGRectMake(0, 240, 50, 50);
    _btn.layer.borderWidth = 1;
    _btn.layer.borderColor = [UIColor orangeColor].CGColor;
    _btn.layer.cornerRadius = 25;
    _btn.layer.masksToBounds = YES;
    [_btn setTitle:@"首页" forState:UIControlStateDisabled];
    _btn.backgroundColor = [UIColor orangeColor];
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn setTitle:@"首页" forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(dragMoving:withEvent: )forControlEvents: UIControlEventTouchDragInside];
    [_btn addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
    [_btn addTarget:self action:@selector(dragEnded:withEvent:) forControlEvents:UIControlEventTouchUpInside |
     UIControlEventTouchUpOutside];
    self.a=0;
    [self.view bringSubviewToFront:_btn];
    [self.view addSubview:_btn];
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    _image=[[UIImageView alloc]init];
    _image.frame=CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    NSMutableArray *myImageArray=[[NSMutableArray alloc]init];
    for (int i=1; i<=81; i++) {
        UIImage *myImage=[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]];
        [myImageArray addObject:myImage];
    }
    _image.animationImages=myImageArray;
    _image.animationRepeatCount=0;
    _image.animationDuration=2;
    
    [_image startAnimating];
    [self.view addSubview:_image];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_image stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    [_image stopAnimating];
    UIImage *myImage=[UIImage imageNamed:@"jiazaishibai.png"];
    UIImageView *myImageView=[[UIImageView alloc]initWithImage:myImage];
    myImageView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:myImageView];
    [self rollbutton];
}

- (void) dragMoving: (UIButton *) c withEvent:ev
{
    self.a=1;
    c.center = [[[ev allTouches] anyObject] locationInView:self.view];
    
}
-(void)doClick:(UIButton*)sender
{
    if (self.a==0)
    {
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController *myview=[story instantiateViewControllerWithIdentifier:@"shouye"];
        [self presentModalViewController:myview animated:YES];
    }
    self.a=0;
}


- (void) dragEnded: (UIButton *) btn withEvent:ev
{
    //NSLog(@"dragEnd!!");
    btn.center = [[[ev allTouches] anyObject] locationInView:self.view];
    
    float bound = 0;
    float moveDistance = 0;
    CGPoint p;
    if (btn.center.x < (self.view.center.x))
    {
        bound = 20;
        moveDistance = (btn.center.x - bound) / 60;
        p.x = btn.center.x;
        p.y = btn.center.y;
        
        for (int i = 0; i < 60; i++)
        {
            p.x -= moveDistance;
            btn.center = p;
        }
    }
    else
    {
        bound = self.view.frame.size.width - 20;
        moveDistance = (self.view.frame.size.width - 20 - btn.center.x) / 60;
        p.x = btn.center.x;
        p.y = btn.center.y;
        
        for (int i = 0; i < 60; i++)
        {
            p.x += moveDistance;
            btn.center = p;
        }
    }
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

#pragma mark - pinch 捏合
-(void) PinchGesture{
    //初始化
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(PinchAction:)];
    [self.view addGestureRecognizer:pinch];
}

-(void)PinchAction:(UIPinchGestureRecognizer *)pinch{
    //获取手势缩放比
    float scale = pinch.scale;
    //对视图进行缩放
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, scale, scale);
}

@end
