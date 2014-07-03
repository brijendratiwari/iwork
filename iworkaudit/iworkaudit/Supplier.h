//
//  Supplier.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 09/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Supplier : NSObject

@property (nonatomic, strong) NSString *account_id;
@property (nonatomic, strong) NSString *our_account_number;
@property (nonatomic, strong) NSString *supplier_address1;
@property (nonatomic, strong) NSString *supplier_address2;
@property (nonatomic, strong) NSString *supplier_address3;
@property (nonatomic, strong) NSString *supplier_contact_email;
@property (nonatomic, strong) NSString *supplier_contact_job_title;
@property (nonatomic, strong) NSString *supplier_contact_name;
@property (nonatomic, strong) NSString *supplier_county;
@property (nonatomic, strong) NSString *supplier_email;
@property (nonatomic, strong) NSString *supplier_id;
@property (nonatomic, strong) NSString *supplier_telephone;
@property (nonatomic, strong) NSString *supplier_title;
@property (nonatomic, strong) NSString *supplier_town;
@property (nonatomic, strong) NSString *supplier_website;
@property (nonatomic, strong) NSString *supplier_postcode;

-(void)setSupplierData:(NSMutableArray *)dataV;

@end
