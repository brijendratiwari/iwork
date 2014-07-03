//
//  StatusClass.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 17/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusClass : NSObject{
    NSMutableArray *idArr;
    NSMutableArray *nameArr;
}
+ (StatusClass *)sharedInstance;
-(void)setStatusID:(NSMutableArray *)arr;
-(void)setStatusName:(NSMutableArray *)arr;
-(NSMutableArray *)getStatusID;
-(NSMutableArray *)getStatusName;

@end