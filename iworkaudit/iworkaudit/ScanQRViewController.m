//
//  ScanQRViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 30/04/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "ScanQRViewController.h"
#import "HexColorToUIColor.h"
#import "AppData.h"
#import <AVFoundation/AVFoundation.h>
#import "WebServiceHelper.h"
#import "SVProgressHUD.h"
#import "JSON.h"
#import "ResultItems.h"
#import "Item.h"
#import "VehicleResults.h"
// pushing to View Controller
#import "iTeamDetailsViewController.h"
#import "ReportFaultViewController.h"
#import "ChangeOwnerShipViewController.h"
#import "VechicleDetailsViewController.h"
#import "AddSimilarViewController.h"
#import "ComplienceCheckViewController.h"
#import "AuditLocationListViewController.h"
#import "CheckVechilelistViewController.h"
#import "SearchResultViewController.h"

#import "ViewDocViewController.h"
#import "PatTestViewController.h"
#import "ChangeVechicleViewController.h"

@interface ScanQRViewController ()<AVCaptureMetadataOutputObjectsDelegate,WebServiceHelperDelegate>{
    AVCaptureSession *_session;
    AVCaptureDevice *_device;
    AVCaptureDeviceInput *_input;
    AVCaptureMetadataOutput *_output;
    AVCaptureVideoPreviewLayer *_prevLayer;
    UIView *_highlightView;
    AppData *appDataObj;
    NSString *codeStr;
    int count ;
    HexColorToUIColor *hexcolor;
}

@end

@implementation ScanQRViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    count = 0;
    [self createAndOpenScanner];
    
    if ([appDataObj.deshboardNavType isEqualToString:@"vehiclecheck"] || [appDataObj.deshboardNavType isEqualToString:@"changetome"]) {
        manulSerchBtn.hidden = YES;
        searchlbl.hidden=YES;
    }else{
        manulSerchBtn.hidden = NO;
        searchlbl.hidden=NO;
    }
}

-(void)createAndOpenScanner{
    //scannerView.layer.borderColor = [[hexcolor colorFromHexString:FONT_COLOR alpha:1.0] CGColor];
    //scannerView.layer.borderWidth = 1.0f;
    //scannerView.layer.cornerRadius = 8.0f;
    
    //scannerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"qr_scanBG.png"]];
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    count = 0;
    appDataObj = [AppData sharedInstance];
    hexcolor = [[HexColorToUIColor alloc] init];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickOnManualSearch:(id)sender{
    if ([appDataObj.deshboardNavType isEqualToString:@"viewvehicle"] || [appDataObj.deshboardNavType isEqualToString:@"reportvechiclefault"] || [appDataObj.deshboardNavType isEqualToString:@"vechicleownership"]) {
        UIViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"VechicleCheckViewController"];
        [[self navigationController] pushViewController:pushContoller animated:YES];
    }else{
        UIViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ManualSearchViewController"];
        [[self navigationController] pushViewController:pushContoller animated:YES];
    }
}

-(IBAction)backToPrevView:(id)sender{
    [[self navigationController] popViewControllerAnimated:YES];
}


- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    // NSLog(@"break --");
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
        
        
        if (detectionString != nil && count == 0)
        {
            //_label.text = detectionString;
           // NSLog(@"detectionString -- %@",detectionString);

            count ++;
           // NSLog(@"breaktest --");
            codeStr = @"";
            codeStr = detectionString;
           // [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"Scanning Successfully." delegate:self cancelButtonTitle:@"Rescan" otherButtonTitles:@"Submit", nil] show];
            [self performSelector:@selector(pushToNextView)];
            // [self pushToNextView];

            break;
           
        }
        else
           // _label.text = @"(none)";
            NSLog(@"none");
    }
    
    _highlightView.frame = highlightViewRect;
}

