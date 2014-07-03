//
//  ViewDocViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 16/06/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASINetworkQueue;

@interface ViewDocViewController : UIViewController{
    IBOutlet UIButton *pdfNamebtn;
    ASINetworkQueue *networkQueue;
}

@property (nonatomic, retain)NSMutableArray *pdfListArr;
@property (nonatomic, retain)NSString *itemID;

@property (nonatomic, retain)IBOutlet UIScrollView *scroller;
@end
