//
//  ResultItems.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 05/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "ResultItems.h"
#import "Item.h"

static ResultItems *sharedObj;

@implementation ResultItems
@synthesize items;

+ (ResultItems *)sharedInstance
{
    if(sharedObj == nil)
    {
        sharedObj = [[ResultItems alloc] init];
    }
    return sharedObj;
}

-(void)setAllItemsInArray:(NSMutableArray *)arrV{
    items = [NSMutableArray array];

    for(NSMutableArray *item in arrV) {
        Item *i = [[Item alloc] init];
      //  NSLog(@"item created %@",i);
        [i setItemData:item];
        [items addObject:i];
    }
}

@end
