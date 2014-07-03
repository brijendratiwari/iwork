//
//  ManualSearchViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 30/04/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "ManualSearchViewController.h"
#import "ManufactureClass.h"
#import "UsersClass.h"
#import "LocationClass.h"
#import "CategoriesClass.h"
#import "SitesClass.h"
#import "AppData.h"
#import "WebServiceHelper.h"
#import "SVProgressHUD.h"
#import "JSON.h"
#import "SearchResultViewController.h"
#import "ResultItems.h"
#import "HexColorToUIColor.h"

@interface ManualSearchViewController ()<WebServiceHelperDelegate>{
    NSMutableArray *pickerArray,*pickerIDArray;
    ManufactureClass *manfacClsObj;
    CategoriesClass *catgryClsObj;
    LocationClass *locClsObj;
    UsersClass *usersClsObj;
    SitesClass *sitesClsObj;
    NSString *textType;
    UITextField *txtTypefld;
    AppData *appDataObj;
    
    NSString *selSiteID,*selcatgryID,*sellocID,*seluserID;
}

@end

@implementation ManualSearchViewController

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
    
    HexColorToUIColor *hexColor = [[HexColorToUIColor alloc] init];
    
    freeSerachtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Free Text Search ?" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [freeSerachtxt setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    qrCodetxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"QR Code" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [qrCodetxt setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    manfactxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Manufacturer" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [manfactxt setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    sitestxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Site" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [sitestxt setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    usertxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select User" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [usertxt setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    locationtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Location" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [locationtxt setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    catagrytxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Category" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [catagrytxt setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            textField.layer.borderWidth = 1.0f;
            [textField setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 30.0f:15.0f)]];
        }
    }
    
    appDataObj = [AppData sharedInstance];
    
    manfacClsObj = [ManufactureClass sharedInstance];
    catgryClsObj = [CategoriesClass sharedInstance];
    usersClsObj = [UsersClass sharedInstance];
    locClsObj = [LocationClass sharedInstance];
    sitesClsObj = [SitesClass sharedInstance];
    
    manfactxt.inputView = dataPicker;
    usertxt.inputView = dataPicker;
    locationtxt.inputView = dataPicker;
    catagrytxt.inputView = dataPicker;
    sitestxt.inputView = dataPicker;
    
    dataPicker.hidden = YES;
    
  //  if ([appDataObj.deshboardNavType isEqualToString:@"auditloc"]  || [appDataObj.deshboardNavType isEqualToString:@"editloc"] || [appDataObj.deshboardNavType isEqualToString:@"searchloc"]){
    
    if ([appDataObj.deshboardNavType isEqualToString:@"auditloc"] || [appDataObj.deshboardNavType isEqualToString:@"searchloc"]){
        manfactxt.hidden=YES;
        sitestxt.hidden=YES;
        usertxt.hidden=YES;
        locationtxt.hidden=NO;
        catagrytxt.hidden=YES;
        
        CGRect frame=locationtxt.frame;
        if([appDataObj.deshboardNavType isEqualToString:@"searchloc"])
        {
            freeSerachtxt.hidden=YES;
            qrCodetxt.hidden=YES;
            frame.origin.y=frame.origin.y-200;
        }
        else
        {
            frame.origin.y=frame.origin.y-120;
        }
        locationtxt.frame=frame;
    }
    
    // [[IQKeyboardManager sharedManager] setEnable:YES];
    //[dataPicker addSubview:toolbar];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // [[IQKeyboardManager sharedManager] setShouldToolbarUsesTextFieldTintColor:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[[IQKeyboardManager sharedManager] setShouldToolbarUsesTextFieldTintColor:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backToPrevView:(id)sender{
    [[self navigationController] popViewControllerAnimated:YES];
}

