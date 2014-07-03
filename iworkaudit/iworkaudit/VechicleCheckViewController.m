//
//  VechicleCheckViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 09/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "VechicleCheckViewController.h"
#import "MakeClass.h"
#import "UsersClass.h"
#import "LocationClass.h"
#import "SitesClass.h"
#import "AppData.h"
#import "WebServiceHelper.h"
#import "SVProgressHUD.h"
#import "JSON.h"
#import "SearchResultViewController.h"
#import "VehicleResults.h"
#import "HexColorToUIColor.h"

@interface VechicleCheckViewController ()<WebServiceHelperDelegate>{
    NSMutableArray *pickerArray,*pickerIDArray;
    MakeClass *makeClsObj;
    LocationClass *locClsObj;
    UsersClass *usersClsObj;
    SitesClass *sitesClsObj;
    UITextField *txtTypefld;
    AppData *appDataObj;
    NSString *selSiteID,*sellocID,*seluserID;
}

@end

@implementation VechicleCheckViewController

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
    
     appDataObj = [AppData sharedInstance];
    
    NSString *strReg = @"Registration Number";
    if ([appDataObj.countryName isEqualToString:@"au"]) {
        strReg = @"Plate Number";
    }
    
    //[regNumbertxt setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    regNumbertxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:strReg attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [regNumbertxt setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
   // [maketxt setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    maketxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Make" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [maketxt setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
   // [sitestxt setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    sitestxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Site" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [sitestxt setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    //[usertxt setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    usertxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select User" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [usertxt setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
   // [locationtxt setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    locationtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Select Location" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [locationtxt setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    
   
    
    makeClsObj = [MakeClass sharedInstance];
    usersClsObj = [UsersClass sharedInstance];
    locClsObj = [LocationClass sharedInstance];
    sitesClsObj = [SitesClass sharedInstance];
    
    maketxt.inputView = dataPicker;
    usertxt.inputView = dataPicker;
    locationtxt.inputView = dataPicker;
    sitestxt.inputView = dataPicker;
    
    dataPicker.hidden = YES;

}

-(IBAction)backToPrevView:(id)sender{
    [[self navigationController] popViewControllerAnimated:YES];
}

-(IBAction)searchButtonClick:(id)sender{
    
    //    UIViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResultViewController"];
    //    [[self navigationController] pushViewController:pushContoller animated:YES];
    //
    //    return ;
    
    
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
        
        [obj setMethodName:@"vehiclelookup"];
        [obj setMethodResult:@""];
        [obj setMethodType:@"POST"];
        [obj setCurrentCall:@"vehiclelookup"];
        
        if (seluserID.length == 0) {
            seluserID = @"-1";
        }
        if (selSiteID.length == 0) {
            selSiteID = @"-1";
        }
        if (sellocID.length == 0) {
            sellocID = @"-1";
        }
        
        [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
        [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
        [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
        [obj.MethodParameters setObject:@"search" forKey:@"mode"];
        [obj.MethodParameters setObject:seluserID forKey:@"user_id"];
        [obj.MethodParameters setObject:selSiteID forKey:@"site_id"];
        [obj.MethodParameters setObject:sellocID forKey:@"location_id"];
        
        if (maketxt.text.length == 0) {
            [obj.MethodParameters setObject:@"-1" forKey:@"make"];
        }else{
            [obj.MethodParameters setObject:maketxt.text forKey:@"make"];
        }
        
        [obj initiateConnection];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [SVProgressHUD dismiss];
        [SVProgressHUD show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Text field delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    pickerArray = [NSMutableArray array];
    pickerIDArray = [NSMutableArray array];

    if ([textField isEqual:maketxt]) {
        if (makeClsObj.getMakeName) {
            txtTypefld = maketxt;
            pickerArray = makeClsObj.getMakeName;
        }
    }
    if ([textField isEqual:usertxt]) {
        if (usersClsObj.getUsersName) {
            txtTypefld = usertxt;
            pickerArray = usersClsObj.getUsersName;
            pickerIDArray = usersClsObj.getUsersID;
        }
    }
    if ([textField isEqual:locationtxt]) {
        if (locClsObj.getLocationName) {
            txtTypefld = locationtxt;
            pickerArray = locClsObj.getLocationName;
            pickerIDArray = locClsObj.getLocationID;
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
    
    if ([txtTypefld isEqual:maketxt]) {
        [maketxt setText:[pickerArray objectAtIndex:row]];
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
        if ([[editor currentCall] isEqualToString:@"vehiclelookup"])
        {
            NSLog(@"result -- %@ %lu",[[editor ReturnStr] JSONValue],(unsigned long)[[[editor ReturnStr] JSONValue] count]);
            
            NSMutableDictionary *resultDic = [[editor ReturnStr] JSONValue];
            
            if ([[resultDic objectForKey:@"arrResults"] count] != 0) {
                
                [[VehicleResults sharedInstance] setAllVehicleInArray:[resultDic objectForKey:@"arrResults"]];
                
                UIViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"VechileListViewController"];
                [[self navigationController] pushViewController:pushContoller animated:YES];
                
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert !" message:@"No search result found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
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
