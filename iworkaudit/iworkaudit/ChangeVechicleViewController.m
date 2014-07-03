//
//  ChangeVechicleViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 16/06/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "ChangeVechicleViewController.h"
#import "AppData.h"
#import "ResultItems.h"
#import "UsersClass.h"
#import "HexColorToUIColor.h"
#import "WebServiceHelper.h"
#import "SVProgressHUD.h"
#import "JSON.h"
#import "SitesClass.h"

@interface ChangeVechicleViewController ()<WebServiceHelperDelegate>{
    NSMutableArray *pickerArray,*pickerIDArray;
    NSString *seluserID;
    ResultItems *resltItemObj;
    UsersClass *usersClsObj;
    AppData *appDataObj;
}

@end

@implementation ChangeVechicleViewController
@synthesize vechicle;

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
    
    [productNamelbl setTextColor:[hexColor colorFromHexString:@"#555555" alpha:1.0]];
    [productCodelbl setTextColor:[hexColor colorFromHexString:@"#8a8989" alpha:1.0]];
    [productQRlbl setTextColor:[hexColor colorFromHexString:@"#8a8989" alpha:1.0]];
    
    [productNamelbl setFont:[UIFont fontWithName:CORBEL_FONT_BOLD size:13.0f]];
    [productCodelbl setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];
    [productQRlbl setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];
    
    profilePic.layer.borderColor = [[hexColor colorFromHexString:FONT_COLOR alpha:1.0] CGColor];
    profilePic.layer.borderWidth = 1.0f;
    
   // NSLog(@"IMG - %@",[NSString stringWithFormat:@"%@%@",appDataObj.apiURL_IMAGE,[item itemphotopathText]]);
    
//    if ([[vechicle itemphotopathText] length] != 0) {
//        profilePic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",appDataObj.apiURL_IMAGE,[item itemphotopathText]]]]];
//    }
    
   // productNamelbl.text = [NSString stringWithFormat:@"%@ %@",[item nam],[item modelText]] ;
   // productCodelbl.text = [item categorynameText];
   // productQRlbl.text = [item barcodeText];
    
    
    pickerIDArray = [NSMutableArray array];
    pickerArray = [NSMutableArray array];
    
    usersClsObj = [UsersClass sharedInstance];
    
    pickerArray = usersClsObj.getUsersName;
    pickerIDArray = usersClsObj.getUsersID;
}

-(IBAction)backToDeshboardView:(id)sender{
    NSArray *array = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
}

-(IBAction)backToPrevView:(id)sender{
    [[self navigationController] popViewControllerAnimated:YES];
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
    seluserID = [pickerIDArray objectAtIndex:row] ;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}

-(IBAction)ChangeOwnershipLocation:(id)sender
{
   
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
        
        [obj setMethodName:[NSString stringWithFormat:@"vehicleownership/%@",[vechicle fleetidText]]];
        [obj setMethodResult:@""];
        [obj setMethodType:@"POST"];
        [obj setCurrentCall:@"vehicleownership"];
        
        [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
        [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
        [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
        [obj.MethodParameters setObject:@"submit" forKey:@"mode"];
        
        [obj.MethodParameters setObject:seluserID forKey:@"user_id"];
        [obj.MethodParameters setObject:@"-1" forKey:@"location_id"];
        [obj.MethodParameters setObject:@"-1" forKey:@"site_id"];
        
        [obj initiateConnection];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [SVProgressHUD dismiss];
        [SVProgressHUD show];
    }
    
    
}

#pragma mark -
#pragma mark WebServiceHelper delegate method
-(void)WebServiceHelper:(WebServiceHelper *)editor didFinishWithResult:(BOOL)result{
    [SVProgressHUD dismiss];
	if (result)
	{
        if ([[editor currentCall] isEqualToString:@"vehicleownership"])
        {
            NSLog(@"result -- %@",[[editor ReturnStr] JSONValue]);
            if ([appDataObj.deshboardNavType isEqualToString:@"vechicleownership"]) {
                [[[UIAlertView alloc] initWithTitle:@"Success !" message:@"Ownership has been changed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                NSArray *array = [self.navigationController viewControllers];
                [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
               

            }
        }
    }
    //[[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
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
