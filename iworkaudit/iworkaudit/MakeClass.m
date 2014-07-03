//
//  MakeClass.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 09/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "MakeClass.h"

static MakeClass *sharedObj;

@implementation MakeClass

+ (MakeClass *)sharedInstance
{
    if(sharedObj == nil)
    {
        sharedObj = [[MakeClass alloc] init];
    }
    return sharedObj;
}

-(void)setMakeID:(NSMutableArray *)arr{
    idArr = [NSMutableArray array];
    idArr = arr;
}

-(NSMutableArray *)getMakeID{
    return idArr;
}

-(void)setMakeName:(NSMutableArray *)arr{
    nameArr = [NSMutableArray array];
    nameArr = arr;
}

-(NSMutableArray *)getMakeName{
    return nameArr;
}


@end
