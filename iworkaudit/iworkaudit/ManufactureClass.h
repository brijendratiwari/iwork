//
//  ManufactureClass.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 01/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManufactureClass : NSObject{

    NSMutableArray *nameArr;
}
+ (ManufactureClass *)sharedInstance;
-(void)setManufactureName:(NSMutableArray *)arr;
-(NSMutableArray *)getManufactureName;

@end
