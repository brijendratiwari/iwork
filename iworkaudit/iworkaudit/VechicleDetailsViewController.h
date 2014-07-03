//
//  VechicleDetailsViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 09/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vechicles.h"

@interface VechicleDetailsViewController : UIViewController{
    IBOutlet UILabel *productNamelbl;
  //  IBOutlet UILabel *barcodelbl,*reglbl,*enginlbl,*valuelbl,*userlbl,*sitelbl,*loclbl,*serviceDuelbl,*motDuelbl,*noteslbl,*purchasedlbl,*warrentylbl;
    IBOutlet UILabel *motDuelbl,*reglbl;
    IBOutlet UITextField *barcodeTxtF,*regTxtF,*enginTxtF,*valueTxtF,*userTxtF,*siteTxtF,*locTxtF,*serviceDueTxtF,*motDueTxtF,*purchasedTxtF,*warrentyTxtF;
    
    IBOutlet UITextView *notesTxtV;
}

@property(nonatomic, retain) Vechicles *vechicle;
@property (nonatomic, strong) IBOutlet UIScrollView *scroller;
@end
