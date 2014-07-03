//
//  SupplierResult.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 09/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SupplierResult : NSObject

@property (nonatomic, readonly, strong) NSMutableArray *suppliers;

+ (SupplierResult *)sharedInstance;
-(void)setAllSuppliersInArray:(NSDictionary *)dicV;

@end
