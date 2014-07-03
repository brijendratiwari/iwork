//
//  DashboardViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 29/04/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyLauncherView;

@interface DashboardViewController : UIViewController{
    IBOutlet UILabel *accountNamelbl,*usernamelbl,*levelNamelbl;
    
    IBOutlet UIImageView *profilePic;
    IBOutlet UIButton *cancelEditingBtn;
    MyLauncherView *launcherView;
}

@end
