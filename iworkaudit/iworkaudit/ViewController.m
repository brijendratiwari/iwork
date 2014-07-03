//
//  ViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 29/04/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSData+CommonDigest.h"
#import "WebServiceHelper.h"
#import "SVProgressHUD.h"
#import "AppData.h"
#import "JSON.h"
#import "HexColorToUIColor.h"

@interface ViewController (){
    AppData *appDataObj;
    NSMutableArray *pickerArray;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self CurrentLocationIdentifier];
    
    appDataObj = [AppData sharedInstance];
    pickerArray = [[NSMutableArray alloc] initWithObjects:@"U K",@"Australia", nil];
    
     [remberBtn setSelected:YES];
    
    // hide nav bar
    [[self navigationController] setNavigationBarHidden:TRUE];
    [self getUsernameAndPassword];
    
    HexColorToUIColor *hexColor = [[HexColorToUIColor alloc] init];
    
    //set clerbtn and remember btn border
    cleardataBtn.layer.cornerRadius=(IS_IPAD ? 8:4);
    cleardataBtn.layer.borderWidth=(IS_IPAD ? 2:1);
    cleardataBtn.layer.borderColor=[[UIColor whiteColor] CGColor];
    remberBtn.layer.cornerRadius=(IS_IPAD ? 5:3);
    remberBtn.layer.borderWidth=(IS_IPAD ? 2:1);
    remberBtn.layer.borderColor=[[UIColor whiteColor] CGColor];
    
    [remindmelbl setFont:[UIFont fontWithName:CORBEL_FONT size:14.0f]];
    [needacclbl.titleLabel setFont:[UIFont fontWithName:CORBEL_FONT size:14.0f]];
    //[usernametxt setFont:[UIFont fontWithName:CORBEL_FONT size:14.0f]];
    //[passwordtxt setFont:[UIFont fontWithName:CORBEL_FONT size:14.0f]];
    //[countrytxt setFont:[UIFont fontWithName:CORBEL_FONT size:14.0f]];
    
    [remindmelbl setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    [needacclbl setTitleColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0] forState:UIControlStateNormal];
    //[usernametxt setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    //[passwordtxt setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    //[countrytxt setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];

    usernametxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"USER NAME" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:FONT_COLOR alpha:1.0f]}];
    
    passwordtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"PASSWORD" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:FONT_COLOR alpha:1.0f]}];
    
    countrytxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"COUNTRY" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:FONT_COLOR alpha:1.0f]}];
    
    countrytxt.text = @"U K";
    [appDataObj setAPIdetails:@"U K"];
    countrytxt.inputView = dataPicker;
    dataPicker.hidden = YES;
}

-(void)CurrentLocationIdentifier
{
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSLog(@"placemark %@",placemark);
             NSString *Country = [[NSString alloc]initWithString:placemark.country];
             NSLog(@"%@",Country);
             
             if ([Country isEqualToString:@"Australia"]) {
                 countrytxt.text = @"Australia";
                 [appDataObj setAPIdetails:@"Australia"];
             }else{
                 countrytxt.text = @"U K";
                 [appDataObj setAPIdetails:@"U K"];
             }
         }
         else
         {
             NSLog(@"Geocode failed with error %@", error);
         }
         /*---- For more results
          placemark.region);
          placemark.country);
          placemark.locality);
          placemark.name);
          placemark.ocean);
          placemark.postalCode);
          placemark.subLocality);
          placemark.location);
          ------*/
     }];
}

#pragma mark - Text field delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ([textField isEqual:countrytxt]) {
         dataPicker.hidden = NO;
        [dataPicker reloadAllComponents];
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
    [countrytxt setText:[pickerArray objectAtIndex:row]];
    
    if ([countrytxt.text isEqualToString:@"Australia"]) {
        [appDataObj setAPIdetails:@"Australia"];
    }else{
        [appDataObj setAPIdetails:@"U K"];
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

-(void)setUsernameAndPassword{
    keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"com.iworkauditapp.codedroid" accessGroup:nil];
    [keychain setObject:usernametxt.text forKey:(__bridge id)(kSecAttrAccount)];
    [keychain setObject:passwordtxt.text forKey:(__bridge id)(kSecValueData)];
}

-(void)getUsernameAndPassword{
    keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"com.iworkauditapp.codedroid" accessGroup:nil];
    NSString *usernameStr = [keychain objectForKey:(__bridge id)(kSecAttrAccount)];
    NSString *pwdStr = [keychain objectForKey:(__bridge id)(kSecValueData)];

     [remberBtn setSelected:NO];
     isRemberSelcted = NO;
    if ([[USER_DEFULTS valueForKey:@"isRemember"] isEqualToString:@"YES"]) {
        [remberBtn setSelected:YES];
        isRemberSelcted = YES;
        
        if (usernameStr != nil) {
            usernametxt.text = usernameStr;
        }
        if (pwdStr != nil) {
            passwordtxt.text = pwdStr;
        }
    }
}

