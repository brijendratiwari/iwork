//
//  CategoriesClass.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 01/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "CategoriesClass.h"

static CategoriesClass *sharedObj;

@implementation CategoriesClass

+ (CategoriesClass *)sharedInstance
{
    if(sharedObj == nil)
    {
        sharedObj = [[CategoriesClass alloc] init];
    }
    return sharedObj;
}

-(void)setCategoriesID:(NSMutableArray *)arr{
    idArr = [NSMutableArray array];
    idArr = arr;
}

-(NSMutableArray *)getCategoriesID{
    return idArr;
}

-(void)setCategoriesName:(NSMutableArray *)arr{
    nameArr = [NSMutableArray array];
    nameArr = arr;
}

-(NSMutableArray *)getCategoriesName{
    return nameArr;
}


@end
