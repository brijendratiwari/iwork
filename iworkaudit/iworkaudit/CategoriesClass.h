//
//  CategoriesClass.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 01/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoriesClass : NSObject{
    NSMutableArray *idArr;
    NSMutableArray *nameArr;
}
+ (CategoriesClass *)sharedInstance;
-(void)setCategoriesID:(NSMutableArray *)arr;
-(void)setCategoriesName:(NSMutableArray *)arr;
-(NSMutableArray *)getCategoriesID;
-(NSMutableArray *)getCategoriesName;
@end
