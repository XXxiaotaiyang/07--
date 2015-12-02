//
//  Contact.m
//  07-私人通讯录
//
//  Created by 闲人 on 15/12/1.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import "Contact.h"

@implementation Contact
- (void)encodeWithCoder:(NSCoder *)encode
{
    [encode encodeObject:self.name forKey:@"name"];
    [encode encodeObject:self.telphone forKey:@"telphone"];
}
- (nullable instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        //一定要赋值
        self.name =  [decoder decodeObjectForKey:@"name"];
        self.telphone = [decoder decodeObjectForKey:@"telphone"];
    }
    
    return self;
}
@end
