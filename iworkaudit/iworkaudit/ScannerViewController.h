//
//  ScannerViewController.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 08/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScannerViewController;
@protocol ScannerViewControllerDelegate <NSObject>

-(void)selectQRCodeAndSerialNumber:(ScannerViewController *)controller;

@end

@interface ScannerViewController : UIViewController{
    IBOutlet UIView *scannerView;
}

@property (nonatomic,assign) id<ScannerViewControllerDelegate>delegate;

-(id)selectedQRCode;
-(id)selectedSerialNumber;

@end
