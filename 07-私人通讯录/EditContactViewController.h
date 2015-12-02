//
//  EditContactViewController.h
//  07-私人通讯录
//
//  Created by 闲人 on 15/12/1.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
@class EditContactViewController;
@protocol EditContactViewControllerDelegate <NSObject>
@optional
- (void)editContactViewController:(EditContactViewController *)editContactVC didSaveContact:(Contact *)contact;

@end


@interface EditContactViewController : UIViewController

@property(nonatomic, weak) id<EditContactViewControllerDelegate> delegate;

@property(nonatomic, strong) Contact *contact;


@end
