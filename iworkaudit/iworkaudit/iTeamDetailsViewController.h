//
//  iTeamDetailsViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 02/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
@class ASINetworkQueue;

@interface iTeamDetailsViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>{
    
    ASINetworkQueue *networkQueue;
    
    IBOutlet UILabel *productNamelbl,*productCodelbl;
    IBOutlet UILabel *itemOverviewlbl,*itemNoteslbl;
    IBOutlet UITextView *notestTxtV;
    IBOutlet UITextField *qrCodetf,*statustf,*needsometf,*catgrytf,*serialnumtf,*purcahsevaltf;
    IBOutlet UITextField *currentvaltf,*purchasedtf,*warrentyextf,*replacetf,*patdatetf;
    IBOutlet UITextField *patstatustf,*presntownertf,*presnloctf,*sitetf,*suppliertf;
    
   // IBOutlet UILabel *qrCodelbl,*statuslbl,*needsomelbl,*catgrylbl,*serialnumlbl,*purcahsevallbl;
   // IBOutlet UILabel *currentvallbl,*purchasedlbl,*warrentyexlbl,*replacelbl,*patdatelbl;
    //IBOutlet UILabel *patstatuslbl,*presntownerlbl,*presnloclbl,*sitelbl,*suppliertflbl;
    
    IBOutlet UILabel *editlbl;
    IBOutlet UIImageView *profilePic;
    IBOutlet UIButton *editButton;
    
    IBOutlet UIPickerView *dataPicker;
    IBOutlet UIDatePicker *timedatePicker;
}

@property(nonatomic, retain) Item *item;
@property (nonatomic, strong) IBOutlet UIScrollView *scroller;
@end
