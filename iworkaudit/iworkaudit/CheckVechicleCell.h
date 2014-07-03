//
//  CheckVechicleCell.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 01/06/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CheckVechicleCell;

@protocol CheckVechicleCellDelgate <NSObject>
@required
-(void)selectCellItem:(NSString *)type indexPath:(NSIndexPath *)indexPath;
-(void)selectCellTextView:(NSIndexPath *)indexPath;
@end

@interface CheckVechicleCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *tittleName;
@property (strong, nonatomic) IBOutlet UILabel *noteslbl;
@property (strong, nonatomic) IBOutlet UITextView *notesTxtV;

@property (nonatomic,assign) IBOutlet id<CheckVechicleCellDelgate> delegate;
@property (nonatomic,retain)NSIndexPath *indexPath;
@property (nonatomic)BOOL ispassed;

-(IBAction)tittleButtonClick:(id)sender;

@end
