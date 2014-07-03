//
//  ManufactureClass.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 01/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "ManufactureClass.h"

static ManufactureClass *sharedObj;

@implementation ManufactureClass

+ (ManufactureClass *)sharedInstance
{
    if(sharedObj == nil)
    {
        sharedObj = [[ManufactureClass alloc] init];
    }
    return sharedObj;
}

-(void)setManufactureName:(NSMutableArray *)arr{
    nameArr = [NSMutableArray array];
    nameArr = arr;
}

-(NSMutableArray *)getManufactureName{
    return nameArr;
}

@end
