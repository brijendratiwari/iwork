//
//  VechicleCheckViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 09/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VechicleCheckViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>{
    IBOutlet UITextField *regNumbertxt,*maketxt,*sitestxt,*usertxt,*locationtxt;
    IBOutlet UIPickerView *dataPicker;
}

@end
