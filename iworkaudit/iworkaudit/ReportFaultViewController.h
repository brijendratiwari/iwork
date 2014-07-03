//
//  ReportFaultViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 06/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Item.h"
#import "Vechicles.h"

@interface ReportFaultViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>{
    IBOutlet UILabel *productNamelbl,*productCodelbl,*productQRlbl;
    IBOutlet UILabel *lineslbl,*ticketDlbl,*selitemStatslbl,*prioritylbl;
    IBOutlet UITextField *selitemStatsTxtF,*subjectTxtF,*priorityTxtF;
    IBOutlet UIImageView *profilePic;
    IBOutlet UITextField *msgTxtV;
    IBOutlet UIPickerView *dataPicker;
    IBOutlet UIScrollView *scroller;
}

@property(nonatomic, retain) Item *item;
@property(nonatomic, retain) Vechicles *vechicle;
@end
