//
//  AddSimilarViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 07/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "AddSimilarViewController.h"
#import "AppData.h"
#import "WebServiceHelper.h"
#import "SVProgressHUD.h"
#import "JSON.h"
#import "SitesClass.h"
#import "LocationClass.h"
#import "UsersClass.h"
#import "ScannerViewController.h"
#import "HexColorToUIColor.h"
#import "Base64.h"
#import "UIImageView+WebCache.h"


@interface AddSimilarViewController ()<WebServiceHelperDelegate,ScannerViewControllerDelegate>{
    AppData *appDataObj;
    NSMutableArray *pickerArray,*pickerIDArray;
    LocationClass *locClsObj;
    UsersClass *usersClsObj;
    SitesClass *sitesClsObj;
    NSString *strPicEncoded;
    UITextField *txtTypefld;
    BOOL isAddSimilar;
    NSString *selSiteID,*sellocID,*seluserID;
}

@end

@implementation AddSimilarViewController

@synthesize scroller = _scroller;
@synthesize item;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLayoutSubviews
{
    [self.scroller setContentSize:CGSizeMake(320, (IS_IPAD ? 700:362))];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    isAddSimilar = NO;
    
    HexColorToUIColor *hexColor = [[HexColorToUIColor alloc] init];
    
    appDataObj = [AppData sharedInstance];
    usersClsObj = [UsersClass sharedInstance];
    locClsObj = [LocationClass sharedInstance];
    sitesClsObj = [SitesClass sharedInstance];
    
    for (UIView *view in self.scroller.subviews) {
        /*if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            [label setTextColor:[hexColor colorFromHexString:@"#555555" alpha:1.0]];
            [label setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];
        }*/
    }
    
    
  /*  [productNamelbl setTextColor:[hexColor colorFromHexString:@"#555555" alpha:1.0]];
    [productCodelbl setTextColor:[hexColor colorFromHexString:@"#8a8989" alpha:1.0]];
    [productQRlbl setTextColor:[hexColor colorFromHexString:@"#8a8989" alpha:1.0]];
    
    [productNamelbl setFont:[UIFont fontWithName:CORBEL_FONT_BOLD size:13.0f]];
    [productCodelbl setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];
    [productQRlbl setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];*/
    
    profilePic.layer.borderColor = [[hexColor colorFromHexString:FONT_COLOR alpha:1.0] CGColor];
    profilePic.layer.borderWidth = 1.0f;
    
    //[serialNumberTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    serialNumberTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Manual Enter Serial Number" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [serialNumberTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    //[scanSericalTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    scanSericalTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Scan Serial Number" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [scanSericalTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    //[barcodeTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    barcodeTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Manual Enter QR Code" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [barcodeTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    //[scanQRTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    scanQRTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Scan QR Code" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [scanQRTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];

    //[siteTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    siteTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Site" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [siteTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    //[userTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    userTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select User" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [userTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    //[locationTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    locationTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Location" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [locationTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    //[addAnotherlbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [addAnotherlbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    productNamelbl.text = [NSString stringWithFormat:@"%@ %@",[item manufacturerText],[item modelText]] ;
    productCodelbl.text = [item categorynameText];
    productQRlbl.text = [item barcodeText];
    siteTxtF.text = [item sitenameText];
    locationTxtF.text = [item locationnameText];
    userTxtF.text = [NSString stringWithFormat:@"%@ %@",[item userfirstnameText],[item userlastnameText]];
   
    
    AppData *appData=[AppData sharedInstance];
    [appData setLoaderOnImageView:profilePic];
    if ([[item itemphotopathText] length] != 0) {
//        profilePic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",appDataObj.apiURL_IMAGE,[item itemphotopathText]]]]];

        [profilePic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",appDataObj.apiURL_IMAGE,[item itemphotopathText]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            [appData removeLoader];
        }];
        
        UIImage *rotateImg = [appDataObj fixrotation:profilePic.image];
        
        NSData *imageData = UIImageJPEGRepresentation(rotateImg, 0.1);
        strPicEncoded = [Base64 encode:imageData];
    }
   
    if ([[item siteidText] length] > 0) {
        selSiteID = [item siteidText];
    }
    
    if ([[item locationidText] length] > 0) {
        sellocID = [item locationidText];
    }
    
    if ([[item useridText] length] > 0) {
        seluserID = [item useridText];
    }
    
    siteTxtF.inputView = dataPicker;
    userTxtF.inputView = dataPicker;
    locationTxtF.inputView = dataPicker;
    
    dataPicker.hidden = YES;
    
}

-(IBAction)backToPrevView:(id)sender{
    [[self navigationController] popViewControllerAnimated:YES];
}

-(IBAction)backToDeshboardView:(id)sender{
    NSArray *array = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
}

