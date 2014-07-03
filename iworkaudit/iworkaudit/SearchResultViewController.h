//
//  SearchResultViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 02/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *searchTable;
    IBOutlet UILabel *resultCountlbl;
}

@property(nonatomic, retain) NSMutableArray *searchDataArr;
@end
