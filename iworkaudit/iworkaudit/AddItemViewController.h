//
//  AddItemViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 07/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddItemViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UINavigationControllerDelegate>{
    
    IBOutlet UITextField *manufacTxtF,*selmanufacTextF,*modelTxtF,*serialTxtF,*barcodeTxtF,*qrscanTxtF,*selectcatgryTxtF,*statusTxtF,*serialNumScanTxtF;
    IBOutlet UIButton *patButton,*addSimilerBtn;
    
    IBOutlet UILabel *noteslbl,*patreqlbl,*addSimilarlbl;
 
    IBOutlet UITextView *notesTxtV;
    
    IBOutlet UITextField *valueTxtF,*takePhotoTextF,*selSiteTxtF,*selectUserTxtF,*selectLocTxtF,*purchaseDateTxtF,*warrntyexpTxtF;
    
    IBOutlet UIPickerView *dataPicker;
    IBOutlet UIDatePicker *timedatePicker;
    
    IBOutlet UIImageView *itemImage;
    
}
- (IBAction)checkPatRequired:(id)sender;
- (IBAction)checkAnotherSimilarItem:(id)sender;
- (IBAction)itemAddSaveBtnClick:(id)sender;
-(IBAction)showcamera:(id)sender;

@property (nonatomic, strong) IBOutlet UIScrollView *scroller;

@end
