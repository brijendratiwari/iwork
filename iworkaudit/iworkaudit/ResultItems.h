//
//  ResultItems.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 05/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultItems : NSObject

@property (nonatomic, readonly, strong) NSMutableArray *items;

+ (ResultItems *)sharedInstance;
-(void)setAllItemsInArray:(NSDictionary *)dicV;
@end
