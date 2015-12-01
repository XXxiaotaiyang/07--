//
//  ContactViewController.m
//  07-私人通讯录
//
//  Created by 闲人 on 15/12/1.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)AddContact:(id)sender {
    [self performSegueWithIdentifier:@"toAddContact" sender:nil];
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
