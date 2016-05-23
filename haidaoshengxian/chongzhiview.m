//
//  chongzhiview.m
//  海道生鲜
//
//  Created by Anna on 16/3/31.
//  Copyright © 2016年 wangyilin. All rights reserved.
//

#import "chongzhiview.h"
#import "MBProgressHUD+NJ.h"
#import "JKLockView.h"

@interface chongzhiview ()<JKLockViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *pswField;
@property (weak, nonatomic) IBOutlet UIButton *querenBtn;
@property (weak, nonatomic) IBOutlet UIButton *quxiaoBtn;
- (IBAction)cheak;
- (IBAction)quxiao;



@end

@implementation chongzhiview

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self SwipeGesture];
    
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pswField];

}

-(void)textChange
{
    if(self.nameField.text.length && self.pswField.text.length){
        self.querenBtn.enabled = YES;
    }
    else
    {
        self.querenBtn.enabled = NO;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)lockView:(JKLockView *)lockView didFinshPath:(NSString *)path
{
    NSString *myString = path;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:myString forKey:@"myString"];
}

- (IBAction)cheak{
    if(!self.nameField.text.length){
        [MBProgressHUD showError:@"账号不存在"];
        return;
    }
    if (!self.pswField.text.length) {
        [MBProgressHUD showError:@"密码不存在"];
        return;
    }
    //显示蒙层
    [MBProgressHUD showMessage:@"注册用户"];
    //存储数据
    NSString *name = self.nameField.text;
    NSString *psw = self.pswField.text;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:name forKey:@"name"];
    [userDefaults setObject:psw forKey:@"psw"];
    [userDefaults synchronize];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController *myview=[story instantiateViewControllerWithIdentifier:@"denglu"];
        [self presentModalViewController:myview animated:YES];

    });
    
}

#pragma mark - swipe 轻扫
-(void) SwipeGesture{
    //初始化
    UISwipeGestureRecognizer *swipe1 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeActionLeft:)];
    //设置轻扫的方向
    swipe1.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipe1];
}

-(void) SwipeActionLeft:(UISwipeGestureRecognizer *)swipe{
    [self cheak];
}

- (IBAction)quxiao {
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *myview=[story instantiateViewControllerWithIdentifier:@"denglu"];
    [self presentModalViewController:myview animated:YES];
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
