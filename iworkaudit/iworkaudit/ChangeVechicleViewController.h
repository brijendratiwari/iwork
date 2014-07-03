//
//  ChangeVechicleViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 16/06/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vechicles.h"
@interface ChangeVechicleViewController : UIViewController{
    IBOutlet UILabel *productNamelbl,*productCodelbl,*productQRlbl;
    IBOutlet UIPickerView *dataPicker;
    IBOutlet UIImageView *profilePic,*tittleimgV;
    IBOutlet UIButton *submitBtn;
}

@property(nonatomic, retain) Vechicles *vechicle;

@end
