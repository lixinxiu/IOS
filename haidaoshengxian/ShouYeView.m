//
//  ShouYe	View.m
//  haidaoshengxian_pro
//
//  Created by Galahad on 15/11/29.
//  Copyright (c) 2015年 Galahad. All rights reserved.
//

#import "ShouYeView.h"
#import "AppDelegate.h"
@interface ShouYeView ()

@end

@implementation ShouYeView

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self shouyebeijing];
    [self GouWuButton];
    [self YouHuiXinxiButton];
    [self ShiYongShuoMingButton];
    [self GeRenZhongXinButton];
    [self ShuXianView];
    [self KeFuButton];
}
-(void)GouWuButton
{
    UIButton *gouwuButton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3.5-self.view.frame.size.width/80, self.view.frame.size.height/4, self.view.frame.size.width/4*1.8, self.view.frame.size.height/5*1.5)];
    [gouwuButton setImage:[UIImage imageNamed:@"gouwu.png"] forState:UIControlStateNormal];
    [gouwuButton addTarget:self action:@selector(ClickGouWuButton:)  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gouwuButton];
}
-(void)ClickGouWuButton:(UIButton*)sender
{
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *myview=[story instantiateViewControllerWithIdentifier:@"gouwu"];
    [self presentModalViewController:myview animated:YES];
}

-(void)YouHuiXinxiButton
{
    UIButton *youhuixinxi=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/7.1, self.view.frame.size.height/2.15, self.view.frame.size.width/4, self.view.frame.size.height/5)];
    [youhuixinxi setImage:[UIImage imageNamed:@"youhuixinxi.png"] forState:UIControlStateNormal];
    [youhuixinxi addTarget:self action:@selector(ClickYouHuiXinxiButton:)  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:youhuixinxi];
}
-(void)ClickYouHuiXinxiButton:(UIButton*)sender
{
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *myview=[story instantiateViewControllerWithIdentifier:@"youhuixinxi"];
    [self presentModalViewController:myview animated:YES];
}
-(void)ShiYongShuoMingButton
{
    UIButton *sysm=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/7.1*4.3, self.view.frame.size.height/2.15, self.view.frame.size.width/4, self.view.frame.size.height/5)];
    [sysm setImage:[UIImage imageNamed:@"shiyongshuoming.png"] forState:UIControlStateNormal];
    [sysm addTarget:self action:@selector(ClickShiYongShuoMingButton:)  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sysm];
}
-(void)ClickShiYongShuoMingButton:(UIButton*)sender
{
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *myview=[story instantiateViewControllerWithIdentifier:@"shiyongshuoming"];
    [self presentModalViewController:myview animated:YES];
}
-(void)GeRenZhongXinButton
{
    UIButton *grzx=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/7.1, self.view.frame.size.height/4*2.5, self.view.frame.size.width/3.5, self.view.frame.size.height/3.8)];
    UILabel *s1=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4.5, self.view.frame.size.height/4*2.5+self.view.frame.size.height/3.8/1.8, 100, 50)];
    s1.text=@"个人中心";
    s1.font=[UIFont fontWithName:@"AppleGothic" size:12];
    [s1 setTextColor:[UIColor colorWithRed:25.f/255.f green:25.f/255.f blue:112.f/255.f alpha:1]];
    [grzx setImage:[UIImage imageNamed:@"gerenzhongxin.png"] forState:UIControlStateNormal];
    [grzx addTarget:self action:@selector(ClickGeRenZhongXinButton:)  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:grzx];
    [self.view addSubview:s1];
}
-(void)ClickGeRenZhongXinButton:(UIButton*)sender
{
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *myview=[story instantiateViewControllerWithIdentifier:@"jiugongge"];
    [self presentModalViewController:myview animated:YES];
}
-(void)ShuXianView
{
    UIButton *sx=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3, self.view.frame.size.height/4*2.4, self.view.frame.size.width/3, self.view.frame.size.height/3)];
    [sx setImage:[UIImage imageNamed:@"shuxian.png"] forState:UIControlStateNormal];
    [self.view addSubview:sx];
}
-(void)KeFuButton
{
    UIButton *kf=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/1.8, self.view.frame.size.height/4*2.45, self.view.frame.size.width/3, self.view.frame.size.height/3.5)];
    UILabel *s1=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/1.53, self.view.frame.size.height/4*2.5+self.view.frame.size.height/3.8/1.8, 100, 50)];
    
    s1.text=@"呼叫客服";
    s1.font=[UIFont fontWithName:@"AppleGothic" size:12];
     [s1 setTextColor:[UIColor colorWithRed:25.f/255.f green:25.f/255.f blue:112.f/255.f alpha:1]];
    [kf setImage:[UIImage imageNamed:@"kefu.png"] forState:UIControlStateNormal];
    [kf addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:kf];
    [self.view addSubview:s1];
}
-(void)callAction:(UIButton*)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"联系客服" message:@"您确定要呼叫客服吗？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [alert show];
}

-(void)shouyebeijing
{
    UIImage *beijing=[UIImage imageNamed:@"shouyebeijing.png"];
    UIImageView *myimageView=[[UIImageView alloc]initWithImage:beijing];
    myimageView.frame=CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height);
    
    [self.view addSubview:myimageView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSLog(@"index: %d", buttonIndex);
    if (buttonIndex == 1)
    {
        NSLog(@"Tel call");
        NSURL *url=[NSURL URLWithString:@"tel://18408219260"];
        [[UIApplication sharedApplication]openURL:url];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
