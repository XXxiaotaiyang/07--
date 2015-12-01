//
//  AddContactViewController.m
//  07-私人通讯录
//
//  Created by 闲人 on 15/12/1.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import "AddContactViewController.h"
#import "Contact.h"

@interface AddContactViewController ()
/** 姓名 */
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
/** 电话*/
@property (weak, nonatomic) IBOutlet UITextField *telphoneTextField;

@end

@implementation AddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveBtnClick {
    Contact *contact = [[Contact alloc] init];
    // 获取姓名
    contact.name = self.nameTextField.text;
    // 获取电话
    contact.telphone = self.telphoneTextField.text;
    
    if ([self.delegate respondsToSelector:@selector(addContactViewController:didSaveContact:)]) {
        [self.delegate addContactViewController:self didSaveContact:contact];
    }
}


@end
