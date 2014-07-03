//
//  Supplier.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 09/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "Supplier.h"

@implementation Supplier
 @synthesize account_id ,our_account_number ,supplier_address1 ,supplier_address2 ,supplier_address3 ,supplier_contact_email ,supplier_contact_job_title ,supplier_contact_name ,supplier_county ,supplier_email ,supplier_id ,supplier_telephone ,supplier_title ,supplier_town ,supplier_website, supplier_postcode;

-(void)setSupplierData:(NSMutableArray *)dataV{
    if ([dataV valueForKey:@"account_id"] != (id)[NSNull null]) {
        [self setAccount_id:[dataV valueForKey:@"account_id"]];
    }else{
        [self setAccount_id:@""];
    }
    
    if ([dataV valueForKey:@"our_account_number"] != (id)[NSNull null]) {
        [self setOur_account_number:[dataV valueForKey:@"our_account_number"]];
    }else{
        [self setOur_account_number:@""];
    }
    
    if ([dataV valueForKey:@"supplier_address1"] != (id)[NSNull null]) {
        [self setSupplier_address1:[dataV valueForKey:@"supplier_address1"]];
    }else{
        [self setSupplier_address1:@""];
    }
    
    if ([dataV valueForKey:@"supplier_address2"] != (id)[NSNull null]) {
        [self setSupplier_address2:[dataV valueForKey:@"supplier_address2"]];
    }else{
        [self setSupplier_address2:@""];
    }
    
    if ([dataV valueForKey:@"supplier_address3"] != (id)[NSNull null]) {
        [self setSupplier_address3:[dataV valueForKey:@"supplier_address3"]];
    }else{
        [self setSupplier_address3:@""];
    }
    
    if ([dataV valueForKey:@"supplier_contact_email"] != (id)[NSNull null]) {
        [self setSupplier_contact_email:[dataV valueForKey:@"supplier_contact_email"]];
    }else{
        [self setSupplier_contact_email:@""];
    }
    
    if ([dataV valueForKey:@"supplier_contact_job_title"] != (id)[NSNull null]) {
        [self setSupplier_contact_job_title:[dataV valueForKey:@"supplier_contact_job_title"]];
    }else{
        [self setSupplier_contact_job_title:@""];
    }
    
    if ([dataV valueForKey:@"supplier_contact_name"] != (id)[NSNull null]) {
        [self setSupplier_contact_name:[dataV valueForKey:@"supplier_contact_name"]];
    }else{
        [self setSupplier_contact_name:@""];
    }
    
    if ([dataV valueForKey:@"supplier_county"] != (id)[NSNull null]) {
        [self setSupplier_county:[dataV valueForKey:@"supplier_county"]];
    }else{
        [self setSupplier_county:@""];
    }
    
    if ([dataV valueForKey:@"supplier_email"] != (id)[NSNull null]) {
        [self setSupplier_email:[dataV valueForKey:@"supplier_email"]];
    }else{
        [self setSupplier_email:@""];
    }
    
    if ([dataV valueForKey:@"supplier_id"] != (id)[NSNull null]) {
        [self setSupplier_id:[dataV valueForKey:@"supplier_id"]];
    }else{
        [self setSupplier_id:@""];
    }
    
    if ([dataV valueForKey:@"supplier_postcode"] != (id)[NSNull null]) {
        [self setSupplier_postcode:[dataV valueForKey:@"supplier_postcode"]];
    }else{
        [self setSupplier_postcode:@""];
    }
    
    if ([dataV valueForKey:@"supplier_telephone"] != (id)[NSNull null]) {
        [self setSupplier_telephone:[dataV valueForKey:@"supplier_telephone"]];
    }else{
        [self setSupplier_telephone:@""];
    }
    
    if ([dataV valueForKey:@"supplier_title"] != (id)[NSNull null]) {
        [self setSupplier_title:[dataV valueForKey:@"supplier_title"]];
    }else{
        [self setSupplier_title:@""];
    }
    
    if ([dataV valueForKey:@"supplier_town"] != (id)[NSNull null]) {
        [self setSupplier_town:[dataV valueForKey:@"supplier_town"]];
    }else{
        [self setSupplier_town:@""];
    }
    
    if ([dataV valueForKey:@"supplier_website"] != (id)[NSNull null]) {
        [self setSupplier_website:[dataV valueForKey:@"supplier_website"]];
    }else{
        [self setSupplier_website:@""];
    }
    
}

@end
