//
//  AuditLocationListViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 15/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuditLocationListViewController :  UIViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *searchTable;
    IBOutlet UILabel *resultCountlbl;
    IBOutlet UIButton *editButton;
    BOOL iSEditMode;
    NSMutableArray *selectedIndexArray;
}

@property(nonatomic, retain) NSMutableArray *searchDataArr;
-(IBAction)editButtonClick:(id)sender;
@end
