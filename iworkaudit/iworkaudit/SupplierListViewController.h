//
//  SupplierListViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 07/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupplierListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *searchTable;
    IBOutlet UILabel *resultCountlbl;
}

@end