-(void)searchLocationByID{
    
    if (sellocID.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please select location." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show]; return ;
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
        
        [obj setMethodName:[NSString stringWithFormat:@"locationbyid/%@",sellocID]];
        [obj setMethodResult:@""];
        [obj setMethodType:@"POST"];
        [obj setCurrentCall:@"locationbyid"];
        
        [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
        [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
        [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
        
        [obj initiateConnection];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [SVProgressHUD dismiss];
        [SVProgressHUD show];
    }
    
}

-(IBAction)searchButtonClick:(id)sender{
    
    if ([appDataObj.deshboardNavType isEqualToString:@"editloc"] || [appDataObj.deshboardNavType isEqualToString:@"searchloc"]) {
        if (sellocID.length == 0) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please select location." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show]; return ;
        }else{
            [self searchLocationByID];
        }
    }else{
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
            
            [obj setMethodName:@"itemlookup"];
            [obj setMethodResult:@""];
            [obj setMethodType:@"POST"];
            [obj setCurrentCall:@"itemLookUp"];
            
            if (seluserID.length == 0) {
                seluserID = @"-1";
            }
            if (selSiteID.length == 0) {
                selSiteID = @"-1";
            }
            if (sellocID.length == 0) {
                sellocID = @"-1";
            }
            if (selcatgryID.length == 0) {
                selcatgryID = @"-1";
            }
            NSString *qrCodeStr = @"-1";
            if (qrCodetxt.text.length != 0) {
                qrCodeStr = qrCodetxt.text;
            }
            
            NSString *freetextStr = @"-1";
            if (freeSerachtxt.text.length != 0) {
                freetextStr = freeSerachtxt.text;
            }
            
            [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
            [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
            [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
            [obj.MethodParameters setObject:@"search" forKey:@"mode"];
            [obj.MethodParameters setObject:seluserID forKey:@"user_id"];
            [obj.MethodParameters setObject:selSiteID forKey:@"site_id"];
            [obj.MethodParameters setObject:sellocID forKey:@"location_id"];
            [obj.MethodParameters setObject:selcatgryID forKey:@"category_id"];
            [obj.MethodParameters setObject:qrCodeStr forKey:@"barcode_id"];
            [obj.MethodParameters setObject:freetextStr forKey:@"freetext"];
            
            if (manfactxt.text.length == 0) {
                [obj.MethodParameters setObject:@"-1" forKey:@"manufacturer"];
            }else{
                [obj.MethodParameters setObject:manfactxt.text forKey:@"manufacturer"];
            }
            
            [obj initiateConnection];
            
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            [SVProgressHUD dismiss];
            [SVProgressHUD show];
        }
    }
}

#pragma mark - Text field delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    pickerArray = [NSMutableArray array];
    pickerIDArray = [NSMutableArray array];
    textType = @"";
    if ([textField isEqual:manfactxt]) {
        if (manfacClsObj.getManufactureName) {
            textType = @"manufacture";
            txtTypefld = manfactxt;
            pickerArray = manfacClsObj.getManufactureName;
        }
    }
    if ([textField isEqual:usertxt]) {
        if (usersClsObj.getUsersName) {
            textType = @"user";
            txtTypefld = usertxt;
            pickerArray = usersClsObj.getUsersName;
            pickerIDArray = usersClsObj.getUsersID;
        }
    }
    if ([textField isEqual:locationtxt]) {
        if (locClsObj.getLocationName) {
            textType = @"location";
            txtTypefld = locationtxt;
            pickerArray = locClsObj.getLocationName;
            pickerIDArray = locClsObj.getLocationID;
        }
    }
    if ([textField isEqual:catagrytxt]) {
        if (catgryClsObj.getCategoriesName) {
            txtTypefld = catagrytxt;
            pickerArray = catgryClsObj.getCategoriesName;
            pickerIDArray = catgryClsObj.getCategoriesID;
        }
    }
    if ([textField isEqual:sitestxt]) {
        if (sitesClsObj.getSitesName) {
            txtTypefld = sitestxt;
            pickerArray = sitesClsObj.getSitesName;
            pickerIDArray = sitesClsObj.getSitesID;
        }
    }
    
    dataPicker.hidden = NO;
    [dataPicker reloadAllComponents];
    [dataPicker selectRow:0 inComponent:0 animated:YES];
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
    
    if ([txtTypefld isEqual:manfactxt]) {
        [manfactxt setText:[pickerArray objectAtIndex:row]];
    }
    if ([txtTypefld isEqual:usertxt]) {
        [usertxt setText:[pickerArray objectAtIndex:row]];
        seluserID = [pickerIDArray objectAtIndex:row];
    }
    if ([txtTypefld isEqual:locationtxt]) {
        [locationtxt setText:[pickerArray objectAtIndex:row]];
        sellocID = [pickerIDArray objectAtIndex:row];
    }
    if ([txtTypefld isEqual:sitestxt]) {
        [sitestxt setText:[pickerArray objectAtIndex:row]];
        selSiteID = [pickerIDArray objectAtIndex:row];
    }
    if ([txtTypefld isEqual:catagrytxt]) {
        [catagrytxt setText:[pickerArray objectAtIndex:row]];
        selcatgryID = [pickerIDArray objectAtIndex:row];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}

#pragma mark -
#pragma mark WebServiceHelper delegate method
-(void)WebServiceHelper:(WebServiceHelper *)editor didFinishWithResult:(BOOL)result
{
    [SVProgressHUD dismiss];
	if (result)
	{
        NSMutableDictionary *resultDic = [[editor ReturnStr] JSONValue];
        
        if ([[editor currentCall] isEqualToString:@"itemLookUp"])
        {
            NSLog(@"result -- %@ %lu",[[editor ReturnStr] JSONValue],(unsigned long)[[[editor ReturnStr] JSONValue] count]);
            
            if ([[resultDic objectForKey:@"arrResults"] count] != 0) {
                
                [[ResultItems sharedInstance] setAllItemsInArray:[resultDic objectForKey:@"arrResults"]];
                
                NSString *controllerIdentifier=@"SearchResultViewController";
                if([[appDataObj deshboardNavType] isEqualToString:@"auditloc"]){
                    controllerIdentifier=@"AuditLocationListViewController";
                }
                
                UIViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:controllerIdentifier];
                [[self navigationController] pushViewController:pushContoller animated:YES];
                
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert !" message:@"No search result found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else if ([[editor currentCall] isEqualToString:@"locationbyid"])
        {
            NSLog(@"result -- %@ %lu",[[editor ReturnStr] JSONValue],(unsigned long)[[[editor ReturnStr] JSONValue] count]);
            
            [[ResultItems sharedInstance] setAllItemsInArray:[[resultDic objectForKey:@"arrLocation"] objectForKey:@"arrItems"]];
            
            if ([[[resultDic objectForKey:@"arrLocation"] objectForKey:@"arrItems"] count] != 0) {
                SearchResultViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResultViewController"];
                [[self navigationController] pushViewController:pushContoller animated:YES];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert !" message:@"No search result found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
    
    manfactxt.text = @"";
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
