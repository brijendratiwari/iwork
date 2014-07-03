//
//  Vechicles.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 09/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "Vechicles.h"

@implementation Vechicles
@synthesize barcodeText,fleetidText,makeText,modelText,reg_noText;

-(void)setVechicleData:(NSMutableArray *)dataV{
    
    if ([dataV valueForKey:@"active"] != (id)[NSNull null]) {
        [self setActiveText:[dataV valueForKey:@"active"]];
    }else{
        [self setActiveText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"current_value"] != (id)[NSNull null]) {
        [self setCurrent_valueText:[dataV valueForKey:@"current_value"]];
    }else{
        [self setCurrent_valueText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"deleted_date"] != (id)[NSNull null]) {
        [self setDeleted_dateText:[dataV valueForKey:@"deleted_date"]];
    }else{
        [self setDeleted_dateText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"engine_size"] != (id)[NSNull null]) {
        [self setEngine_sizeText:[dataV valueForKey:@"engine_size"]];
    }else{
        [self setEngine_sizeText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"insurance_expiration"] != (id)[NSNull null]) {
        [self setInsurance_expirationText:[dataV valueForKey:@"insurance_expiration"]];
    }else{
        [self setInsurance_expirationText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"is_location"] != (id)[NSNull null]) {
        [self setIs_locationText:[dataV valueForKey:@"is_location"]];
    }else{
        [self setIs_locationText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"last_service"] != (id)[NSNull null]) {
        [self setLast_serviceText:[dataV valueForKey:@"last_service"]];
    }else{
        [self setLast_serviceText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"lastname"] != (id)[NSNull null]) {
        [self setLastnameText:[dataV valueForKey:@"lastname"]];
    }else{
        [self setLastnameText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"location_now"] != (id)[NSNull null]) {
        [self setLocation_nowText:[dataV valueForKey:@"location_now"]];
    }else{
        [self setLocation_nowText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"mark_deleted"] != (id)[NSNull null]) {
        [self setMark_deletedText:[dataV valueForKey:@"mark_deleted"]];
    }else{
        [self setMark_deletedText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"mark_deleted_2"] != (id)[NSNull null]) {
        [self setMark_deleted_2Text:[dataV valueForKey:@"mark_deleted_2"]];
    }else{
        [self setMark_deleted_2Text:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"mark_deleted_2_date"] != (id)[NSNull null]) {
        [self setMark_deleted_2_dateText:[dataV valueForKey:@"mark_deleted_2_date"]];
    }else{
        [self setMark_deleted_2_dateText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"mark_deleted_date"] != (id)[NSNull null]) {
        [self setMark_deleted_dateText:[dataV valueForKey:@"mark_deleted_date"]];
    }else{
        [self setMark_deleted_dateText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"notes"] != (id)[NSNull null]) {
        [self setNotesText:[dataV valueForKey:@"notes"]];
    }else{
        [self setNotesText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"owner"] != (id)[NSNull null]) {
        [self setOwnerText:[dataV valueForKey:@"owner"]];
    }else{
        [self setOwnerText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"owner_now"] != (id)[NSNull null]) {
        [self setOwner_nowText:[dataV valueForKey:@"owner_now"]];
    }else{
        [self setOwner_nowText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"purchase_date"] != (id)[NSNull null]) {
        [self setPurchase_dateText:[dataV valueForKey:@"purchase_date"]];
    }else{
        [self setPurchase_dateText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"reg_no"] != (id)[NSNull null]) {
        [self setReg_noText:[dataV valueForKey:@"reg_no"]];
    }else{
        [self setReg_noText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"site"] != (id)[NSNull null]) {
        [self setSiteText:[dataV valueForKey:@"site"]];
    }else{
        [self setSiteText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"site_now"] != (id)[NSNull null]) {
        [self setSite_nowText:[dataV valueForKey:@"site_now"]];
    }else{
        [self setSite_nowText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"tax_expiration"] != (id)[NSNull null]) {
        [self setTax_expirationText:[dataV valueForKey:@"tax_expiration"]];
    }else{
        [self setTax_expirationText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"vehicle_value"] != (id)[NSNull null]) {
        [self setVehicle_valueText:[dataV valueForKey:@"vehicle_value"]];
    }else{
        [self setVehicle_valueText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"warranty_expiration"] != (id)[NSNull null]) {
        [self setWarranty_expirationText:[dataV valueForKey:@"warranty_expiration"]];
    }else{
        [self setWarranty_expirationText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"year"] != (id)[NSNull null]) {
        [self setYearText:[dataV valueForKey:@"year"]];
    }else{
        [self setYearText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"name"] != (id)[NSNull null]) {
        [self setNameText:[dataV valueForKey:@"name"]];
    }else{
        [self setNameText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"firstname"] != (id)[NSNull null]) {
        [self setFirstnameText:[dataV valueForKey:@"firstname"]];
    }else{
        [self setFirstnameText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"barcode"] != (id)[NSNull null]) {
        [self setBarcodeText:[dataV valueForKey:@"barcode"]];
    }else{
        [self setBarcodeText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"fleet_id"] != (id)[NSNull null]) {
        [self setFleetidText:[dataV valueForKey:@"fleet_id"]];
    }else{
        [self setFleetidText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"make"] != (id)[NSNull null]) {
        [self setMakeText:[dataV valueForKey:@"make"]];
    }else{
        [self setMakeText:@""];
    }
    
    if ([dataV valueForKey:@"model"] != (id)[NSNull null]) {
        [self setModelText:[dataV valueForKey:@"model"]];
    }else{
        [self setModelText:@""];
    }
    
    if ([dataV valueForKey:@"reg_no"] != (id)[NSNull null]) {
        [self setReg_noText:[dataV valueForKey:@"reg_no"]];
    }else{
        [self setReg_noText:@"Not Available"];
    }
}

@end
