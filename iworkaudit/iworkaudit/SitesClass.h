//
//  SitesClass.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 01/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SitesClass : NSObject{
    NSMutableArray *idArr;
    NSMutableArray *nameArr;
}
+ (SitesClass *)sharedInstance;
-(void)setSitesID:(NSMutableArray *)arr;
-(void)setSitesName:(NSMutableArray *)arr;
-(NSMutableArray *)getSitesID;
-(NSMutableArray *)getSitesName;
@end


