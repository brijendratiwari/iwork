//
//  PatTestViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 17/06/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface PatTestViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>{
    IBOutlet UILabel *productNamelbl,*productCodelbl;
    IBOutlet UIImageView *profilePic;
   // IBOutlet UILabel *currentPatDatelbl,*currentPatStatuslbl;
    //IBOutlet UILabel *newPatDatelbl,*newPatStatuslbl;
    IBOutlet UITextField *currentDatetf,*currentstatustf;
    IBOutlet UITextField *newDatetf,*newstatustf;
    
    IBOutlet UIPickerView *dataPicker;
    IBOutlet UIDatePicker *timedatePicker;
}

@property(nonatomic, retain) Item *item;

@end
