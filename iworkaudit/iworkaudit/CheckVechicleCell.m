//
//  CheckVechicleCell.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 01/06/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "CheckVechicleCell.h"

@implementation CheckVechicleCell
@synthesize tittleName,notesTxtV,noteslbl;
@synthesize delegate,indexPath,ispassed;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(IBAction)tittleButtonClick:(id)sender
{
    [self.delegate selectCellItem:@"toggle" indexPath:self.indexPath];
}


- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"textViewDidBeginEditing - %ld",(long)self.indexPath.row);
    
    [[self delegate] selectCellTextView:self.indexPath];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
