//
//  ContactViewController.m
//  07-私人通讯录
//
//  Created by 闲人 on 15/12/1.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import "ContactViewController.h"
#import "AddContactViewController.h"
#import "Contact.h"

@interface ContactViewController ()<AddContactViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
/** 保存的联系人信息 */
@property(nonatomic, strong) NSMutableArray *contacts;
@end

@implementation ContactViewController

- (NSMutableArray *)contacts
{
    if (!_contacts) {
        self.contacts = [NSMutableArray array];
    }
    return _contacts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)AddContact:(id)sender {
    [self performSegueWithIdentifier:@"toAddContact" sender:nil];
}

/** 通过segue跳转就会用到这个方法的 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id destinationVC = segue.destinationViewController;
    if ([segue.destinationViewController isKindOfClass:[AddContactViewController class]]) {
        AddContactViewController *addContactVC = destinationVC;
        addContactVC.delegate = self;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView的数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Contact *contact = self.contacts[indexPath.row];
    
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.telphone;
    
    return cell;
}


#pragma mark - AddContactVC代理方法
- (void)addContactViewController:(AddContactViewController *)addContactVC didSaveContact:(Contact *)contact
{
    [self.contacts addObject:contact];
    
    // 刷新表格
    [self.tableView reloadData];
}

@end
