//
//  ScannerViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 08/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "ScannerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "HexColorToUIColor.h"
#import "AppData.h"

@interface ScannerViewController ()<AVCaptureMetadataOutputObjectsDelegate>{
    AVCaptureSession *_session;
    AVCaptureDevice *_device;
    AVCaptureDeviceInput *_input;
    AVCaptureMetadataOutput *_output;
    AVCaptureVideoPreviewLayer *_prevLayer;
    UIView *_highlightView;
    NSString *codeString;
    int count;
    NSString *codeStr;
}

@end

@implementation ScannerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    count = 0;
    codeStr = @"";
    HexColorToUIColor *hexcolor = [[HexColorToUIColor alloc] init];
    
    scannerView.layer.borderColor = [[hexcolor colorFromHexString:FONT_COLOR alpha:1.0] CGColor];
    scannerView.layer.borderWidth = 1.0f;
    scannerView.layer.cornerRadius = 8.0f;
    
    _highlightView = [[UIView alloc] init];
    _highlightView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _highlightView.layer.borderColor = [UIColor greenColor].CGColor;
    _highlightView.layer.borderWidth = 3;
    [scannerView addSubview:_highlightView];
    
    _session = [[AVCaptureSession alloc] init];
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (_input) {
        [_session addInput:_input];
    } else {
        NSLog(@"Error: %@", error);
    }
    
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [_session addOutput:_output];
    
    _output.metadataObjectTypes = [_output availableMetadataObjectTypes];
    
    _prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _prevLayer.frame = scannerView.bounds;
    _prevLayer.cornerRadius = 8.0f;
    //_prevLayer.frame = CGRectMake(50, 50, 100, 100);
    _prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [scannerView.layer addSublayer:_prevLayer];
    
    [_session startRunning];
    
    [scannerView bringSubviewToFront:_highlightView];
    
}

-(id)selectedQRCode{
    return codeString;
}

-(id)selectedSerialNumber{
    return codeString;
}


- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    CGRect highlightViewRect = CGRectZero;
    AVMetadataMachineReadableCodeObject *barCodeObject;
    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
    
    for (AVMetadataObject *metadata in metadataObjects) {
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type])
            {
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[_prevLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                highlightViewRect = barCodeObject.bounds;
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                break;
            }
        }
        
        if (count != 0) {
            return;
        }
        
        if (detectionString != nil && count == 0)
        {
            //_label.text = detectionString;
            // NSLog(@"detectionString -- %@",detectionString);
            
            count ++;
            // NSLog(@"breaktest --");
            codeString = @"";
            codeString = detectionString;
          //  [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"Scanning Successfully." delegate:self cancelButtonTitle:@"Rescan" otherButtonTitles:@"Submit", nil] show];
            
            [[self delegate] selectQRCodeAndSerialNumber:self];
            [self dismissViewControllerAnimated:YES completion:nil];
            
            break;
            
        }
        else
            // _label.text = @"(none)";
            NSLog(@"none");
    }
    
    _highlightView.frame = highlightViewRect;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    count = 0;
    if (alertView.cancelButtonIndex != buttonIndex) {
        [[self delegate] selectQRCodeAndSerialNumber:self];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


-(IBAction)backToPrevView:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
