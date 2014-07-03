//
//  AddItemViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 07/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "AddItemViewController.h"
#import "AppData.h"
#import "WebServiceHelper.h"
#import "SVProgressHUD.h"
#import "JSON.h"
#import "ManufactureClass.h"
#import "CategoriesClass.h"
#import "SitesClass.h"
#import "LocationClass.h"
#import "UsersClass.h"
#import "StatusClass.h"
#import "ScannerViewController.h"
#import "HexColorToUIColor.h"
#import "Base64.h"
#import "AddSimilarViewController.h"

@interface AddItemViewController ()<WebServiceHelperDelegate,ScannerViewControllerDelegate,UIImagePickerControllerDelegate>{
    AppData *appDataObj;
    NSMutableArray *pickerArray,*pickerIDArray;
    ManufactureClass *manfacClsObj;
    CategoriesClass *catgryClsObj;
    LocationClass *locClsObj;
    UsersClass *usersClsObj;
    SitesClass *sitesClsObj;
    StatusClass *statusClsObj;
    
    UITextField *txtTypefld;
    
    NSString *selSiteID,*selcatgryID,*sellocID,*seluserID,*selstatusID;
    NSString *strPicEncoded;
    BOOL isAddSimilar;
}

@end

@implementation AddItemViewController
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
    [self.scroller setContentSize:CGSizeMake(320, (IS_IPAD ? 2440:1445))];
}

