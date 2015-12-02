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
#import "EditContactViewController.h"

@interface ContactViewController ()<AddContactViewControllerDelegate,EditContactViewControllerDelegate, UITableViewDataSource,UITableViewDelegate>
/** 保存的联系人信息 */
@property(nonatomic, strong) NSMutableArray *contacts;
@property(nonatomic, assign) NSInteger selectRow;
/** 联系人数据的保存路径 */
@property (nonatomic, copy) NSString *contactPath;
@end

@implementation ContactViewController

#pragma mark - 懒加载们
- (NSString *)contactPath
{
    if (!_contactPath) {
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [doc stringByAppendingPathComponent:@"contactPaht.archiver"];
        
        self.contactPath = path;
    }
    return _contactPath;
}


- (NSMutableArray *)contacts
{
    if (!_contacts) {
        // 先从沙盒中取  如果没有再创建新的
        self.contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:self.contactPath];
        if (!_contacts) {
            self.contacts = [NSMutableArray array];
        }
    }
    return _contacts;
}

#pragma mark - 视图启动
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 在导航栏右边添加删除按钮
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delete)];
    self.navigationItem.rightBarButtonItems = @[deleteItem,self.navigationItem.rightBarButtonItem];
    
}

- (void)delete
{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return UITableViewCellEditingStyleInsert;
    }
    
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if(editingStyle == UITableViewCellEditingStyleDelete){//删除
        
        //删除联系人
        [self.contacts removeObjectAtIndex:indexPath.row];
        
        //刷新表格
        NSIndexPath *deleteIndex = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        [self.tableView deleteRowsAtIndexPaths:@[deleteIndex] withRowAnimation:UITableViewRowAnimationFade];
        
        //同步数据
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:self.contactPath];
        
    }else if(editingStyle == UITableViewCellEditingStyleInsert){//添加按钮
        //添加一个10086联系人
        Contact *contact = [[Contact alloc] init];
        contact.name = @"中国移动";
        contact.telphone = @"10086";
        
        //保存数据，刷新表格
        [self.contacts insertObject:contact atIndex:indexPath.row + 1];
        
        NSIndexPath *insertIndex = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[insertIndex] withRowAnimation:UITableViewRowAnimationFade];
        
        //同步数据
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:self.contactPath];
        
    }
}


- (IBAction)AddContact:(id)sender
{
    [self performSegueWithIdentifier:@"toAddContact" sender:nil];
}

// 注销按钮的点击
- (IBAction)logoutBtnClick:(UIBarButtonItem *)sender
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提醒"
                                                                   message:@"您将要注销登录"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction * action) {
                                                              [self.navigationController popViewControllerAnimated:YES];
                                                          }];
    
    UIAlertAction* defaultAction2 = [UIAlertAction actionWithTitle:@"other" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [alert addAction:defaultAction1];
    [alert addAction:defaultAction2];
    
    [self presentViewController:alert animated:YES completion:nil];
}




/** 通过segue跳转就会用到这个方法的 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id destinationVC = segue.destinationViewController;
    if ([segue.destinationViewController isKindOfClass:[AddContactViewController class]]) {
        AddContactViewController *addContactVC = destinationVC;
        addContactVC.delegate = self;
    }else if ([segue.destinationViewController isKindOfClass:[EditContactViewController class]]){
        
        EditContactViewController *editContaciVC = destinationVC;
        editContaciVC.delegate = self;
        
        NSInteger selectRow = self.tableView.indexPathForSelectedRow.row;
        Contact *contact = self.contacts[selectRow];
        
        editContaciVC.contact = contact;
        
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    Contact *contact = self.contacts[indexPath.row];
    
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.telphone;
    
    return cell;
}

#pragma mark - tableView 的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self  performSegueWithIdentifier:@"editContact" sender:nil];
    
    self.selectRow =  indexPath.row;

}


#pragma mark - AddContactVC代理方法
- (void)addContactViewController:(AddContactViewController *)addContactVC didSaveContact:(Contact *)contact
{
    [self.contacts addObject:contact];
    
    // 刷新表格
    [self.tableView reloadData];
    
    // 退出addVC
    [self.navigationController popViewControllerAnimated:YES];
    
    // 同步新数据到 沙盒
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:self.contactPath];
    
    
}
#pragma mark - EditContactVC代理方法
- (void)editContactViewController:(EditContactViewController *)editContactVC didSaveContact:(Contact *)contact
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    //  局部刷新
    
    //  获取当前刷新的行
    NSInteger row = [self.contacts indexOfObject:contact];
    NSIndexPath *refreshIndex = [NSIndexPath indexPathForRow:row inSection:0];
    
    NSLog(@"%ld", self.selectRow);
    
    [self.tableView reloadRowsAtIndexPaths:@[refreshIndex] withRowAnimation:UITableViewRowAnimationFade];
    
    //  同步新数据到 沙盒
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:self.contactPath];

}

@end
