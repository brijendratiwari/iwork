//
//  ManualSearchViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 30/04/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManualSearchViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    IBOutlet UITextField *freeSerachtxt,*qrCodetxt,*manfactxt,*sitestxt,*usertxt,*locationtxt,*catagrytxt;
    IBOutlet UIPickerView *dataPicker;
    IBOutlet UIToolbar *toolbar;
}

@end
