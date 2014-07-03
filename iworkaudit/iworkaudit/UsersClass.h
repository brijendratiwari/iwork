//
//  UsersClass.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 01/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UsersClass : NSObject{
    NSMutableArray *idArr;
    NSMutableArray *nameArr;
}
+ (UsersClass *)sharedInstance;
-(void)setUsersID:(NSMutableArray *)arr;
-(void)setUsersName:(NSMutableArray *)arr;
-(NSMutableArray *)getUsersID;
-(NSMutableArray *)getUsersName;
@end

