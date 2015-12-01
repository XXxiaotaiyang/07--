//
//  AddContactViewController.h
//  07-私人通讯录
//
//  Created by 闲人 on 15/12/1.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddContactViewController;
@class Contact;
@protocol AddContactViewControllerDelegate <NSObject>
@optional
- (void)addContactViewController:(AddContactViewController *)addContactVC didSaveContact:(Contact *)contact;

@end

@interface AddContactViewController : UIViewController
@property(nonatomic, weak) id<AddContactViewControllerDelegate> delegate;

@end
