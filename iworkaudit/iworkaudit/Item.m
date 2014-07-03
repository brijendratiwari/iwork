//
//  Item.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 05/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "Item.h"

@implementation Item
@synthesize barcodeText,categoryidText,categorynameText,itemidText,itemphotoidText,itemphototitleText,locationidText,locationnameText,modelText,manufacturerText,siteidText,sitenameText,statusnameText,userfirstnameText,useridText,userlastnameText,usernicknameText;

@synthesize location_nowText,location_sinceText,owner_sinceText,owner_nowText,pattest_dateText,pattest_statusText,purchase_dateText,quantityText,replace_dateText,serial_numberText,valueText,warranty_dateText,statusIDText,notesText,supplierText,suppliers_titleText,itemphotopathText,current_valueText,pdf_nameArr;


-(void)setItemData:(NSMutableArray *)dataV{
    
    if ([dataV valueForKey:@"locationid"] != (id)[NSNull null]) {
        [self setLocationidText:[dataV valueForKey:@"locationid"]];
    }else{
        [self setLocationidText:@""];
    }
    
    if ([dataV valueForKey:@"barcode"] != (id)[NSNull null]) {
        [self setBarcodeText:[dataV valueForKey:@"barcode"]];
    }else{
        [self setBarcodeText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"categoryid"] != (id)[NSNull null]) {
       [self setCategoryidText:[dataV valueForKey:@"categoryid"]];
    }else{
        [self setCategoryidText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"categoryname"] != (id)[NSNull null]) {
        [self setCategorynameText:[dataV valueForKey:@"categoryname"]];
    }else{
        [self setCategorynameText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"itemid"] != (id)[NSNull null]) {
        [self setItemidText:[dataV valueForKey:@"itemid"]];
    }else{
        [self setItemidText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"itemphotoid"] != (id)[NSNull null]) {
         [self setItemphotoidText:[dataV valueForKey:@"itemphotoid"]];
    }else{
        [self setItemphotoidText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"itemphototitle"] != (id)[NSNull null]) {
        [self setItemphototitleText:[dataV valueForKey:@"itemphototitle"]];
    }else{
        [self setItemphototitleText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"itemstatusid"] != (id)[NSNull null]) {
        [self setStatusIDText:[dataV valueForKey:@"itemstatusid"]];
    }else{
        [self setStatusIDText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"locationname"] != (id)[NSNull null]) {
         [self setLocationnameText:[dataV valueForKey:@"locationname"]];
    }else{
        [self setLocationnameText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"manufacturer"] != (id)[NSNull null]) {
        [self setManufacturerText:[dataV valueForKey:@"manufacturer"]];
    }else{
        [self setManufacturerText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"model"] != (id)[NSNull null]) {
       [self setModelText:[dataV valueForKey:@"model"]];
    }else{
        [self setModelText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"notes"] != (id)[NSNull null]) {
        [self setNotesText:[dataV valueForKey:@"notes"]];
    }else{
        [self setNotesText:@"Not Available"];
    }
   
    if ([dataV valueForKey:@"siteid"] != (id)[NSNull null]) {
       [self setSiteidText:[dataV valueForKey:@"siteid"]];
    }else{
        [self setSiteidText:@""];
    }
   
    if ([dataV valueForKey:@"sitename"] != (id)[NSNull null]) {
         [self setSitenameText:[dataV valueForKey:@"sitename"]];
    }else{
        [self setSitenameText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"supplier"] != (id)[NSNull null]) {
        [self setSupplierText:[dataV valueForKey:@"supplier"]];
    }else{
        [self setSupplierText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"suppliers_title"] != (id)[NSNull null]) {
        [self setSuppliers_titleText:[dataV valueForKey:@"suppliers_title"]];
    }else{
        [self setSuppliers_titleText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"itemstatusname"] != (id)[NSNull null]) {
         [self setStatusnameText:[dataV valueForKey:@"itemstatusname"]];
    }else{
        [self setStatusnameText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"userfirstname"] != (id)[NSNull null]) {
         [self setUserfirstnameText:[dataV valueForKey:@"userfirstname"]];
    }else{
        [self setUserfirstnameText:@"Not Available"];
    }
   
    if ([dataV valueForKey:@"userid"] != (id)[NSNull null]) {
        [self setUseridText:[dataV valueForKey:@"userid"]];
    }else{
        [self setUseridText:@""];
    }
    
    if ([dataV valueForKey:@"userlastname"] != (id)[NSNull null]) {
         [self setUserlastnameText:[dataV valueForKey:@"userlastname"]];
    }else{
        [self setUserlastnameText:@"Not Available"];
    }
   
    if ([dataV valueForKey:@"usernickname"] != (id)[NSNull null]) {
        [self setUsernicknameText:[dataV valueForKey:@"usernickname"]];
    }else{
        [self setUsernicknameText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"location_now"] != (id)[NSNull null]) {
        [self setLocation_nowText:[dataV valueForKey:@"location_now"]];
    }else{
        [self setLocation_nowText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"location_since"] != (id)[NSNull null]) {
        [self setLocation_sinceText:[dataV valueForKey:@"location_since"]];
    }else{
        [self setLocation_sinceText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"owner_since"] != (id)[NSNull null]) {
        [self setOwner_sinceText:[dataV valueForKey:@"owner_since"]];
    }else{
        [self setOwner_sinceText: @"Not Available"];
    }
    
    if ([dataV valueForKey:@"owner_now"] != (id)[NSNull null]) {
        [self setOwner_nowText:[dataV valueForKey:@"owner_now"]];
    }else{
        [self setOwner_nowText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"pattest_date"] != (id)[NSNull null]) {
        [self setPattest_dateText:[dataV valueForKey:@"pattest_date"]];
    }else{
        [self setPattest_dateText:@"Not Available"];
    }
    
    NSString *patStr = [dataV valueForKey:@"pattest_status"];
    
    if ([dataV valueForKey:@"pattest_status"] != (id)[NSNull null]) {
       // [self setPattest_statusText:[dataV valueForKey:@"pattest_status"]];
        
        if ([patStr isEqualToString:@"-1"]) {
            [self setPattest_statusText:@"Unknown"];
        }
        if ([patStr isEqualToString:@"1"]) {
            [self setPattest_statusText:@"Pass"];
        }
        if ([patStr isEqualToString:@"0"]) {
            [self setPattest_statusText:@"Fail"];
        }
        if ([patStr isEqualToString:@"5"]) {
            [self setPattest_statusText:@"Not Required"];
        }
        
    }else{
        [self setPattest_statusText: @"Not Required"];
    }
    
    if ([dataV valueForKey:@"purchase_date"] != (id)[NSNull null]) {
        [self setPurchase_dateText:[dataV valueForKey:@"purchase_date"]];
    }else{
        [self setPurchase_dateText: @"Not Available"];
    }
    
    if ([dataV valueForKey:@"quantity"] != (id)[NSNull null]) {
        [self setQuantityText:[dataV valueForKey:@"quantity"]];
    }else{
        [self setQuantityText: @"Not Available"];
    }
    
    if ([dataV valueForKey:@"replace_date"] != (id)[NSNull null]) {
        [self setReplace_dateText:[dataV valueForKey:@"replace_date"]];
    }else{
        [self setReplace_dateText: @"Not Available"];
    }
    
    if ([dataV valueForKey:@"serial_number"] != (id)[NSNull null] || ![[dataV valueForKey:@"serial_number"] isEqualToString:@""]) {
        [self setSerial_numberText:[dataV valueForKey:@"serial_number"]];
    }else{
        [self setSerial_numberText: @"Not Available"];
    }
    
    if ([dataV valueForKey:@"value"] != (id)[NSNull null]) {
        [self setValueText:[dataV valueForKey:@"value"]];
    }else{
        [self setValueText: @"Not Available"];
    }
    
    if ([dataV valueForKey:@"warranty_date"] != (id)[NSNull null]) {
        [self setWarranty_dateText:[dataV valueForKey:@"warranty_date"]];
    }else{
        [self setWarranty_dateText: @"Not Available"];
    }
    
    if ([dataV valueForKey:@"itemphotopath"] != (id)[NSNull null]) {
        [self setItemphotopathText:[dataV valueForKey:@"itemphotopath"]];
    }else{
        [self setItemphotopathText: @""];
    }
    
    if ([dataV valueForKey:@"current_value"] != (id)[NSNull null]) {
        [self setCurrent_valueText:[dataV valueForKey:@"current_value"]];
    }else{
        [self setCurrent_valueText:@"Not Available"];
    }
    
    if ([dataV valueForKey:@"pdf_name"] != (id)[NSNull null] && ![[dataV valueForKey:@"pdf_name"] isEqualToString:@""]) {
        [self setPdf_nameArr:[[dataV valueForKey:@"pdf_name"] componentsSeparatedByString:@","]];
    }else{
        [self setPdf_nameArr:nil];
    }
    
    
}

@end
