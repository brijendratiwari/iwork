//
//  VehicleResults.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 09/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VehicleResults : NSObject

@property (nonatomic, readonly, strong) NSMutableArray *vechicles;

+ (VehicleResults *)sharedInstance;
-(void)setAllVehicleInArray:(NSDictionary *)dicV;

@end
