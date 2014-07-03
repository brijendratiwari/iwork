//
//  SupplierDetailsViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 09/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Supplier.h"
#import <MessageUI/MessageUI.h>

@interface SupplierDetailsViewController : UIViewController <UITextFieldDelegate,MFMailComposeViewControllerDelegate>
{
    
    IBOutlet UILabel *productNamelbl;
    
   // IBOutlet UILabel *address1lbl,*address2lbl,*address3lbl,*towncitylbl,*contrystatelbl,*postcodelbl,*websitelbl,*telephonelbl,*contanctlbl,*emaillbl,*email2lbl;
    
    IBOutlet UITextField *address1TxtF,*address2TxtF,*address3TxtF,*towncityTxtF,*contrystateTxtF,*postcodeTxtF,*websiteTxtF,*telephoneTxtF,*contanctTxtF,*emailTxtF,*email2TxtF;
    
    
}

@property(nonatomic, retain) Supplier *supplier;
@property (nonatomic, strong) IBOutlet UIScrollView *scroller;
@property (nonatomic, strong) IBOutlet NSString *controllerRoot;

@end
