//
//  LocationClass.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 01/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationClass : NSObject{
    NSMutableArray *idArr;
    NSMutableArray *nameArr;
    NSMutableArray *barCodeArr;
}

+ (LocationClass *)sharedInstance;
-(void)setLocationID:(NSMutableArray *)arr;
-(void)setLocationName:(NSMutableArray *)arr;
-(void)setLocationBarCode:(NSMutableArray *)arr;
-(NSMutableArray *)getLocationID;
-(NSMutableArray *)getLocationName;
-(NSMutableArray *)getLocationBarCode;



@end
