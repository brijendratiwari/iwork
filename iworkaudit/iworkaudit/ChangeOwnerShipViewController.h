//
//  ChangeOwnerShipViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 07/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface ChangeOwnerShipViewController : UIViewController{
    IBOutlet UILabel *productNamelbl,*productCodelbl,*productQRlbl;
    IBOutlet UIPickerView *dataPicker;
    IBOutlet UIImageView *profilePic,*tittleimgV;
    IBOutlet UIButton *submitBtn;
    
    IBOutlet UIPickerView *edit_dataPicker;
    
    IBOutlet UITextField *sitestxt,*locationtxt,*usertxt;
    IBOutlet UILabel *siteslbl,*locationlbl,*userlbl;
    
    
}

@property(nonatomic, retain) Item *item;
@end
