//
//  VehicleResults.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 09/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "VehicleResults.h"
#include "Vechicles.h"

static VehicleResults *sharedObj;

@implementation VehicleResults
@synthesize vechicles;

+ (VehicleResults *)sharedInstance
{
    if(sharedObj == nil)
    {
        sharedObj = [[VehicleResults alloc] init];
    }
    return sharedObj;
}

-(void)setAllVehicleInArray:(NSMutableArray *)arrV{
    vechicles = [NSMutableArray array];
    
    for(NSMutableArray *vechicle in arrV) {
        Vechicles *v = [[Vechicles alloc] init];
        NSLog(@"item created %@",v);
        [v setVechicleData:vechicle];
        [vechicles addObject:v];
        
    }
}


@end