-(IBAction)backToDeshboardView:(id)sender{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HexColorToUIColor *hexColor = [[HexColorToUIColor alloc] init];
    appDataObj = [AppData sharedInstance];
    
    [selmanufacTextF setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
     selmanufacTextF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"SELECT MANUFACTURER" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
     [selmanufacTextF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [manufacTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    manufacTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"MANUFACTURER" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:FONT_COLOR alpha:1.0f]}];
    [manufacTxtF setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    
    [modelTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    modelTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"MODEL" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:FONT_COLOR alpha:1.0f]}];
    [modelTxtF setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    
    [serialTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    serialTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"SERIAL NUMBER" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:FONT_COLOR alpha:1.0f]}];
    [serialTxtF setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];

    [serialNumScanTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    serialNumScanTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"SERIAL NUMBER SCAN" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [serialNumScanTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [barcodeTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    barcodeTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"QR CODE" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:FONT_COLOR alpha:1.0f]}];
    [barcodeTxtF setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    
    [qrscanTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    qrscanTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"QR SCAN" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [qrscanTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    
    [selectcatgryTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    selectcatgryTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"SELECT CATEGORY" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [selectcatgryTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [statusTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    statusTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"STATUS" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [statusTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [noteslbl setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    [noteslbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [notesTxtV setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    [notesTxtV setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [valueTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    
    valueTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"VALUE(£)" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:FONT_COLOR alpha:1.0f]}];
    
    if ([appDataObj.countryName isEqualToString:@"au"]) {
        valueTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"VALUE($)" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:FONT_COLOR alpha:1.0f]}];
    }
    
    [valueTxtF setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    
    [takePhotoTextF setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    takePhotoTextF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"TAKE PHOTO" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [takePhotoTextF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [selSiteTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    selSiteTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"SELECT SITE" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [selSiteTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [selectUserTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    selectUserTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"SELECT USER" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [selectUserTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [selectLocTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    selectLocTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"SELECT LOCATION" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [selectLocTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [purchaseDateTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    purchaseDateTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"PURCHASE DATE" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [purchaseDateTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [warrntyexpTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    warrntyexpTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"WARRANTY EXPIRE DATE" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [warrntyexpTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [patreqlbl setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    [patreqlbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [addSimilarlbl setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)]];
    [addSimilarlbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    itemImage.layer.borderColor = [[hexColor colorFromHexString:FONT_COLOR alpha:1.0] CGColor];
    itemImage.layer.borderWidth = 1.5f;
    
    
    manfacClsObj = [ManufactureClass sharedInstance];
    catgryClsObj = [CategoriesClass sharedInstance];
    usersClsObj = [UsersClass sharedInstance];
    locClsObj = [LocationClass sharedInstance];
    sitesClsObj = [SitesClass sharedInstance];
    statusClsObj = [StatusClass sharedInstance];
    
    selmanufacTextF.inputView = dataPicker;
    selectcatgryTxtF.inputView = dataPicker;
    selSiteTxtF.inputView = dataPicker;
    selectUserTxtF.inputView = dataPicker;
    selectLocTxtF.inputView = dataPicker;
    
    statusTxtF.inputView = dataPicker;
    [statusTxtF setText:@"OK"];
    selstatusID = @"1";
    
    //takePhotoTextF.inputView = imgController; // camera open

    purchaseDateTxtF.inputView = timedatePicker; // datepicker
    warrntyexpTxtF.inputView = timedatePicker;   // date picker

    timedatePicker.hidden = YES;
    dataPicker.hidden = YES;
    
    isAddSimilar = NO;
    
    for (UIView *view in self.scroller.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            
            [textField setValue:[UIColor darkGrayColor]
                     forKeyPath:@"_placeholderLabel.textColor"];
            
            [textField setTextColor:[UIColor darkGrayColor]];
        }
    }
    

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

- (IBAction)checkPatRequired:(id)sender {
    patButton.selected=!patButton.selected;
}

- (IBAction)checkAnotherSimilarItem:(id)sender {
    if (addSimilerBtn.selected) {
        isAddSimilar = NO;
    }else{
        isAddSimilar = YES;
    }
    addSimilerBtn.selected=!addSimilerBtn.selected;
}

- (IBAction)itemAddSaveBtnClick:(id)sender {
    
    NSString *strPAT = @"";
    NSString *photoRepresnt = @"true";
    
    if (!patButton.selected) {
        strPAT = @"1";
    }else{
        strPAT = @"-1";
    }
    
    if (strPicEncoded.length == 0) {
        photoRepresnt = @"false";
        strPicEncoded = @"";
    }
  
    // for validation
    NSString *errormsg = @"";
    if (manufacTxtF.text.length == 0) {
        errormsg = @"Please enter manufacturer.\n";
    }
    if (modelTxtF.text.length == 0) {
        errormsg = [errormsg stringByAppendingString:@"Please enter model.\n"];
    }
    if (barcodeTxtF.text.length == 0) {
        errormsg = [errormsg stringByAppendingString:@"Please enter qrcode.\n"];
    }
    if (selectcatgryTxtF.text.length == 0) {
        errormsg = [errormsg stringByAppendingString:@"Please select catagory.\n"];
    }
    if (statusTxtF.text.length == 0) {
        errormsg = [errormsg stringByAppendingString:@"Please select status.\n"];
    }
    
    if (seluserID.length == 0) {
        if (selSiteID.length == 0) {
            if (sellocID.length == 0) {
                 errormsg = [errormsg stringByAppendingString:@"Please select atleast one of the locations, sites and users."];
            }
        }
       
    }
    
    if (![errormsg isEqualToString:@""]) {
        UIAlertView *erralert = [[UIAlertView alloc] initWithTitle:@"Login Error" message:errormsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [erralert show];
        return ;
    }
    
    
    NSString *seralnum = @"";
    NSString *notes = @"";
    NSString *value = @"";
    NSString *purdate = @"";
    NSString *wexdate = @"";
    
    //for blank values
    if (serialTxtF.text.length != 0) {
        seralnum = serialTxtF.text;
    }
    
    if (notesTxtV.text.length != 0) {
        notes = notesTxtV.text;
    }
    if (valueTxtF.text.length != 0) {
        value = valueTxtF.text;
    }
    if (purchaseDateTxtF.text.length != 0) {
        purdate = purchaseDateTxtF.text;
    }
    if (warrntyexpTxtF.text.length != 0) {
        wexdate = warrntyexpTxtF.text;
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
        
        [obj setMethodName:@"itemadd"];
        [obj setMethodResult:@""];
        [obj setMethodType:@"POST"];
        [obj setCurrentCall:@"itemadd"];
        
      /*  arrData = {
        username: strGlobalUsername,
        password: strGlobalPassword,
        mode: "submit",
        item_barcode: String($('input[name="item_barcode"]').val()).toUpperCase(),
        item_serial_number: $('input[name="item_serial_number"]').val(),
        item_make: $('input[name="item_make"]').val(),
        item_model: $('input[name="item_model"]').val(),
        item_supplier: supplier_id,
        site_id: $('select[name="ownership_site_id"]').val(),
        category_id: $('select[name="item_category_id"]').val(),
        status_id: $('select[name="item_status_id"]').val(),
        purchase_date: $('input[name="item_purchased"]').val(),
        warranty_date: $('input[name="item_warranty"]').val(),
        item_value: $('input[name="item_value"]').val(),
        item_notes: $('textarea[name="item_notes"]').val(),
        user_id: $('select[name="ownership_user_id"]').val(),
        location_id: $('select[name="ownership_location_id"]').val(),
        item_image_data: $('input[name="photo_item_image"]').val(),
        photo_present: $('input[name="photo_photo_present"]').val(),
        item_patrequired: intPATRequired,
        timestamp: Math.round(new Date().getTime() / 1000) //to make the query unique
        };*/

         [obj.MethodParameters setObject:@"submit" forKey:@"mode"];
        
         [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
         [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
         [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
        
        [obj.MethodParameters setObject:barcodeTxtF.text forKey:@"item_barcode"]; //AA0001
        [obj.MethodParameters setObject:seralnum forKey:@"item_serial_number"]; //37J122201102
        [obj.MethodParameters setObject:manufacTxtF.text forKey:@"item_make"];
        [obj.MethodParameters setObject:modelTxtF.text forKey:@"item_model"];
        [obj.MethodParameters setObject:selSiteID forKey:@"site_id"];
        [obj.MethodParameters setObject:selcatgryID forKey:@"category_id"];
        [obj.MethodParameters setObject:seluserID forKey:@"user_id"];
        [obj.MethodParameters setObject:sellocID forKey:@"location_id"];
        [obj.MethodParameters setObject:value forKey:@"item_value"];
        [obj.MethodParameters setObject:notes forKey:@"item_notes"];

        [obj.MethodParameters setObject:purdate forKey:@"purchase_date"];
        [obj.MethodParameters setObject:wexdate forKey:@"warranty_date"];
      
        [obj.MethodParameters setObject:strPicEncoded forKey:@"item_image_data"];
        
        [obj.MethodParameters setObject:photoRepresnt forKey:@"photo_present"];
        [obj.MethodParameters setObject:strPAT forKey:@"item_patrequired"];
        
        [obj.MethodParameters setObject:@"-1" forKey:@"item_supplier"]; // not getting
        [obj.MethodParameters setObject:selstatusID forKey:@"status_id"]; // not getting
        
        [obj initiateConnection];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [SVProgressHUD dismiss];
        [SVProgressHUD show];
    }
}


#pragma mark - Text field delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    pickerArray = [NSMutableArray array];
    pickerIDArray = [NSMutableArray array];
    if ([textField isEqual:selmanufacTextF]) {
        if (manfacClsObj.getManufactureName) {
            txtTypefld = selmanufacTextF;
            pickerArray = manfacClsObj.getManufactureName;
            dataPicker.hidden = NO;
            [dataPicker reloadAllComponents];
            [dataPicker selectRow:0 inComponent:0 animated:YES];
        }
    }
    if ([textField isEqual:selectUserTxtF]) {
        if (usersClsObj.getUsersName) {
            txtTypefld = selectUserTxtF;
            pickerArray = usersClsObj.getUsersName;
            pickerIDArray = usersClsObj.getUsersID;
            dataPicker.hidden = NO;
            [dataPicker reloadAllComponents];
            [dataPicker selectRow:0 inComponent:0 animated:YES];
        }
    }
    if ([textField isEqual:selectLocTxtF]) {
        if (locClsObj.getLocationName) {
            txtTypefld = selectLocTxtF;
            pickerArray = locClsObj.getLocationName;
            pickerIDArray = locClsObj.getLocationID;
            dataPicker.hidden = NO;
            [dataPicker reloadAllComponents];
            [dataPicker selectRow:0 inComponent:0 animated:YES];
        }
    }
    if ([textField isEqual:selectcatgryTxtF]) {
        if (catgryClsObj.getCategoriesName) {
            txtTypefld = selectcatgryTxtF;
            pickerArray = catgryClsObj.getCategoriesName;
            pickerIDArray = catgryClsObj.getCategoriesID;
            dataPicker.hidden = NO;
            [dataPicker reloadAllComponents];
            [dataPicker selectRow:0 inComponent:0 animated:YES];
        }
    }
    if ([textField isEqual:selSiteTxtF]) {
        if (sitesClsObj.getSitesName) {
            txtTypefld = selSiteTxtF;
            pickerArray = sitesClsObj.getSitesName;
            pickerIDArray = sitesClsObj.getSitesID;
            dataPicker.hidden = NO;
            [dataPicker reloadAllComponents];
            [dataPicker selectRow:0 inComponent:0 animated:YES];
        }
    }
    
    if ([textField isEqual:statusTxtF]) {
        if (statusClsObj.getStatusName) {
            txtTypefld = statusTxtF;
            pickerArray = statusClsObj.getStatusName;
            pickerIDArray = statusClsObj.getStatusID;
            dataPicker.hidden = NO;
            [dataPicker reloadAllComponents];
            [dataPicker selectRow:0 inComponent:0 animated:YES];
        }
    }
    
    if ([textField isEqual:qrscanTxtF]) {
        txtTypefld = qrscanTxtF;
        ScannerViewController *scannerContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ScannerViewController"];
        scannerContoller.delegate = self;
        [self presentViewController:scannerContoller animated:YES completion:nil];
    }
    
    if ([textField isEqual:serialNumScanTxtF]) {
        txtTypefld = serialNumScanTxtF;
        ScannerViewController *scannerContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ScannerViewController"];
        scannerContoller.delegate = self;
        [self presentViewController:scannerContoller animated:YES completion:nil];
    }
    
    if ([textField isEqual:takePhotoTextF]) {
       // timedatePicker.hidden = NO;
       // txtTypefld = warrntyexpTxtF;
        
//         [self performSelector:@selector(showcamera) withObject:nil afterDelay:0.3];
    }
    
    if ([textField isEqual:warrntyexpTxtF]) {
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd/MM/yyyy";
        warrntyexpTxtF.text = [dateFormatter stringFromDate:[NSDate date]];
        
        timedatePicker.hidden = NO;
        txtTypefld = warrntyexpTxtF;
    }
    if ([textField isEqual:purchaseDateTxtF]) {
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd/MM/yyyy";
        purchaseDateTxtF.text = [dateFormatter stringFromDate:[NSDate date]];
        
        timedatePicker.hidden = NO;
        txtTypefld = purchaseDateTxtF;
    }
}


-(IBAction)showcamera:(id)sender{
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

- (IBAction)valueChangeForDatePicker:(id)sender {
  
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy";
    NSLog(@"%@",[dateFormatter stringFromDate:[timedatePicker date]]);
    
    if ([txtTypefld isEqual:warrntyexpTxtF]) {
        warrntyexpTxtF.text = [dateFormatter stringFromDate:[timedatePicker date]];
    }else if ([txtTypefld isEqual:purchaseDateTxtF]) {
        purchaseDateTxtF.text = [dateFormatter stringFromDate:[timedatePicker date]];
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
    
    if ([txtTypefld isEqual:selmanufacTextF]) {
        [selmanufacTextF setText:[pickerArray objectAtIndex:row]];
        [manufacTxtF setText:[pickerArray objectAtIndex:row]];
    }
    if ([txtTypefld isEqual:selectUserTxtF]) {
        [selectUserTxtF setText:[pickerArray objectAtIndex:row]];
        seluserID = [pickerIDArray objectAtIndex:row];
    }
    if ([txtTypefld isEqual:selectLocTxtF]) {
        [selectLocTxtF setText:[pickerArray objectAtIndex:row]];
        sellocID = [pickerIDArray objectAtIndex:row];
    }
    if ([txtTypefld isEqual:selSiteTxtF]) {
        [selSiteTxtF setText:[pickerArray objectAtIndex:row]];
        selSiteID = [pickerIDArray objectAtIndex:row];
    }
    if ([txtTypefld isEqual:selectcatgryTxtF]) {
        [selectcatgryTxtF setText:[pickerArray objectAtIndex:row]];
        selcatgryID = [pickerIDArray objectAtIndex:row];
    }
    
    if ([txtTypefld isEqual:statusTxtF]) {
        [statusTxtF setText:[pickerArray objectAtIndex:row]];
        selstatusID = [pickerIDArray objectAtIndex:row];
    }
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}

#pragma mark -
#pragma mark Scanner View Controller delegate method
-(void)selectQRCodeAndSerialNumber:(ScannerViewController *)controller{
    if ([txtTypefld isEqual:serialNumScanTxtF]) {
       // serialNumScanTxtF.text = (NSString *)[controller selectedSerialNumber];
        serialTxtF.text = (NSString *)[controller selectedSerialNumber];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else  if ([txtTypefld isEqual:qrscanTxtF]) {
       // qrscanTxtF.text = (NSString *)[controller selectedQRCode];
        barcodeTxtF.text = (NSString *)[controller selectedQRCode];
        [self dismissViewControllerAnimated:YES completion:nil];

    }
}



#pragma mark -
#pragma mark WebServiceHelper delegate method
-(void)WebServiceHelper:(WebServiceHelper *)editor didFinishWithResult:(BOOL)result{
    [SVProgressHUD dismiss];
	if (result)
	{
        if ([[editor currentCall] isEqualToString:@"itemadd"])
        {
             NSLog(@"result -- %@",[[editor ReturnStr] JSONValue]);
            [[[UIAlertView alloc] initWithTitle:@"Alert !" message:[[[editor ReturnStr] JSONValue] valueForKeyPath:@"Message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            
            if ([[[[editor ReturnStr] JSONValue] valueForKeyPath:@"Message"] isEqualToString: @"The QRCode already exists"]) {
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                return ;
            }
            
            if (isAddSimilar) {
                
                Item *item = [[Item alloc] init];
                [item setItemData:[[[editor ReturnStr] JSONValue] objectForKey:@"arrItem"]];
                
                NSArray *arrItem = [[[editor ReturnStr] JSONValue] objectForKey:@"arrItem"];
                
                NSMutableArray *arrallmanuf = [manfacClsObj getManufactureName];
                [arrallmanuf addObject:[arrItem valueForKey:@"manufacturer"]];
                [manfacClsObj setManufactureName:arrallmanuf];
                
                AddSimilarViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"AddSimilarViewController"];
                pushContoller.item = item;
                [[self navigationController] pushViewController:pushContoller animated:YES];
                
            }else{
                
                NSArray *arrItem = [[[editor ReturnStr] JSONValue] objectForKey:@"arrItem"];
                
                NSMutableArray *arrallmanuf = [manfacClsObj getManufactureName];
                [arrallmanuf addObject:[arrItem valueForKey:@"manufacturer"]];
                [manfacClsObj setManufactureName:arrallmanuf];
                
                    NSArray *array = [self.navigationController viewControllers];
                    [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
            }
        }
    }
    
     [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}


#pragma mark -
#pragma mark UIImagePickerController delegate method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [self dismissViewControllerAnimated: YES completion: nil];
    UIImage *image = [info valueForKey: UIImagePickerControllerOriginalImage];
    itemImage.image = image;
    
    UIImage *rotateImg = [appDataObj fixrotation:image];
    NSData *imageData = UIImageJPEGRepresentation(rotateImg, 0.1);
    
    strPicEncoded = [Base64 encode:imageData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated: YES completion: nil];
}

@end
