//
//  AddSimilarViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 07/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface AddSimilarViewController : UIViewController<UIImagePickerControllerDelegate>{
    IBOutlet UILabel *productNamelbl,*productCodelbl,*productQRlbl;
    IBOutlet UITextField *serialNumberTxtF,*scanSericalTxtF,*scanQRTxtF,*barcodeTxtF,*siteTxtF,*userTxtF,*locationTxtF;
    
   // IBOutlet UILabel *serialNumberlbl,*scanSericallbl,*scanQRlbl,*barcodelbl,*sitelbl,*userlbl,*locationlbl;
    
    IBOutlet UILabel *addAnotherlbl;
    IBOutlet UIPickerView *dataPicker;
    IBOutlet UIImageView *profilePic;
    IBOutlet UIButton *addSimilerBtn;
}

@property (nonatomic, strong) IBOutlet UIScrollView *scroller;
@property(nonatomic, retain) Item *item;
@end
