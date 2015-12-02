//
//  EditContactViewController.m
//  07-私人通讯录
//
//  Created by 闲人 on 15/12/1.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import "EditContactViewController.h"

@interface EditContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField  *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField  *telphoneTextField;
@property (weak, nonatomic) IBOutlet UIButton     *saveBtn;

@end

@implementation EditContactViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTextField.text     = self.contact.name;
    self.telphoneTextField.text = self.contact.telphone;
    
    // 默认设置文本框不可用
    self.nameTextField.enabled      = NO;
    self.telphoneTextField.enabled  = NO;
    self.saveBtn.hidden             = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

// 监听编辑按钮的点击
- (IBAction)editBtn:(UIBarButtonItem *)item {

    self.nameTextField.enabled      = !self.nameTextField.enabled;
    self.telphoneTextField.enabled  = !self.telphoneTextField.enabled;
    self.saveBtn.hidden       = !self.saveBtn.hidden;
    
    if (self.nameTextField.enabled) {
        item.title = @"取消";
    }else {
        item.title = @"编辑";
    }
    
    
}

- (IBAction)saveBtnClick {
    
//    // 获取姓名
    self.contact.name = self.nameTextField.text;
    // 获取电话
    self.contact.telphone = self.telphoneTextField.text;
    
    if ([self.delegate respondsToSelector:@selector(editContactViewController:didSaveContact:)]) {
    
        [self.delegate editContactViewController:self didSaveContact:self.contact];
    }

}


@end
