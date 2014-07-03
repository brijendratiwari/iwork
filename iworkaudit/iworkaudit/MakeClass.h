//
//  MakeClass.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 09/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MakeClass : NSObject{
    NSMutableArray *idArr;
    NSMutableArray *nameArr;
}

+ (MakeClass *)sharedInstance;
-(void)setMakeID:(NSMutableArray *)arr;
-(void)setMakeName:(NSMutableArray *)arr;
-(NSMutableArray *)getMakeID;
-(NSMutableArray *)getMakeName;


@end