-(void)checkValidationAndLogin{
    
    //login sucess and push view controller to dashboard
    UIViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"]; ///DashboardViewController
   // [[self navigationController] pushViewController:pushContoller animated:YES];
    
   // return ;
    
    NSString *errormsg = @"";
    if (usernametxt.text.length == 0) {
        errormsg = @"Please Enter username.\n";
    }
    if (passwordtxt.text.length == 0) {
        errormsg = [errormsg stringByAppendingString:@"Please Enter password."];
    }
    if (![errormsg isEqualToString:@""]) {
        UIAlertView *erralert = [[UIAlertView alloc] initWithTitle:@"Login Error" message:errormsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [erralert show];
        return ;
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
        
        [obj setMethodName:@"login"];
        [obj setMethodResult:@""];
        [obj setMethodType:@"POST"];
        [obj setCurrentCall:@"Login"];
        
        [obj.MethodParameters setObject:usernametxt.text forKey:@"username"];
        [obj.MethodParameters setObject:[self md5HexDigest:[passwordtxt text]] forKey:@"password"];
        [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
      
        [obj initiateConnection];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [SVProgressHUD dismiss];
        [SVProgressHUD show];
    }
}

- (NSString*)md5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

#pragma Mark
#pragma Button Actions

-(IBAction)PressButtons:(UIButton *)sender{
    switch (sender.tag) {
        case 100:
            NSLog(@"login");
            [self checkValidationAndLogin];
            break;
        case 200:
            NSLog(@"clear");
            [keychain resetKeychainItem];
            isRemberSelcted = NO;
            [USER_DEFULTS setObject:@"NO" forKey:@"isRemember"];
            [USER_DEFULTS synchronize];
            [remberBtn setSelected:NO];
             usernametxt.text = @"";
             passwordtxt.text = @"";
            break;
        case 300:
            NSLog(@"new account");
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.iworkaudit.com"]];
            break;
        case 400:
            NSLog(@"remember me");
            if (isRemberSelcted) {
                isRemberSelcted = NO;
                [USER_DEFULTS setObject:@"NO" forKey:@"isRemember"];
                [remberBtn setSelected:NO];
                [keychain resetKeychainItem];
            }else{
                isRemberSelcted = YES;
                [USER_DEFULTS setObject:@"YES" forKey:@"isRemember"];
                [remberBtn setSelected:YES];
                [self setUsernameAndPassword];
            }
            [USER_DEFULTS synchronize];
        break;
        default:
            break;
    }
}

#pragma Mark
#pragma UITextField Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isEqual:usernametxt]) {
        [passwordtxt becomeFirstResponder];
    }else if ([textField isEqual:passwordtxt]) {
        [passwordtxt resignFirstResponder];
    }
    return YES;
}

#pragma mark -
#pragma mark WebServiceHelper delegate method
-(void)WebServiceHelper:(WebServiceHelper *)editor didFinishWithResult:(BOOL)result
{
    [SVProgressHUD dismiss];
	if (result)
	{
        if ([[editor currentCall] isEqualToString:@"Login"])
        {
			NSDictionary *results1=[[editor ReturnStr] JSONValue];
            NSLog(@"result %@ %@", [[editor ReturnStr] JSONValue],[results1 objectForKey:@"booError"]);
            if ([[results1 objectForKey:@"booError"] integerValue] == 1) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login error !" message:[results1 objectForKey:@"strError"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }else{
               
                //[self setUsernameAndPassword];
                
                appDataObj.nickname = [[results1 valueForKey:@"arrUser"] valueForKey:@"nickname"];
                appDataObj.password = [[results1 valueForKey:@"arrUser"] valueForKey:@"password"];
                appDataObj.accountname = [[results1 valueForKey:@"arrUser"] valueForKey:@"accountname"];
                appDataObj.levelname = [[results1 valueForKey:@"arrUser"] valueForKey:@"levelname"];
                appDataObj.username = [[results1 valueForKey:@"arrUser"] valueForKey:@"username"];
                appDataObj.photopath = [[results1 valueForKey:@"arrUser"] valueForKey:@"photopath"];
                appDataObj.userID = [[results1 valueForKey:@"arrUser"] valueForKey:@"userid"];
                
                //login sucess and push view controller to dashboard
                 UIViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
                  [[self navigationController] pushViewController:pushContoller animated:YES];
            }
        }
    }
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

@end
