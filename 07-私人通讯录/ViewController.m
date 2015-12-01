//
//  ViewController.m
//  07-私人通讯录
//
//  Created by 闲人 on 15/12/1.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+CZ.h"
#import "ContactViewController.h"
//#import "MBProgressHUD/MBProgressHUD.h"

@interface ViewController ()
/** 帐号信息 */
@property (weak, nonatomic) IBOutlet UITextField *accountField;
/** 密码 */
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
/** 登录按钮 */
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
/** 登录按钮点击 */
- (IBAction)loginBtnClick:(UIButton *)sender;
/** 记住密码 */
@property (weak, nonatomic) IBOutlet UISwitch *remeberPwdSwitch;
/** 自动登录 */
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.accountField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passwordField];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textChange
{
    self.loginBtn.enabled = (self.accountField.text.length != 0 && self.passwordField.text.length != 0);
    
}


#pragma mark - 监听登录界面的按钮点击

- (IBAction)loginBtnClick:(UIButton *)sender {
    
    NSString *account = self.accountField.text;
    NSString *password = self.passwordField.text;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([account isEqualToString:@"zhangchaochao"] && [password isEqualToString:@"321"]) {
            NSLog(@"帐号密码正确");
            
            [MBProgressHUD showSuccess:@"正确 准备跳转"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                ContactViewController *contactVC = [[ContactViewController alloc] init];
                [self performSegueWithIdentifier:@"toContact" sender:nil];
            });
            
        }else{
            [MBProgressHUD showError:@"帐号或者密码不正确"];
        }
    });
    
}

/** 如果记住密码关闭  就将自动登录关闭 */
- (IBAction)remeberPwdSwitchChange:(id)sender {
    if (self.remeberPwdSwitch.isOn == NO && self.autoLoginSwitch.isOn == YES) {
        
        [self.autoLoginSwitch setOn:NO animated:YES];
    }
}

/** 如果自动登录打开  就把记住密码打开 */
- (IBAction)autoLoginSwitchChange:(id)sender {
    if (self.remeberPwdSwitch.isOn == NO && self.autoLoginSwitch.isOn == YES) {
        
        [self.remeberPwdSwitch setOn:YES animated:YES];
    }
}

@end
