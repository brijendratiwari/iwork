//
//  CheckVechilelistViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 01/06/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckVechilelistViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UILabel *productNamelbl,*productCodelbl;
    IBOutlet UILabel *windowuplbl,*checktittlelbl;
    IBOutlet UILabel *updatelbl,*OSlbl,*mouselbl;
    IBOutlet UIImageView *profilePic;
    IBOutlet UITableView *Itemstable;
}

@property(nonatomic, retain)NSMutableArray *checkListArr;
@property(nonatomic, retain)NSString *vechicleID;

@end
