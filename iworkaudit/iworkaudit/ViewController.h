//
//  ViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 29/04/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Security/Security.h>
#import "KeychainItemWrapper.h"
#import "WebServiceHelper.h"
#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController<UITextFieldDelegate,WebServiceHelperDelegate,CLLocationManagerDelegate>{
    IBOutlet UITextField *usernametxt,*passwordtxt,*countrytxt;
    IBOutlet UILabel *remindmelbl;
    IBOutlet UIButton *remberBtn,*needacclbl,*cleardataBtn;
    KeychainItemWrapper *keychain;
    BOOL isRemberSelcted;
    IBOutlet UIPickerView *dataPicker;
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}

@end
