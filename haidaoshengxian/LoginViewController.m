//
//  LoginViewController.m
//  MyTXL
//
//  Created by Anna on 16/2/23.
//  Copyright © 2016年 li. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD+NJ.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *pswField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)cheakLogin;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self denglubeijing];
   
    [self SwipeGesture];
    [self LongPressGesture];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pswField];
 
}

-(void)denglubeijing
{
    UIImage *beijing=[UIImage imageNamed:@"denglubeijing.jpg"];
    UIImageView *myimageView=[[UIImageView alloc]initWithImage:beijing];
    myimageView.frame=CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height);
    
    [self.view addSubview:myimageView];
}

-(void)textChange
{
    if(self.nameField.text.length && self.pswField.text.length){
        self.loginBtn.enabled = YES;
    }
    else
    {
        self.loginBtn.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cheakLogin {
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaultes stringForKey:@"name"];
    NSString *psw = [userDefaultes stringForKey:@"psw"];
    if(![self.nameField.text isEqualToString:name]){
        [MBProgressHUD showError:@"账号不存在"];
        return;
    }
    if (![self.pswField.text isEqualToString:psw]) {
        [MBProgressHUD showError:@"密码不正确"];
        return;
    }
    //显示蒙层
    [MBProgressHUD showMessage:@"努力加载中"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [self performSegueWithIdentifier:@"LoginToContact" sender:nil];
    });
    
}

#pragma mark - LongPress 长按
-(void) LongPressGesture{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(LongPressAction:)];
    //设置长按最短时间
    longPress.minimumPressDuration = 2;
    [self.view addGestureRecognizer:longPress];
}

-(void) LongPressAction:(UILongPressGestureRecognizer *)longPress{
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *myview=[story instantiateViewControllerWithIdentifier:@"zhuceview"];
    [self presentModalViewController:myview animated:YES];
}

#pragma mark - swipe 轻扫
-(void) SwipeGesture{
    //初始化
    UISwipeGestureRecognizer *swipe1 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeActionLeft:)];
    //设置轻扫的方向
    swipe1.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipe1];
    
    //初始化
    UISwipeGestureRecognizer *swipe2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeActionRight:)];
    //设置轻扫的方向
    swipe2.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe2];
}

-(void) SwipeActionLeft:(UISwipeGestureRecognizer *)swipe{
    [self cheakLogin];
}

-(void) SwipeActionRight:(UISwipeGestureRecognizer *)swipe{

    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *myview=[story instantiateViewControllerWithIdentifier:@"zhuceview"];
    [self presentModalViewController:myview animated:YES];
}


@end