-(void)pushToNextView{
    
    NSString *netStr = [[AppData sharedInstance] checkNetworkConnectivity];
    if([netStr isEqualToString:@"NoAccess"])
    {
        [[AppData sharedInstance] callNoNetworkAlert];
    }
    else{
        
        if ([appDataObj.deshboardNavType isEqualToString:@"viewvehicle"] || [appDataObj.deshboardNavType isEqualToString:@"reportvechiclefault"] || [appDataObj.deshboardNavType isEqualToString:@"vechicleownership"])
        {
            WebServiceHelper *obj=[[WebServiceHelper alloc] init];
            [obj setDelegate:self];
            [obj setMethodResult:@""];
            [obj setMethodParameters:[[NSMutableDictionary alloc] init]];
            
            [obj setMethodName:[NSString stringWithFormat:@"vehicleqr/%@",codeStr]];
            [obj setMethodResult:@""];
            [obj setMethodType:@"POST"];
            [obj setCurrentCall:@"vehicalearch"];
            
            [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
            [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
            [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
            [obj.MethodParameters setObject:@"true" forKey:@"search"];
            
            [obj initiateConnection];
        }
        
       // else if ([appDataObj.deshboardNavType isEqualToString:@"auditloc"] || [appDataObj.deshboardNavType isEqualToString:@"searchloc"] || [appDataObj.deshboardNavType isEqualToString:@"editloc"])
        else if ([appDataObj.deshboardNavType isEqualToString:@"auditloc"] || [appDataObj.deshboardNavType isEqualToString:@"searchloc"])
        {
            WebServiceHelper *obj=[[WebServiceHelper alloc] init];
            [obj setDelegate:self];
            [obj setMethodResult:@""];
            [obj setMethodParameters:[[NSMutableDictionary alloc] init]];
            
            [obj setMethodName:[NSString stringWithFormat:@"location/%@",codeStr]];
            [obj setMethodResult:@""];
            [obj setMethodType:@"POST"];
            [obj setCurrentCall:@"location"];
            
            [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
            [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
            [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
            [obj.MethodParameters setObject:@"true" forKey:@"search"];
            
            [obj initiateConnection];

        }
        
        else if ([appDataObj.deshboardNavType isEqualToString:@"vehiclecheck"])
        {
            WebServiceHelper *obj=[[WebServiceHelper alloc] init];
            [obj setDelegate:self];
            [obj setMethodResult:@""];
            [obj setMethodParameters:[[NSMutableDictionary alloc] init]];
            
            [obj setMethodName:[NSString stringWithFormat:@"vehiclechecksqr/%@",codeStr]];
            [obj setMethodResult:@""];
            [obj setMethodType:@"POST"];
            [obj setCurrentCall:@"vehiclechecksqr"];
            
            [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
            [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
            [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
            [obj.MethodParameters setObject:@"true" forKey:@"search"];
            
            [obj initiateConnection];
            
        }
        
        // additional
        
        else if ([appDataObj.deshboardNavType isEqualToString:@"viewdoc"])
        {
            
            WebServiceHelper *obj=[[WebServiceHelper alloc] init];
            [obj setDelegate:self];
            [obj setMethodResult:@""];
            [obj setMethodParameters:[[NSMutableDictionary alloc] init]];
            
            [obj setMethodName:[NSString stringWithFormat:@"itemViewDoc/%@",codeStr]];
            [obj setMethodResult:@""];
            [obj setMethodType:@"POST"];
            [obj setCurrentCall:@"itemViewDoc"];
            
            [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
            [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
            [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
            [obj.MethodParameters setObject:@"true" forKey:@"search"];
            
            [obj initiateConnection];
        }
        
        else if ([appDataObj.deshboardNavType isEqualToString:@"pattest"])
        {
            
            WebServiceHelper *obj=[[WebServiceHelper alloc] init];
            [obj setDelegate:self];
            [obj setMethodResult:@""];
            [obj setMethodParameters:[[NSMutableDictionary alloc] init]];
            
            [obj setMethodName:[NSString stringWithFormat:@"itempat/%@",codeStr]];
            [obj setMethodResult:@""];
            [obj setMethodType:@"POST"];
            [obj setCurrentCall:@"itempat"];
            
            [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
            [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
            [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
            [obj.MethodParameters setObject:@"true" forKey:@"search"];
            
            [obj initiateConnection];
            
            
        }
        
        /*else if ([appDataObj.deshboardNavType isEqualToString:@"reportvechiclefault"])
        {
            
            WebServiceHelper *obj=[[WebServiceHelper alloc] init];
            [obj setDelegate:self];
            [obj setMethodResult:@""];
            [obj setMethodParameters:[[NSMutableDictionary alloc] init]];
            
            [obj setMethodName:[NSString stringWithFormat:@"itempat/%@",codeStr]];
            [obj setMethodResult:@""];
            [obj setMethodType:@"POST"];
            [obj setCurrentCall:@"currentcall"];
            
            [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
            [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
            [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
            [obj.MethodParameters setObject:@"true" forKey:@"search"];
            
            [obj initiateConnection];
            
            
        }*/
        
        else
        {
            WebServiceHelper *obj=[[WebServiceHelper alloc] init];
            [obj setDelegate:self];
            [obj setMethodResult:@""];
            [obj setMethodParameters:[[NSMutableDictionary alloc] init]];
            
            [obj setMethodName:[NSString stringWithFormat:@"item/%@",codeStr]];
            [obj setMethodResult:@""];
            [obj setMethodType:@"POST"];
            [obj setCurrentCall:@"itemsearch"];
            
            [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
            [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
            [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
            [obj.MethodParameters setObject:@"true" forKey:@"search"];
            
            [obj initiateConnection];
        }
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [SVProgressHUD dismiss];
        [SVProgressHUD show];
    }
}

-(void)changeToMe:(NSString *)itemID{

    WebServiceHelper *obj=[[WebServiceHelper alloc] init];
    [obj setDelegate:self];
    [obj setMethodResult:@""];
    [obj setMethodParameters:[[NSMutableDictionary alloc] init]];
    
    [obj setMethodName:[NSString stringWithFormat:@"itemownership/%@",itemID]];
    [obj setMethodResult:@""];
    [obj setMethodType:@"POST"];
    [obj setCurrentCall:@"changeToMe"];
    
    [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
    [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
    [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
    [obj.MethodParameters setObject:@"submit" forKey:@"mode"];
    [obj.MethodParameters setObject:appDataObj.userID forKey:@"user_id"];

    [obj initiateConnection];
    
   // [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [SVProgressHUD dismiss];
    [SVProgressHUD show];
    
}


#pragma mark -
#pragma mark WebServiceHelper delegate method
-(void)WebServiceHelper:(WebServiceHelper *)editor didFinishWithResult:(BOOL)result
{
    [SVProgressHUD dismiss];
    count = 0;
	if (result)
	{
        if ([[editor currentCall] isEqualToString:@"itemsearch"])
        {
            NSLog(@"result -- %@",[[editor ReturnStr] JSONValue]);
            NSMutableDictionary *resultDic = [[editor ReturnStr] JSONValue];
            if (resultDic.count == 0) {
                 [[[UIAlertView alloc] initWithTitle:@"Error !" message:@"No result found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                [[self navigationController] popViewControllerAnimated:YES];
                return ;
            }
            
            if ([[resultDic objectForKey:@"arrItem"] count] != 0) {
               
                Item *item = [[Item alloc] init];
                [item setItemData:[resultDic objectForKey:@"arrItem"]];
                if ([appDataObj.deshboardNavType isEqualToString:@"changetome"]) {
                   // [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                    [self changeToMe:[item itemidText]];
                }
                [self scanPushToNextView:item];
                
            }else{
                [[[UIAlertView alloc] initWithTitle:@"Error !" message:@"No result found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            }
        }
        else if ([[editor currentCall] isEqualToString:@"vehicalearch"])
        {
            NSLog(@"result -- %@",[[editor ReturnStr] JSONValue]);
            NSMutableDictionary *resultDic = [[editor ReturnStr] JSONValue];
            
                if ([[[[editor ReturnStr] JSONValue] objectForKey:@"success"] isEqualToString:@"NO"]) {
                    [[[UIAlertView alloc] initWithTitle:@"Error !" message:@"No vehicle found with that QR Code" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                    [[self navigationController] popViewControllerAnimated:YES];
                    return ;
                }
            
            if ([[resultDic objectForKey:@"arrVehicle"] count] != 0) {
                Vechicles *vechicle = [[Vechicles alloc] init];
                [vechicle setVechicleData:[resultDic objectForKey:@"arrVehicle"]];
                [self scanPushToNextView:vechicle];

            }else{
                [[[UIAlertView alloc] initWithTitle:@"Error !" message:@"No vehicle found with that QR Code" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            }
        }else if ([[editor currentCall] isEqualToString:@"location"])
        {
            NSLog(@"result -- %@",[[editor ReturnStr] JSONValue]);
            NSMutableDictionary *resultDic = [[editor ReturnStr] JSONValue];
            
            if (resultDic.count == 0) {
                [[[UIAlertView alloc] initWithTitle:@"Error !" message:@"No result found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                [[self navigationController] popViewControllerAnimated:YES];
                return ;
            }
            
           NSLog(@"test -- %@",[[resultDic objectForKey:@"arrLocation"] objectForKey:@"arrItems"]);
            
            NSString *itemCountStr = [[resultDic objectForKey:@"arrLocation"] objectForKey:@"arrItems"];
            
            if ([[[resultDic objectForKey:@"arrLocation"] objectForKey:@"arrItems"] count] != 0) {
                    [[ResultItems sharedInstance] setAllItemsInArray:[[resultDic objectForKey:@"arrLocation"] objectForKey:@"arrItems"]];
                    [self scanPushToNextView:nil];
            
                
            }else{
                [[[UIAlertView alloc] initWithTitle:@"Error !" message:@"No result found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                [[self navigationController] popViewControllerAnimated:YES];
                return ;
            }
        }
        else if ([[editor currentCall] isEqualToString:@"vehiclechecksqr"])
        {
            
            NSLog(@"result -- %@",[[editor ReturnStr] JSONValue]);
            NSMutableDictionary *resultDic = [[editor ReturnStr] JSONValue];
            
            NSMutableArray *resDic = [[[editor ReturnStr] JSONValue] objectForKey:@"checks"];
            NSMutableArray *resultArr = [NSMutableArray array];
            
            if ([[[[editor ReturnStr] JSONValue] objectForKey:@"success"] isEqualToString:@"NO"]) {
                [[[UIAlertView alloc] initWithTitle:@"Error !" message:@"No checks are associated with this vehicle" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                [[self navigationController] popViewControllerAnimated:YES];
                return ;
            }
            
            for (NSString *key in resDic) {
                NSLog(@"key == %@",key);
                NSLog(@"value == %@",[resDic valueForKey:key]);
                [resultArr addObject:[resDic valueForKey:key]];
                //[[VehicleResults sharedInstance] setAllVehicleInArray:[resultDic objectForKey:@"arrResults"]];
            }
            
            CheckVechilelistViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"CheckVechilelistViewController"];
            pushContoller.checkListArr = [[NSMutableArray alloc] init];
            pushContoller.checkListArr = resultArr;
            pushContoller.vechicleID = [[[editor ReturnStr] JSONValue] objectForKey:@"vehicle_id"];
            [[self navigationController] pushViewController:pushContoller animated:YES];
            
        }
        
        // additional
        else if ([[editor currentCall] isEqualToString:@"itemViewDoc"])
        {
            
            NSLog(@"result -- %@",[[editor ReturnStr] JSONValue]);
            
             NSMutableArray *resDic = [[[editor ReturnStr] JSONValue] objectForKey:@"arrItem"];
            
            if (resDic.count > 0) {
                ViewDocViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewDocViewController"];
                
                if ([resDic valueForKey:@"pdf_name"] != (id)[NSNull null] && ![[resDic valueForKey:@"pdf_name"] isEqualToString:@""]) {
                    pushContoller.pdfListArr = [[NSMutableArray alloc] init];
                    pushContoller.pdfListArr = (NSMutableArray *)[[resDic valueForKey:@"pdf_name"] componentsSeparatedByString:@","];
                    pushContoller.itemID = [resDic valueForKey:@"itemid"];
                    [[self navigationController] pushViewController:pushContoller animated:YES];
                }else{
                    [[[UIAlertView alloc] initWithTitle:@"Error !" message:@"No result found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                    [[self navigationController] popViewControllerAnimated:YES];
                    return ;
                }
                
               
            }else{
                [[[UIAlertView alloc] initWithTitle:@"Error !" message:@"No result found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                [[self navigationController] popViewControllerAnimated:YES];
                return ;
            }
        }
        
        else if ([[editor currentCall] isEqualToString:@"itempat"])
        {
            
            NSLog(@"result -- %@",[[editor ReturnStr] JSONValue]);
            NSMutableDictionary *resultDic = [[editor ReturnStr] JSONValue];
            
            if ([[resultDic objectForKey:@"objItem"] count] > 0 || [resultDic objectForKey:@"objItem"] != (id)[NSNull null]) {
                
                Item *item = [[Item alloc] init];
                [item setItemData:[resultDic objectForKey:@"objItem"]];
                
                PatTestViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"PatTestViewController"];
                pushContoller.item = item;
                [[self navigationController] pushViewController:pushContoller animated:YES];
            }else{
                [[[UIAlertView alloc] initWithTitle:@"Error !" message:@"No result found." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                [[self navigationController] popViewControllerAnimated:YES];
                return ;
            }
            
          }
        
        else if ([[editor currentCall] isEqualToString:@"currentcall"])
        {
            
            NSLog(@"result -- %@",[[editor ReturnStr] JSONValue]);
            NSMutableDictionary *resultDic = [[editor ReturnStr] JSONValue];
             [[[UIAlertView alloc] initWithTitle:@"Error !" message:@"No result found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            [[self navigationController] popViewControllerAnimated:YES];
            return ;
        }
        
        if ([[editor currentCall] isEqualToString:@"changeToMe"])
        {
            NSLog(@"result -- %@",[[editor ReturnStr] JSONValue]);
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success !" message:@"Ownership has been changed.\n Change another item to me?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil] ;
            alert.tag = 1000;
            [alert show];
            
           // [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            //[[self navigationController] popViewControllerAnimated:YES];
            //return ;
        }
    }
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    count = 0;
    if (alertView.cancelButtonIndex != buttonIndex) {
        
        if (alertView.tag != 1000) {
            [self pushToNextView];
        }
    }else{
        if (alertView.tag == 1000) {
            [[self navigationController] popViewControllerAnimated:YES];
        }
    }
}

-(void)scanPushToNextView:(id)items
{
    if ([appDataObj.deshboardNavType isEqualToString:@"viewitem"]) {
        
        iTeamDetailsViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"iTeamDetailsViewController"];
        pushContoller.item = items;
        [[self navigationController] pushViewController:pushContoller animated:YES];
        
    }
    else if ([appDataObj.deshboardNavType isEqualToString:@"addsimilar"]){
        
        AddSimilarViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"AddSimilarViewController"];
        pushContoller.item = items;
        [[self navigationController] pushViewController:pushContoller animated:YES];
        
    }else if ([appDataObj.deshboardNavType isEqualToString:@"compliancecheck"]){
        
        ComplienceCheckViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ComplienceCheckViewController"];
        pushContoller.item = items;
        [[self navigationController] pushViewController:pushContoller animated:YES];
    }
    else if ([appDataObj.deshboardNavType isEqualToString:@"ownership"] || [appDataObj.deshboardNavType isEqualToString:@"editloc"]){
        
        ChangeOwnerShipViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangeOwnerShipViewController"];
        pushContoller.item = items;
        [[self navigationController] pushViewController:pushContoller animated:YES];
    }
    
    else if ([appDataObj.deshboardNavType isEqualToString:@"reportfault"]){
        
        ReportFaultViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ReportFaultViewController"];
        pushContoller.item = items;
        [[self navigationController] pushViewController:pushContoller animated:YES];
    }
    else if ([appDataObj.deshboardNavType isEqualToString:@"viewvehicle"])
    {
        VechicleDetailsViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"VechicleDetailsViewController"];
        pushContoller.vechicle = items;
        [[self navigationController] pushViewController:pushContoller animated:YES];
    }
    else if ([appDataObj.deshboardNavType isEqualToString:@"auditloc"])
    {
        AuditLocationListViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"AuditLocationListViewController"];
        //pushContoller.item = items;
        [[self navigationController] pushViewController:pushContoller animated:YES];
    }
    //else if ([appDataObj.deshboardNavType isEqualToString:@"editloc"] || [appDataObj.deshboardNavType isEqualToString:@"searchloc"])
     else if ([appDataObj.deshboardNavType isEqualToString:@"searchloc"]){
         
        SearchResultViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResultViewController"];
        [[self navigationController] pushViewController:pushContoller animated:YES];
    }
    
     else if ([appDataObj.deshboardNavType isEqualToString:@"vechicleownership"])
     {
         ChangeVechicleViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangeVechicleViewController"];
         pushContoller.vechicle = items;
         [[self navigationController] pushViewController:pushContoller animated:YES];
     }
    
     else if ([appDataObj.deshboardNavType isEqualToString:@"reportvechiclefault"]){
         
         ReportFaultViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ReportFaultViewController"];
         pushContoller.vechicle = items;
         [[self navigationController] pushViewController:pushContoller animated:YES];
     }
    
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
