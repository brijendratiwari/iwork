//
//  StatusClass.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 17/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "StatusClass.h"

static StatusClass *sharedObj;

@implementation StatusClass

+ (StatusClass *)sharedInstance
{
    if(sharedObj == nil)
    {
        sharedObj = [[StatusClass alloc] init];
    }
    return sharedObj;
}

-(void)setStatusID:(NSMutableArray *)arr{
    idArr = [NSMutableArray array];
    idArr = arr;
}

-(NSMutableArray *)getStatusID{
    return idArr;
}

-(void)setStatusName:(NSMutableArray *)arr{
    nameArr = [NSMutableArray array];
    nameArr = arr;
}

-(NSMutableArray *)getStatusName{
    return nameArr;
}



@end
