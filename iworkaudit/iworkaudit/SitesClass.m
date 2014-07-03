//
//  SitesClass.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 01/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "SitesClass.h"

static SitesClass *sharedObj;

@implementation SitesClass

+ (SitesClass *)sharedInstance
{
    if(sharedObj == nil)
    {
        sharedObj = [[SitesClass alloc] init];
    }
    return sharedObj;
}

-(void)setSitesID:(NSMutableArray *)arr{
    idArr = [NSMutableArray array];
    idArr = arr;
}

-(NSMutableArray *)getSitesID{
    return idArr;
}

-(void)setSitesName:(NSMutableArray *)arr{
    nameArr = [NSMutableArray array];
    nameArr = arr;
}

-(NSMutableArray *)getSitesName{
    return nameArr;
}


@end