-(IBAction)addSimilarSaveBtnClick:(id)sender{
    //[[self navigationController] popViewControllerAnimated:YES];
    
    // for validation
    NSString *errormsg = @"";
    
    if (barcodeTxtF.text.length == 0) {
        errormsg = [errormsg stringByAppendingString:@"Please enter qrcode.\n"];
    }
    
    if (seluserID.length == 0) {
        if (selSiteID.length == 0) {
            if (sellocID.length == 0) {
              //  errormsg = [errormsg stringByAppendingString:@"Please select atleast one of the locations, sites and users."];
            }
        }
    }
    
    if (![errormsg isEqualToString:@""]) {
        UIAlertView *erralert = [[UIAlertView alloc] initWithTitle:@"Login Error" message:errormsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [erralert show];
        return ;
    }
    
    NSString *serialnum = @"";
    
    if (serialNumberTxtF.text.length != 0) {
        serialnum = serialNumberTxtF.text;
    }
   
    if (seluserID.length == 0) {
        seluserID = @"-1";
    }
    if (selSiteID.length == 0) {
        selSiteID = @"-1";
    }
    if (sellocID.length == 0) {
        sellocID = @"-1";
    }
    
    NSString *photoRepresnt = @"true";
    if (strPicEncoded.length == 0) {
        photoRepresnt = @"false";
        strPicEncoded = @"";
    }
    
    NSString *netStr = [[AppData sharedInstance] checkNetworkConnectivity];
    if([netStr isEqualToString:@"NoAccess"])
    {
        [[AppData sharedInstance] callNoNetworkAlert];
    }
    else{
        WebServiceHelper *obj=[[WebServiceHelper alloc] init];
        [obj setDelegate:self];
        [obj setMethodResult:@""];
        [obj setMethodParameters:[[NSMutableDictionary alloc] init]];
        
        [obj setMethodName:[NSString stringWithFormat:@"itemcopy/%@",[item itemidText]]];
        [obj setMethodResult:@""];
        [obj setMethodType:@"POST"];
        [obj setCurrentCall:@"itemcopy"];
        
        [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
        [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
        [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
        [obj.MethodParameters setObject:@"submit" forKey:@"mode"];
        [obj.MethodParameters setObject:serialnum forKey:@"item_serial_number"];
        [obj.MethodParameters setObject:barcodeTxtF.text forKey:@"item_barcode"];
        [obj.MethodParameters setObject:strPicEncoded forKey:@"item_image_data"];
        [obj.MethodParameters setObject:photoRepresnt forKey:@"photo_present"];
        [obj.MethodParameters setObject:seluserID forKey:@"user_id"];
        [obj.MethodParameters setObject:sellocID forKey:@"location_id"];
        [obj.MethodParameters setObject:selSiteID forKey:@"site_id"];
        
        [obj initiateConnection];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [SVProgressHUD dismiss];
        [SVProgressHUD show];
    }
    
}

- (IBAction)checkAddAnother:(id)sender {
    if (addSimilerBtn.selected) {
        isAddSimilar = NO;
    }else{
        isAddSimilar = YES;
    }
    addSimilerBtn.selected=!addSimilerBtn.selected;
    
}

#pragma mark - Text field delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    pickerArray = [NSMutableArray array];
    pickerIDArray = [NSMutableArray array];
   
    if ([textField isEqual:userTxtF]) {
        if (usersClsObj.getUsersName) {
            txtTypefld = userTxtF;
            pickerArray = usersClsObj.getUsersName;
            pickerIDArray = usersClsObj.getUsersID;
            dataPicker.hidden = NO;
            [dataPicker reloadAllComponents];
            [dataPicker selectRow:0 inComponent:0 animated:YES];
        }
    }
    if ([textField isEqual:locationTxtF]) {
        if (locClsObj.getLocationName) {
            txtTypefld = locationTxtF;
            pickerArray = locClsObj.getLocationName;
            pickerIDArray = locClsObj.getLocationID;
            dataPicker.hidden = NO;
            [dataPicker reloadAllComponents];
            [dataPicker selectRow:0 inComponent:0 animated:YES];
        }
    }
    
    if ([textField isEqual:siteTxtF]) {
        if (sitesClsObj.getSitesName) {
            txtTypefld = siteTxtF;
            pickerArray = sitesClsObj.getSitesName;
            pickerIDArray = sitesClsObj.getSitesID;
            dataPicker.hidden = NO;
            [dataPicker reloadAllComponents];
            [dataPicker selectRow:0 inComponent:0 animated:YES];
        }
    }
    
    if ([textField isEqual:scanQRTxtF]) {
        txtTypefld = scanQRTxtF;
        ScannerViewController *scannerContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ScannerViewController"];
         scannerContoller.delegate = self;
        [self presentViewController:scannerContoller animated:YES completion:nil];
    }
    if ([textField isEqual:scanSericalTxtF]) {
        txtTypefld = scanSericalTxtF;
        ScannerViewController *scannerContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ScannerViewController"];
        scannerContoller.delegate = self;
        [self presentViewController:scannerContoller animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}

#pragma mark- Picker View Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if ([txtTypefld isEqual:userTxtF]) {
        [userTxtF setText:[pickerArray objectAtIndex:row]];
        seluserID = [pickerIDArray objectAtIndex:row];
    }
    if ([txtTypefld isEqual:locationTxtF]) {
        [locationTxtF setText:[pickerArray objectAtIndex:row]];
        sellocID = [pickerIDArray objectAtIndex:row];
    }
    if ([txtTypefld isEqual:siteTxtF]) {
        [siteTxtF setText:[pickerArray objectAtIndex:row]];
        selSiteID = [pickerIDArray objectAtIndex:row];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}

#pragma mark -
#pragma mark Scanner View Controller delegate method
-(void)selectQRCodeAndSerialNumber:(ScannerViewController *)controller{
    if ([txtTypefld isEqual:scanSericalTxtF]) {
        // serialNumScanTxtF.text = (NSString *)[controller selectedSerialNumber];
        serialNumberTxtF.text = (NSString *)[controller selectedSerialNumber];
    }else  if ([txtTypefld isEqual:scanQRTxtF]) {
        // qrscanTxtF.text = (NSString *)[controller selectedQRCode];
        barcodeTxtF.text = (NSString *)[controller selectedQRCode];
    }
}

#pragma mark -
#pragma mark UIImagePickerController delegate method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [self dismissViewControllerAnimated: YES completion: nil];
    UIImage *image = [info valueForKey: UIImagePickerControllerOriginalImage];
    profilePic.image = image;
    
    UIImage *rotateImg = [appDataObj fixrotation:image];

    NSData *imageData = UIImageJPEGRepresentation(rotateImg, 0.1);
    strPicEncoded = [Base64 encode:imageData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated: YES completion: nil];
}

-(IBAction)showcameraProfilePic:(id)sender{
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        
        imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imgPicker.allowsEditing = NO;
        imgPicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:
                                UIImagePickerControllerSourceTypeCamera];
        
    }else{
        imgPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imgPicker.allowsEditing = NO;
        imgPicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:
                                UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        
    }
    
    [self presentViewController:imgPicker animated: YES completion: nil];
}


#pragma mark -
#pragma mark WebServiceHelper delegate method
-(void)WebServiceHelper:(WebServiceHelper *)editor didFinishWithResult:(BOOL)result
{
    [SVProgressHUD dismiss];
	if (result)
	{
        if ([[editor currentCall] isEqualToString:@"itemcopy"])
        {
            NSLog(@"result -- %@",[[editor ReturnStr] JSONValue]);
            
                if ([[[editor ReturnStr] JSONValue] valueForKey:@"objItem"] != 0) {
                    [[[UIAlertView alloc] initWithTitle:@"Alert !" message:[[[editor ReturnStr] JSONValue] valueForKey:@"strError"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                    
                    if (isAddSimilar) {
                     /*   for (UIView *view in self.scroller.subviews) {
                            if ([view isKindOfClass:[UITextField class]]) {
                                UITextField *textField = (UITextField *)view;
                                textField.text = @"";
                            }
                        }*/
                        
                        
                        scanQRTxtF.text = @"";
                        scanSericalTxtF.text = @"";
                        barcodeTxtF.text = @"";
                        serialNumberTxtF.text = @"";
                        
                        sellocID = @"";
                        selSiteID = @"";
                        seluserID = @"";
                        strPicEncoded = @"";
                        
                        if (profilePic.image != nil) {
                            UIImage *rotateImg = [appDataObj fixrotation:profilePic.image];
                            NSData *imageData = UIImageJPEGRepresentation(rotateImg, 0.1);
                            strPicEncoded = [Base64 encode:imageData];
                        }
                        
                        if ([[item siteidText] length] > 0) {
                            selSiteID = [item siteidText];
                        }
                        
                        if ([[item locationidText] length] > 0) {
                            sellocID = [item locationidText];
                        }
                        
                        if ([[item useridText] length] > 0) {
                            seluserID = [item useridText];
                        }
                        
                    }else{
                        if (![[[[editor ReturnStr] JSONValue] valueForKey:@"strError"] isEqualToString: @"The barcode already exists"]) {
                            NSArray *array = [self.navigationController viewControllers];
                            [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
                        }
                    }
                  
                }else{
                    [[[UIAlertView alloc] initWithTitle:@"Error !" message:@"Item not saved." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                }
            }
        }
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
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
