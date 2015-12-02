//
//  Contact.h
//  07-私人通讯录
//
//  Created by 闲人 on 15/12/1.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject<NSCoding>
/** 通讯录名字 */
@property (nonatomic, copy) NSString *name;
/** 通讯录的电话 */
@property (nonatomic, copy) NSString *telphone;
@end
