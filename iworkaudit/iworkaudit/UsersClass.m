//
//  UsersClass.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 01/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "UsersClass.h"

static UsersClass *sharedObj;

@implementation UsersClass

+ (UsersClass *)sharedInstance
{
    if(sharedObj == nil)
    {
        sharedObj = [[UsersClass alloc] init];
    }
    return sharedObj;
}

-(void)setUsersID:(NSMutableArray *)arr{
    idArr = [NSMutableArray array];
    idArr = arr;
}

-(NSMutableArray *)getUsersID{
    return idArr;
}

-(void)setUsersName:(NSMutableArray *)arr{
    nameArr = [NSMutableArray array];
    nameArr = arr;
}

-(NSMutableArray *)getUsersName{
    return nameArr;
}


@end
