//
//  VechileListViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 09/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VechileListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *searchTable;
    IBOutlet UILabel *resultCountlbl;
}

@end
