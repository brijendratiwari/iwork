//
//  ComplienceCheckViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 06/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface ComplienceCheckViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UILabel *productNamelbl,*productCodelbl;
    IBOutlet UILabel *windowuplbl,*checktittlelbl;
    IBOutlet UILabel *updatelbl,*OSlbl,*mouselbl;
    IBOutlet UIImageView *profilePic;
    IBOutlet UITableView *Itemstable;
}

@property(nonatomic, retain) Item *item;

@end
