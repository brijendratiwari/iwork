//
//  ComplienceCheckCell.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 22/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ComplienceCheckCell;

@protocol ComplienceCheckCellDelgate <NSObject>
@required
-(void)selectCellItem:(NSString *)type indexPath:(NSIndexPath *)indexPath;
@end

@interface ComplienceCheckCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *tittleName;
@property (strong, nonatomic) IBOutlet UILabel *noteslbl;
@property (strong, nonatomic) IBOutlet UITextView *notesTxtV;

@property (nonatomic,assign) IBOutlet id<ComplienceCheckCellDelgate> delegate;
@property (nonatomic,retain)NSIndexPath *indexPath;
@property (nonatomic)BOOL ispassed;

-(IBAction)tittleButtonClick:(id)sender;

@end
