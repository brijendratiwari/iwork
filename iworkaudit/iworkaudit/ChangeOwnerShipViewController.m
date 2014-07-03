//
//  ChangeOwnerShipViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 07/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "ChangeOwnerShipViewController.h"
#import "AppData.h"
#import "ResultItems.h"
#import "UsersClass.h"
#import "LocationClass.h"
#import "HexColorToUIColor.h"
#import "WebServiceHelper.h"
#import "SVProgressHUD.h"
#import "JSON.h"
#import "LocationClass.h"
#import "SitesClass.h"
#import "UIImageView+WebCache.h"

@interface ChangeOwnerShipViewController () <WebServiceHelperDelegate>{
     NSMutableArray *pickerArray,*pickerIDArray;
    NSString *seluserID;
    ResultItems *resltItemObj;
     UsersClass *usersClsObj;
    LocationClass *locationClsObj;
    AppData *appDataObj;
    SitesClass *sitesClsObj;
    UITextField *txtTypefld;
    NSString *selSiteID,*sellocID;
}

@end

@implementation ChangeOwnerShipViewController
@synthesize item;

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
    appDataObj=[AppData sharedInstance];
    
    
   /* [productNamelbl setTextColor:[hexColor colorFromHexString:@"#555555" alpha:1.0]];
    [productCodelbl setTextColor:[hexColor colorFromHexString:@"#8a8989" alpha:1.0]];
    [productQRlbl setTextColor:[hexColor colorFromHexString:@"#8a8989" alpha:1.0]];
    
    [productNamelbl setFont:[UIFont fontWithName:CORBEL_FONT_BOLD size:13.0f]];
    [productCodelbl setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];
    [productQRlbl setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];*/
    
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
    
    
    productNamelbl.text = [NSString stringWithFormat:@"%@ %@",[item manufacturerText],[item modelText]] ;
    productCodelbl.text = [item categorynameText];
    productQRlbl.text = [item barcodeText];
    
    
    pickerIDArray = [NSMutableArray array];
    pickerArray = [NSMutableArray array];
    
    usersClsObj = [UsersClass sharedInstance];
    
    pickerArray = usersClsObj.getUsersName;
    pickerIDArray = usersClsObj.getUsersID;
    
    if (![appDataObj.deshboardNavType isEqualToString:@"ownership"]){
    // edit loc
      
        //[tittleimgV setImage:[UIImage imageNamed:@"change_location_title.png"]];
        [submitBtn setImage:[UIImage imageNamed:@"change_location.png"] forState:UIControlStateNormal];
        
        //sitestxt.hidden = NO;
        //locationtxt.hidden = NO;
        //dataPicker.hidden = YES;
        tittleimgV.hidden = YES;
        userlbl.hidden = YES;
        usertxt.hidden = YES;
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
    
    if ([[item locationnameText] length] > 0) {
        locationtxt.text = [NSString stringWithFormat:@"%@",[item locationnameText]];
    }
    
    if ([[item sitenameText] length] > 0) {
        sitestxt.text = [NSString stringWithFormat:@"%@",[item sitenameText]];
    }
    
    if ([[item usernicknameText] length] > 0) {
        usertxt.text = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@ %@",[item userfirstnameText],[item userlastnameText]]];
    }
    

    //[usertxt setFont:[UIFont fontWithName:@"#4C4C4C" size:12.0f]];
    usertxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"SELECT USER" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [usertxt setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    //[sitestxt setFont:[UIFont fontWithName:@"#4C4C4C" size:12.0f]];
    sitestxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"SELECT SITE" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [sitestxt setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
   // [locationtxt setFont:[UIFont fontWithName:@"#4C4C4C" size:12.0f]];
    locationtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"SELECT LOCATION" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [locationtxt setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    locationClsObj = [LocationClass sharedInstance];
    sitesClsObj = [SitesClass sharedInstance];
    
    locationtxt.inputView = edit_dataPicker;
    sitestxt.inputView = edit_dataPicker;
    usertxt.inputView = edit_dataPicker;
    
    edit_dataPicker.hidden = YES;
    
}

-(IBAction)backToDeshboardView:(id)sender{
    NSArray *array = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
}

-(IBAction)backToPrevView:(id)sender{
    [[self navigationController] popViewControllerAnimated:YES];
}
-(IBAction)pressDropDownImage:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    
//    pickerArray = [NSMutableArray array];
//    pickerIDArray = [NSMutableArray array];

    switch (btn.tag) {
        case 100:
//            if (locationClsObj.getLocationName) {
//                txtTypefld = locationtxt;
//                pickerArray = locationClsObj.getLocationName;
//                pickerIDArray = locationClsObj.getLocationID;
//            }
            [locationtxt becomeFirstResponder];
            break;
        case 200:
//            if (sitesClsObj.getSitesName) {
//                txtTypefld = sitestxt;
//                pickerArray = sitesClsObj.getSitesName;
//                pickerIDArray = sitesClsObj.getSitesID;
//            }
            [sitestxt becomeFirstResponder];
            break;
        case 300:
//            if (usersClsObj.getUsersName) {
//                txtTypefld = usertxt;
//                pickerArray = usersClsObj.getUsersName;
//                pickerIDArray = usersClsObj.getUsersID;
//            }
            [usertxt becomeFirstResponder];
            break;
            
        default:
            break;
    }
    
//    edit_dataPicker.hidden = NO;
//    [edit_dataPicker reloadAllComponents];
//    [edit_dataPicker selectRow:0 inComponent:0 animated:YES];
}
#pragma mark - Text field delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField{

    pickerArray = [NSMutableArray array];
    pickerIDArray = [NSMutableArray array];
    
    if ([textField isEqual:locationtxt]) {
        if (locationClsObj.getLocationName) {
            txtTypefld = locationtxt;
            pickerArray = locationClsObj.getLocationName;
            pickerIDArray = locationClsObj.getLocationID;
        }
    }
    if ([textField isEqual:sitestxt]) {
        if (sitesClsObj.getSitesName) {
            txtTypefld = sitestxt;
            pickerArray = sitesClsObj.getSitesName;
            pickerIDArray = sitesClsObj.getSitesID;
        }
    }
    
    if ([textField isEqual:usertxt]) {
        if (usersClsObj.getUsersName) {
            txtTypefld = usertxt;
            pickerArray = usersClsObj.getUsersName;
            pickerIDArray = usersClsObj.getUsersID;
        }
    }
    
    
    
    edit_dataPicker.hidden = NO;
    [edit_dataPicker reloadAllComponents];
    [edit_dataPicker selectRow:0 inComponent:0 animated:YES];
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
    
    
    if ([txtTypefld isEqual:locationtxt]) {
        [locationtxt setText:[pickerArray objectAtIndex:row]];
        sellocID = [pickerIDArray objectAtIndex:row];
    }
    if ([txtTypefld isEqual:sitestxt]) {
        [sitestxt setText:[pickerArray objectAtIndex:row]];
        selSiteID = [pickerIDArray objectAtIndex:row];
    }
    
    if ([txtTypefld isEqual:usertxt]) {
        [usertxt setText:[pickerArray objectAtIndex:row]];
        seluserID = [pickerIDArray objectAtIndex:row] ;
    }
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)ChangeOwnershipLocation:(id)sender
{
    
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
        
        [obj setMethodName:[NSString stringWithFormat:@"itemownership/%@",[item itemidText]]];
        [obj setMethodResult:@""];
        [obj setMethodType:@"POST"];
        [obj setCurrentCall:@"itemownership"];
        
        [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
        [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
        [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
        [obj.MethodParameters setObject:@"submit" forKey:@"mode"];
       
        if([appDataObj.deshboardNavType isEqualToString:@"ownership"])
        {
            [obj.MethodParameters setObject:seluserID forKey:@"user_id"];
            [obj.MethodParameters setObject:@"-1" forKey:@"location_id"];
            [obj.MethodParameters setObject:@"-1" forKey:@"site_id"];
        }
        else
        {
            [obj.MethodParameters setObject:@"-1" forKey:@"user_id"];
            [obj.MethodParameters setObject:sellocID forKey:@"location_id"];
            [obj.MethodParameters setObject:selSiteID forKey:@"site_id"];
        }
        
        [obj initiateConnection];
    }
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [SVProgressHUD dismiss];
    [SVProgressHUD show];
}

#pragma mark -
#pragma mark WebServiceHelper delegate method
-(void)WebServiceHelper:(WebServiceHelper *)editor didFinishWithResult:(BOOL)result{
    [SVProgressHUD dismiss];
	if (result)
	{
        if ([[editor currentCall] isEqualToString:@"itemownership"])
        {
            NSLog(@"result -- %@",[[editor ReturnStr] JSONValue]);
            if ([appDataObj.deshboardNavType isEqualToString:@"ownership"]) {
                [[[UIAlertView alloc] initWithTitle:@"Success !" message:@"Ownership has been changed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            }else {
                [[[UIAlertView alloc] initWithTitle:@"Success !" message:@"Location has been changed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            }
            
            NSArray *array = [self.navigationController viewControllers];
            [self.navigationController popToViewController:[array objectAtIndex:2] animated:YES];
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
