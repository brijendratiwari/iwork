//
//  iTeamDetailsViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 02/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "iTeamDetailsViewController.h"
#import "HexColorToUIColor.h"
#import "AppData.h"
#import "ReaderViewController.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "WebServiceHelper.h"
#import "JSON.h"
#import "SVProgressHUD.h"
#import "Base64.h"
#import "SitesClass.h"
#import "LocationClass.h"
#import "UsersClass.h"
#import "CategoriesClass.h"
#import "SitesClass.h"
#import "LocationClass.h"
#import "UsersClass.h"
#import "StatusClass.h"
#import "SupplierResult.h"
#import "Supplier.h"
#import "SupplierDetailsViewController.h"
#import "ScannerViewController.h"
#import "UIImageView+WebCache.h"


@interface iTeamDetailsViewController ()<ReaderViewControllerDelegate,WebServiceHelperDelegate,UIImagePickerControllerDelegate,ScannerViewControllerDelegate>{
    int scrollerHeight;
    HexColorToUIColor *hexColor ;
    UIProgressView *progressView[100];
    AppData *appDataObj;
     NSString *strPicEncoded;
    
    CategoriesClass *catgryClsObj;
    StatusClass *statusClsObj;
    SupplierResult *supplierClsObj;
    
    LocationClass *locClsObj;
    UsersClass *usersClsObj;
    SitesClass *sitesClsObj;
    
    UITextField *txtTypefld;
    
    NSMutableArray *pickerArray,*pickerIDArray;
    NSString *selcatgryID,*selstatusID,*selpatID,*selsuplerID;
    NSString *selSiteID,*sellocID,*seluserID;
    
    UIProgressView *progressIndicator;
    UIActivityIndicatorView *spinner[100];
}

@end

@implementation iTeamDetailsViewController
@synthesize item;
@synthesize scroller = _scroller;

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
    [self.scroller setContentSize:CGSizeMake(320, (scrollerHeight))];
}

- (void)pdfFetchComplete:(ASIHTTPRequest *)request
{
    [spinner[request.tag] stopAnimating];
    
    ReaderDocument *document = [ReaderDocument withDocumentFilePath:[request downloadDestinationPath] password:nil];
    
	if (document != nil)
	{
		ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
        
		readerViewController.delegate = self;
        
        readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
		readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        
		[self presentViewController:readerViewController animated:YES completion:NULL];
    }
}

- (void)pdfFetchFailed:(ASIHTTPRequest *)request
{
     [spinner[request.tag] stopAnimating];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Download failed" message:@"Failed to download files" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] ;
    [alertView show];
}


-(IBAction)backToPrevView:(id)sender{
    [[self navigationController] popViewControllerAnimated:YES];
}

