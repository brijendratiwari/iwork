//
//  SupplierResult.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 09/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "SupplierResult.h"
#import "Supplier.h"

static SupplierResult *sharedObj;

@implementation SupplierResult

@synthesize suppliers;

+ (SupplierResult *)sharedInstance
{
    if(sharedObj == nil)
    {
        sharedObj = [[SupplierResult alloc] init];
    }
    return sharedObj;
}

-(void)setAllSuppliersInArray:(NSDictionary *)arrV{
    suppliers = [NSMutableArray array];
    
    for(NSMutableArray *sup in arrV) {
        Supplier *s = [[Supplier alloc] init];
        NSLog(@"item created %@",s);
        [s setSupplierData:sup];
        [suppliers addObject:s];
    }
}


@end
