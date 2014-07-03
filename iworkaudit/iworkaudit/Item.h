//
//  Item.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 05/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic, strong) NSString *barcodeText;
@property (nonatomic, strong) NSString *categoryidText;
@property (nonatomic, strong) NSString *categorynameText;
@property (nonatomic, strong) NSString *itemidText;
@property (nonatomic, strong) NSString *itemphotoidText;
@property (nonatomic, strong) NSString *itemphototitleText;
@property (nonatomic, strong) NSString *locationidText;
@property (nonatomic, strong) NSString *locationnameText;
@property (nonatomic, strong) NSString *manufacturerText;
@property (nonatomic, strong) NSString *modelText;
@property (nonatomic, strong) NSString *siteidText;
@property (nonatomic, strong) NSString *sitenameText;
@property (nonatomic, strong) NSString *statusnameText;
@property (nonatomic, strong) NSString *userfirstnameText;
@property (nonatomic, strong) NSString *useridText;
@property (nonatomic, strong) NSString *userlastnameText;
@property (nonatomic, strong) NSString *usernicknameText;
@property (nonatomic, strong) NSString *statusIDText;
@property (nonatomic, strong) NSString *notesText;
@property (nonatomic, strong) NSString *supplierText;
@property (nonatomic, strong) NSString *suppliers_titleText;

@property (nonatomic, strong) NSString *location_nowText;
@property (nonatomic, strong) NSString *location_sinceText;
@property (nonatomic, strong) NSString *owner_sinceText;
@property (nonatomic, strong) NSString *owner_nowText;
@property (nonatomic, strong) NSString *pattest_dateText;
@property (nonatomic, strong) NSString *pattest_statusText;
@property (nonatomic, strong) NSString *purchase_dateText;
@property (nonatomic, strong) NSString *quantityText;
@property (nonatomic, strong) NSString *replace_dateText;
@property (nonatomic, strong) NSString *serial_numberText;
@property (nonatomic, strong) NSString *valueText;
@property (nonatomic, strong) NSString *warranty_dateText;
@property (nonatomic, strong) NSString *itemphotopathText;
@property (nonatomic, strong) NSString *current_valueText;
@property (nonatomic, strong) NSArray *pdf_nameArr;



-(void)setItemData:(NSMutableArray *)dataV;

@end