-(IBAction)backToDeshboardView:(id)sender{
    NSArray *array = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[array objectAtIndex:2] animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    hexColor = [[HexColorToUIColor alloc] init];
    
    appDataObj = [AppData sharedInstance];
    
    for (UIView *view in self.scroller.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            textField.userInteractionEnabled = false;
            textField.text = @"N/A";
        }
        
       /* if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            [label setTextColor:[hexColor colorFromHexString:@"#555555" alpha:1.0]];
            [label setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];
        }*/
    }
    
    editlbl.text = @"Edit";
    
    notestTxtV.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    notestTxtV.layer.borderWidth = 1.0f;
    [notestTxtV setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    suppliertf.userInteractionEnabled = TRUE;
    notestTxtV.userInteractionEnabled = false;
    
   // [productNamelbl setTextColor:[hexColor colorFromHexString:@"#555555" alpha:1.0]];
   // [productCodelbl setTextColor:[hexColor colorFromHexString:@"#8a8989" alpha:1.0]];
    [qrCodetf setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [statustf setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [needsometf setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [itemOverviewlbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    //[itemNoteslbl setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    [statustf setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [catgrytf setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [serialnumtf setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [purcahsevaltf setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [currentvaltf setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [purchasedtf setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [warrentyextf setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [replacetf setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [patdatetf setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [patstatustf setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [presntownertf setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [presnloctf setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [replacetf setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [sitetf setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [suppliertf setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
//    [productNamelbl setFont:[UIFont fontWithName:CORBEL_FONT_BOLD size:18.0f]];
//    if (IS_IPAD) {
//        [productNamelbl setFont:[UIFont fontWithName:CORBEL_FONT_BOLD size:35.0f]];
//    }
    
    [productCodelbl setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 28.0f:14.0f)]];
    [qrCodetf setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    [statustf setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    [needsometf setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    [itemOverviewlbl setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 26.0f:13.0f)]];
    //[itemNoteslbl setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];
    
    [catgrytf setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    [serialnumtf setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    [purcahsevaltf setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    [currentvaltf setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    [purchasedtf setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    [warrentyextf setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    [replacetf setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    [patdatetf setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    [patstatustf setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    [presntownertf setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    [presnloctf setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    [sitetf setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    [suppliertf setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];

    
    productNamelbl.text = [NSString stringWithFormat:@"%@ %@",[item manufacturerText],[item modelText]] ;
    productCodelbl.text = [item categorynameText];
    qrCodetf.text = [NSString stringWithFormat:@"%@",[item barcodeText]];
    statustf.text = [NSString stringWithFormat:@"%@",[item statusnameText]];
    
    catgrytf.text = [NSString stringWithFormat:@"%@",[item categorynameText]] ;
    
    if ([item categoryidText]) {
        selcatgryID = [item categoryidText];
    }else{
        selcatgryID = @"-1";
    }
    
    if ([item statusIDText]) {
        selstatusID = [item statusIDText];
    }else{
        selcatgryID = @"-1";
    }
    
    if ([item siteidText]) {
        selSiteID = [item siteidText];
    }else{
        selSiteID = @"-1";
    }
    
    if ([item useridText]) {
        seluserID = [item useridText];
    }else{
        seluserID = @"-1";
    }
    
    if ([item locationidText]) {
        sellocID = [item locationidText];
    }else{
        sellocID = @"-1";
    }
    
    if ([item supplierText]) {
        selsuplerID = [item supplierText];
    }else{
        selsuplerID = @"-1";
    }
    
    serialnumtf.text = [NSString stringWithFormat:@"%@",[item serial_numberText]];
    purcahsevaltf.text = [NSString stringWithFormat:@"%@",[item valueText]];
    currentvaltf.text = [NSString stringWithFormat:@"%@",[item current_valueText]];
    purchasedtf.text = [NSString stringWithFormat:@"%@",[item purchase_dateText]];
    warrentyextf.text = [NSString stringWithFormat:@"%@",[item warranty_dateText]];
    replacetf.text = [NSString stringWithFormat:@"%@",[item replace_dateText]];
    patdatetf.text = [NSString stringWithFormat:@"%@",[item pattest_dateText]];
    patstatustf.text = [NSString stringWithFormat:@"%@",[item pattest_statusText]];
    presntownertf.text = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@ %@",[item userfirstnameText],[item userlastnameText]] ];
    presnloctf.text = [NSString stringWithFormat:@"%@",[item locationnameText]];
    sitetf.text = [NSString stringWithFormat:@"%@",[item sitenameText]];
    suppliertf.text = [NSString stringWithFormat:@"%@",[item suppliers_titleText]];
    notestTxtV.text = [item notesText];
    
    catgryClsObj = [CategoriesClass sharedInstance];
    statusClsObj = [StatusClass sharedInstance];
    supplierClsObj = [SupplierResult sharedInstance];
    sitesClsObj = [SitesClass sharedInstance];
    usersClsObj = [UsersClass sharedInstance];
    locClsObj = [LocationClass sharedInstance];
    
    catgrytf.inputView = dataPicker;
    patstatustf.inputView = dataPicker;
    statustf.inputView = dataPicker;
    suppliertf.inputView = dataPicker;
    
    sitetf.inputView = dataPicker;
    presntownertf.inputView = dataPicker;
    presnloctf.inputView = dataPicker;
    
    warrentyextf.inputView = timedatePicker; // datepicker
    replacetf.inputView = timedatePicker;   // date picker
    patdatetf.inputView = timedatePicker;   // date picker
    purchasedtf.inputView = timedatePicker;   // date picker
    
    timedatePicker.hidden = YES;
    dataPicker.hidden = YES;

    profilePic.layer.borderColor = [[hexColor colorFromHexString:FONT_COLOR alpha:1.0] CGColor];
    profilePic.layer.borderWidth = 1.0f;
    NSLog(@"IMG - %@",[NSString stringWithFormat:@"%@%@",appDataObj.apiURL_IMAGE,[item itemphotopathText]]);
    
    AppData *appData=[AppData sharedInstance];

    
    if ([[item itemphotopathText] length] != 0) {     
        [appData setLoaderOnImageView:profilePic];
        
        [profilePic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",appDataObj.apiURL_IMAGE,[item itemphotopathText]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            [appData removeLoader];
        }];
    }
 
    scrollerHeight = (IS_IPAD ? 1200:838);
    
    if ([[item pdf_nameArr] count] != 0) {
        if (IS_IPAD) {
            [self addPDFViewsforiPad];
        }else{
            [self addPDFViews];
        }
        
       
    }
}

-(IBAction)showcamera:(id)sender{
    
    if (!editButton.selected) {
        return ;
    }
    
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


-(IBAction)updateItemDetailsByAdmin:(id)sender{
    
    if(!editButton.selected)
    {
        NSLog(@"edit");
        
            editlbl.text = @"Save";
        
        catgrytf.userInteractionEnabled = TRUE;
        statustf.userInteractionEnabled = TRUE;
        qrCodetf.userInteractionEnabled = TRUE;
        serialnumtf.userInteractionEnabled = TRUE;
        purcahsevaltf.userInteractionEnabled = TRUE;
        currentvaltf.userInteractionEnabled = TRUE;
        purchasedtf.userInteractionEnabled = TRUE;
        warrentyextf.userInteractionEnabled = TRUE;
        replacetf.userInteractionEnabled = TRUE;
        patdatetf.userInteractionEnabled = TRUE;
        patstatustf.userInteractionEnabled = TRUE;
        notestTxtV.userInteractionEnabled = TRUE;
        
        sitetf.userInteractionEnabled = TRUE;
        presntownertf.userInteractionEnabled = TRUE;
        presnloctf.userInteractionEnabled = TRUE;
        
        qrCodetf.text = [NSString stringWithFormat:@"%@",[item barcodeText]];
        statustf.text = [NSString stringWithFormat:@"%@",[item statusnameText]];
        catgrytf.text = [NSString stringWithFormat:@"%@",[item categorynameText]] ;
        serialnumtf.text = [NSString stringWithFormat:@"%@",[item serial_numberText]];
        purcahsevaltf.text = [NSString stringWithFormat:@"%@",[item valueText]];
        currentvaltf.text = [NSString stringWithFormat:@"%@",[item current_valueText]];
        purchasedtf.text = [NSString stringWithFormat:@"%@",[item purchase_dateText]];
        warrentyextf.text = [NSString stringWithFormat:@"%@",[item warranty_dateText]];
        replacetf.text = [NSString stringWithFormat:@"%@",[item replace_dateText]];
        patdatetf.text = [NSString stringWithFormat:@"%@",[item pattest_dateText]];
        patstatustf.text = [NSString stringWithFormat:@"%@",[item pattest_statusText]];
        presntownertf.text = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@ %@",[item userfirstnameText],[item userlastnameText]]];
        presnloctf.text = [NSString stringWithFormat:@"%@",[item locationnameText]];
        sitetf.text = [NSString stringWithFormat:@"%@",[item sitenameText]];
        suppliertf.text = [NSString stringWithFormat:@"%@",[item suppliers_titleText]];
        
    }else{
        
        NSLog(@"save");
        
         editlbl.text = @"Edit";
        
       // return ;
        
        NSString *photoRepresnt = @"true";
        
        if (strPicEncoded.length == 0) {
            photoRepresnt = @"false";
            strPicEncoded = @"";
        }
        
        if (selpatID.length == 0) {
            selpatID = @"-1";
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
        if (selsuplerID.length == 0) {
            selsuplerID = @"-1";
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
            
            [obj setMethodName:[NSString stringWithFormat:@"itemUpdate/%@",[item itemidText]]];
            [obj setMethodResult:@""];
            [obj setMethodType:@"POST"];
            [obj setCurrentCall:@"itemUpdate"];
            
            [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
            [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
            [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
            
            [obj.MethodParameters setObject:qrCodetf.text forKey:@"item_barcode"]; //yyy00139
            [obj.MethodParameters setObject:serialnumtf.text forKey:@"item_serial_number"]; //37J122201102
            [obj.MethodParameters setObject:notestTxtV.text forKey:@"item_notes"];
            
            [obj.MethodParameters setObject:purchasedtf.text forKey:@"purchase_date"];
            [obj.MethodParameters setObject:warrentyextf.text forKey:@"warranty_date"];
            
            [obj.MethodParameters setObject:selcatgryID forKey:@"category_id"];
            [obj.MethodParameters setObject:replacetf.text forKey:@"item_replace"];
            [obj.MethodParameters setObject:currentvaltf.text forKey:@"item_value"];
            [obj.MethodParameters setObject:purchasedtf.text forKey:@"purchased"];
            [obj.MethodParameters setObject:purcahsevaltf.text forKey:@"purchase_value"];
            
            [obj.MethodParameters setObject:selstatusID forKey:@"status_id"];
            [obj.MethodParameters setObject:strPicEncoded forKey:@"item_image_data"];
            
            [obj.MethodParameters setObject:photoRepresnt forKey:@"photo_present"];
            
            
            [obj.MethodParameters setObject:seluserID forKey:@"user_id"];
            [obj.MethodParameters setObject:sellocID forKey:@"location_id"];
            [obj.MethodParameters setObject:selSiteID forKey:@"site_id"];
            [obj.MethodParameters setObject:selsuplerID forKey:@"item_supplier"];
            
            [obj.MethodParameters setObject:patdatetf.text forKey:@"pattest_date"];
            [obj.MethodParameters setObject:selpatID forKey:@"pattest_status"];
            
            [obj initiateConnection];
            
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            [SVProgressHUD dismiss];
            [SVProgressHUD show];
        }

        
    }
    
    editButton.selected=!editButton.selected;
    
}

#pragma mark - Text field delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    pickerArray = [NSMutableArray array];
    pickerIDArray = [NSMutableArray array];
    
    if ([textField isEqual:suppliertf]) {
        txtTypefld = suppliertf;
        if (!editButton.selected) {
            
            SupplierDetailsViewController *supplierContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"SupplierDetailsViewController"];
            
            if ([[item suppliers_titleText] isEqualToString:@"Not Available"] ) {
                [textField resignFirstResponder];
                return ;
            }
            
            for (int i = 0; i < [[supplierClsObj suppliers] count]; i++) {
                Supplier *supplier = [[supplierClsObj suppliers] objectAtIndex:i];
                if ([[supplier supplier_id] isEqualToString:[item supplierText]]) {
                    supplierContoller.supplier = supplier;
                    supplierContoller.controllerRoot = @"itemDetails";
                     [[self navigationController] presentViewController:supplierContoller animated:YES completion:nil];
                    break;
                }else{
                    break;
                    return ;
                }
            }
            return;
           
            
        }else{
            [pickerArray addObject:@"Select Supplier"];
            [pickerIDArray addObject:@"-1"];
            for (int i = 0; i < [[supplierClsObj suppliers] count]; i++) {
                Supplier *supplier = [[supplierClsObj suppliers] objectAtIndex:i];
                [pickerArray addObject:[supplier supplier_title]];
                [pickerIDArray addObject:[supplier supplier_id]];
                dataPicker.hidden = NO;
                [dataPicker reloadAllComponents];
                [dataPicker selectRow:0 inComponent:0 animated:YES];
            }
        }
    }
 
    
    if ([textField isEqual:sitetf]) {
        if (sitesClsObj.getSitesName) {
            txtTypefld = sitetf;
            pickerArray = sitesClsObj.getSitesName;
            pickerIDArray = sitesClsObj.getSitesID;
            dataPicker.hidden = NO;
            [dataPicker reloadAllComponents];
            [dataPicker selectRow:0 inComponent:0 animated:YES];
        }
    }

    if ([textField isEqual:presntownertf]) {
        if (usersClsObj.getUsersName) {
            txtTypefld = presntownertf;
            pickerArray = usersClsObj.getUsersName;
            pickerIDArray = usersClsObj.getUsersID;
            dataPicker.hidden = NO;
            [dataPicker reloadAllComponents];
            [dataPicker selectRow:0 inComponent:0 animated:YES];
        }
    }

    if ([textField isEqual:presnloctf]) {
        if (locClsObj.getLocationName) {
            txtTypefld = presnloctf;
            pickerArray = locClsObj.getLocationName;
            pickerIDArray = locClsObj.getLocationID;
            dataPicker.hidden = NO;
            [dataPicker reloadAllComponents];
            [dataPicker selectRow:0 inComponent:0 animated:YES];
        }
    }

    
    if ([textField isEqual:catgrytf]) {
        if (catgryClsObj.getCategoriesName) {
            txtTypefld = catgrytf;
            pickerArray = catgryClsObj.getCategoriesName;
            pickerIDArray = catgryClsObj.getCategoriesID;
            dataPicker.hidden = NO;
            [dataPicker reloadAllComponents];
            [dataPicker selectRow:0 inComponent:0 animated:YES];
        }
    }
    
    if ([textField isEqual:statustf]) {
        if (statusClsObj.getStatusName) {
            txtTypefld = statustf;
            pickerArray = statusClsObj.getStatusName;
            pickerIDArray = statusClsObj.getStatusID;
            dataPicker.hidden = NO;
            [dataPicker reloadAllComponents];
            [dataPicker selectRow:0 inComponent:0 animated:YES];
        }
    }
    
    if ([textField isEqual:qrCodetf]) {
        txtTypefld = qrCodetf;
        ScannerViewController *scannerContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ScannerViewController"];
        scannerContoller.delegate = self;
        [self presentViewController:scannerContoller animated:YES completion:nil];
    }
    
    if ([textField isEqual:serialnumtf]) {
        txtTypefld = serialnumtf;
        ScannerViewController *scannerContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ScannerViewController"];
        scannerContoller.delegate = self;
        [self presentViewController:scannerContoller animated:YES completion:nil];
    }
    
    if ([textField isEqual:purchasedtf]) {
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd/MM/yyyy";
        purchasedtf.text = [dateFormatter stringFromDate:[NSDate date]];
        
        timedatePicker.hidden = NO;
        txtTypefld = purchasedtf;
    }
    if ([textField isEqual:warrentyextf]) {
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd/MM/yyyy";
        warrentyextf.text = [dateFormatter stringFromDate:[NSDate date]];
        
        timedatePicker.hidden = NO;
        txtTypefld = warrentyextf;
    }
    
    if ([textField isEqual:replacetf]) {
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd/MM/yyyy";
        replacetf.text = [dateFormatter stringFromDate:[NSDate date]];
        
        timedatePicker.hidden = NO;
        txtTypefld = replacetf;
    }
    if ([textField isEqual:patdatetf]) {
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd/MM/yyyy";
        patdatetf.text = [dateFormatter stringFromDate:[NSDate date]];
        
        timedatePicker.hidden = NO;
        txtTypefld = patdatetf;
    }
    
    if ([textField isEqual:patstatustf]) {
        txtTypefld = patstatustf;
        
        pickerArray = nil;
        pickerIDArray = nil;
        
        pickerArray = [NSMutableArray arrayWithObjects:@"Unknown",@"Pass",@"Fail",@"Not Required", nil];
        pickerIDArray = [NSMutableArray arrayWithObjects:@"-1",@"1",@"0",@"5", nil];
        dataPicker.hidden = NO;
        [dataPicker reloadAllComponents];
        [dataPicker selectRow:0 inComponent:0 animated:YES];
    }

}

- (IBAction)valueChangeForDatePicker:(id)sender {
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy";
    NSLog(@"%@",[dateFormatter stringFromDate:[timedatePicker date]]);
    
    if ([txtTypefld isEqual:purchasedtf]) {
        purchasedtf.text = [dateFormatter stringFromDate:[timedatePicker date]];
    }else if ([txtTypefld isEqual:warrentyextf]) {
        warrentyextf.text = [dateFormatter stringFromDate:[timedatePicker date]];
    }else if ([txtTypefld isEqual:replacetf]) {
        replacetf.text = [dateFormatter stringFromDate:[timedatePicker date]];
    }else if ([txtTypefld isEqual:patdatetf]) {
        patdatetf.text = [dateFormatter stringFromDate:[timedatePicker date]];
    }
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
    
    
    if ([txtTypefld isEqual:sitetf]) {
        [sitetf setText:[pickerArray objectAtIndex:row]];
        selSiteID = [pickerIDArray objectAtIndex:row];
    }
    
    if ([txtTypefld isEqual:presntownertf]) {
        [presntownertf setText:[pickerArray objectAtIndex:row]];
        seluserID = [pickerIDArray objectAtIndex:row];
    }
    
    if ([txtTypefld isEqual:presnloctf]) {
        [presnloctf setText:[pickerArray objectAtIndex:row]];
        sellocID = [pickerIDArray objectAtIndex:row];
    }
    
    
    if ([txtTypefld isEqual:catgrytf]) {
        [catgrytf setText:[pickerArray objectAtIndex:row]];
        selcatgryID = [pickerIDArray objectAtIndex:row];
    }
    
    if ([txtTypefld isEqual:suppliertf]) {
        [suppliertf setText:[pickerArray objectAtIndex:row]];
        selsuplerID = [pickerIDArray objectAtIndex:row];
    }
    
    if ([txtTypefld isEqual:statustf]) {
        [statustf setText:[pickerArray objectAtIndex:row]];
        selstatusID = [pickerIDArray objectAtIndex:row];
    }
    
    if ([txtTypefld isEqual:patstatustf]) {
        [patstatustf setText:[pickerArray objectAtIndex:row]];
        selpatID = [pickerIDArray objectAtIndex:row];
    }
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}

#pragma mark -
#pragma mark Scanner View Controller delegate method
-(void)selectQRCodeAndSerialNumber:(ScannerViewController *)controller{
    if ([txtTypefld isEqual:serialnumtf]) {
        serialnumtf.text = (NSString *)[controller selectedSerialNumber];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else  if ([txtTypefld isEqual:qrCodetf]) {
        qrCodetf.text = (NSString *)[controller selectedQRCode];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}


#pragma mark -
#pragma mark WebServiceHelper delegate method
-(void)WebServiceHelper:(WebServiceHelper *)editor didFinishWithResult:(BOOL)result{
    [SVProgressHUD dismiss];
    if (result)
    {
        if ([[editor currentCall] isEqualToString:@"itemUpdate"])
        {
            NSMutableDictionary *resultDic = [[editor ReturnStr] JSONValue];
            [[[UIAlertView alloc] initWithTitle:@"Alert !" message:[resultDic objectForKey:@"Message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            [[self navigationController] popViewControllerAnimated:YES];
        }
    }
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

-(void)readPDF:(UIButton *)btn{
    NSLog(@"tag - %ld",(long)btn.tag);
    
    [spinner[btn.tag] startAnimating];
    
    if (!networkQueue) {
		networkQueue = [[ASINetworkQueue alloc] init];
	}
	[networkQueue reset];
	//[networkQueue setDownloadProgressDelegate:progressIndicator];
	[networkQueue setRequestDidFinishSelector:@selector(pdfFetchComplete:)];
	[networkQueue setRequestDidFailSelector:@selector(pdfFetchFailed:)];
	//[networkQueue setShowAccurateProgress:TRUE];
	[networkQueue setDelegate:self];
    
    ASIHTTPRequest *request;
    NSString *strURL = [NSString stringWithFormat:@"%@/%@/%@",appDataObj.apiURL_PDF,[item itemidText],[[item pdf_nameArr] objectAtIndex:btn.tag]];
    
    NSString* encodedUrl = [strURL stringByAddingPercentEscapesUsingEncoding:
                            NSASCIIStringEncoding];
    
    NSLog(@"PDF URL - %@",encodedUrl);
    
    request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:encodedUrl]];
    request.tag = btn.tag;
	[request setDownloadDestinationPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[[item pdf_nameArr] objectAtIndex:btn.tag]]];
	[request setDownloadProgressDelegate:progressIndicator];
    //[request setShowAccurateProgress:YES];
    [request setUserInfo:[NSDictionary dictionaryWithObject:[[item pdf_nameArr] objectAtIndex:btn.tag] forKey:@"name"]];
    [request setDownloadProgressDelegate:self];
	[networkQueue addOperation:request];
	
	[networkQueue go];

}



- (void)setProgress:(float)newProgress
{
    NSLog(@"progress - %f",newProgress);
}

-(void)addPDFViewsforiPad{
    int ypos = 850;
    int space = 20;
    int viewH = 86;
    scrollerHeight = 1200;
    
    
    
    for (int i= 0; i < [item pdf_nameArr].count; i++) {
        UIView *viewaa = [[UIView alloc] initWithFrame:CGRectMake(141, ypos, 420, viewH)];
        viewaa.layer.borderWidth = 1.0f;
        viewaa.layer.borderColor = [[UIColor blackColor] CGColor];
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(35, 13, 58, 60)];
        imgV.image = [UIImage imageNamed:@"pdf_icon.png"];
        [viewaa addSubview:imgV];
        
        UIButton *buttn = [UIButton buttonWithType:UIButtonTypeCustom];
        buttn.frame = CGRectMake(123, 13, 266, 48);
        [buttn setTitle:[[item pdf_nameArr] objectAtIndex:i] forState:UIControlStateNormal];
        buttn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        buttn.tag = i;
        [buttn setTitleColor:[hexColor colorFromHexString:@"#000000" alpha:1.0] forState:UIControlStateNormal];
        [buttn setFont:[UIFont fontWithName:CORBEL_FONT size:26.0f]];
        [buttn addTarget:self action:@selector(readPDF_ViewDoc:) forControlEvents:UIControlEventTouchUpInside];
        [viewaa setBackgroundColor:[UIColor redColor]];
        [viewaa addSubview:buttn];
        
        spinner[i] = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner[i].frame = CGRectMake(35, 13, 58, 60);
        spinner[i].hidesWhenStopped = YES;
        spinner[i].backgroundColor = [UIColor lightGrayColor];
        [viewaa bringSubviewToFront:spinner[i]];
        
        [viewaa addSubview:spinner[i]];
        
        
        [[self scroller] addSubview:viewaa];
        ypos = ypos+viewH+space;
        scrollerHeight = ypos+viewH+space;
    }
    
}

-(void)addPDFViews{
    
    int ypos = 780;
    int space = 10;
    int viewH = 50;
    scrollerHeight = 858;
    
    for (int i= 0; i < [[item pdf_nameArr] count]; i++) {
        UIView *viewaa = [[UIView alloc] initWithFrame:CGRectMake(0, ypos, 320, viewH)];
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        imgV.image = [UIImage imageNamed:@"pdf_image.png"];
        [viewaa addSubview:imgV];
         //[viewaa setBackgroundColor:[UIColor redColor]];
        
        UIButton *buttn = [UIButton buttonWithType:UIButtonTypeCustom];
        buttn.frame = CGRectMake(50, 10, 250, 20);
        [buttn setTitle:[[item pdf_nameArr] objectAtIndex:i] forState:UIControlStateNormal];
        buttn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        buttn.tag = i;
        [buttn setTitleColor:[hexColor colorFromHexString:@"#8a8989" alpha:1.0] forState:UIControlStateNormal];
        [buttn setFont:[UIFont fontWithName:CORBEL_FONT_BOLD size:15.0f]];
        [buttn addTarget:self action:@selector(readPDF:) forControlEvents:UIControlEventTouchUpInside];
        [viewaa addSubview:buttn];
        
        
//        if (!progressIndicator) {
//            progressIndicator = [[UIProgressView alloc] initWithFrame:CGRectMake(50, 34, 250, 10)];
//        } else {
//            [progressIndicator setFrame:CGRectMake(50, 34, 250, 10)];
//        }
        
        progressView[i] = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        progressView[i].frame = CGRectMake(50, 34, 250, 10);
        [progressView[i] setProgress:0.0];
        //[viewaa addSubview:progressIndicator];
        
        
        spinner[i] = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner[i].frame = CGRectMake(10, 10, 30, 30);
        spinner[i].hidesWhenStopped = YES;
        spinner[i].backgroundColor = [UIColor lightGrayColor];
        [viewaa bringSubviewToFront:spinner[i]];
        
        [viewaa addSubview:spinner[i]];
        
        [[self scroller] addSubview:viewaa];
        ypos = ypos+viewH+space;
        
        scrollerHeight = ypos+viewH+space;
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

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
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
