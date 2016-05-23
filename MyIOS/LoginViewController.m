//
//  LoginViewController.m
//  MyIOS
//
//  Created by Anna on 16/5/21.
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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pswField];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void) textChange
{
    if(self.nameField.text.length && self.pswField.text.length){
        self.loginBtn.enabled = YES;
    }
    else
    {
        self.loginBtn.enabled = NO;
    }
}

- (IBAction)cheakLogin {
    if(![self.nameField.text isEqualToString:@"123"]){
        [MBProgressHUD showError:@"账号不存在"];
        return;
    }
    if (![self.pswField.text isEqualToString:@"123"]) {
        [MBProgressHUD showError:@"密码不正确"];
        return;
    }
    //显示蒙层
    [MBProgressHUD showMessage:@"努力加载中"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [self performSegueWithIdentifier:@"LoginToMain" sender:nil];
    });
    
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

@end
