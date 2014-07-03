//
//  Vechicles.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 09/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vechicles : NSObject

@property (nonatomic, strong) NSString *activeText;
@property (nonatomic, strong) NSString *current_valueText;
@property (nonatomic, strong) NSString *deleted_dateText;
@property (nonatomic, strong) NSString *engine_sizeText;
@property (nonatomic, strong) NSString *firstnameText;
@property (nonatomic, strong) NSString *insurance_expirationText;
@property (nonatomic, strong) NSString *is_locationText;
@property (nonatomic, strong) NSString *last_serviceText;
@property (nonatomic, strong) NSString *lastnameText;
@property (nonatomic, strong) NSString *location_nowText;
@property (nonatomic, strong) NSString *mark_deletedText;
@property (nonatomic, strong) NSString *mark_deleted_2Text;
@property (nonatomic, strong) NSString *mark_deleted_2_dateText;
@property (nonatomic, strong) NSString *mark_deleted_dateText;
@property (nonatomic, strong) NSString *nameText;
@property (nonatomic, strong) NSString *notesText;
@property (nonatomic, strong) NSString *ownerText;
@property (nonatomic, strong) NSString *owner_nowText;
@property (nonatomic, strong) NSString *purchase_dateText;
@property (nonatomic, strong) NSString *siteText;
@property (nonatomic, strong) NSString *site_nowText;
@property (nonatomic, strong) NSString *tax_expirationText;
@property (nonatomic, strong) NSString *vehicle_valueText;
@property (nonatomic, strong) NSString *warranty_expirationText;
@property (nonatomic, strong) NSString *yearText;
@property (nonatomic, strong) NSString *barcodeText;
@property (nonatomic, strong) NSString *fleetidText;
@property (nonatomic, strong) NSString *makeText;
@property (nonatomic, strong) NSString *modelText;
@property (nonatomic, strong) NSString *reg_noText;



-(void)setVechicleData:(NSMutableArray *)dataV;

@end
