//
//  LocationClass.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 01/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "LocationClass.h"

static LocationClass *sharedObj;

@implementation LocationClass

+ (LocationClass *)sharedInstance
{
    if(sharedObj == nil)
    {
        sharedObj = [[LocationClass alloc] init];
    }
    return sharedObj;
}

-(void)setLocationID:(NSMutableArray *)arr{
    idArr = [NSMutableArray array];
    idArr = arr;
}

-(NSMutableArray *)getLocationID{
    return idArr;
}

-(void)setLocationName:(NSMutableArray *)arr{
    nameArr = [NSMutableArray array];
    nameArr = arr;
}

-(NSMutableArray *)getLocationName{
    return nameArr;
}

-(void)setLocationBarCode:(NSMutableArray *)arr{
    barCodeArr = [NSMutableArray array];
    barCodeArr = arr;
}

-(NSMutableArray *)getLocationBarCode{
    return barCodeArr;
}

@end
