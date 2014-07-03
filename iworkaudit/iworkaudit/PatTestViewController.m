//
//  PatTestViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 17/06/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "PatTestViewController.h"
#import "HexColorToUIColor.h"
#import "AppData.h"
#import "WebServiceHelper.h"
#import "JSON.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"

@interface PatTestViewController ()<WebServiceHelperDelegate>{
    HexColorToUIColor *hexColor ;
    AppData *appDataObj;
    
    NSMutableArray *pickerArray,*pickerIDArray;

    UITextField *txtTypefld;
    NSString *selstatusID;
}

@end

@implementation PatTestViewController
@synthesize item;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)backToPrevView:(id)sender{
    [[self navigationController] popViewControllerAnimated:YES];
}

-(IBAction)submitPAT:(id)sender{
    //[[self navigationController] popViewControllerAnimated:YES];
    
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
        
        [obj setMethodName:[NSString stringWithFormat:@"itempat/%@",[item barcodeText]]];
        [obj setMethodResult:@""];
        [obj setMethodType:@"POST"];
        [obj setCurrentCall:@"itempat"];
        
        [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
        [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
        [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
        [obj.MethodParameters setObject:@"submit" forKey:@"mode"];
        
        [obj.MethodParameters setObject:newDatetf.text forKey:@"pattest_date"];
        [obj.MethodParameters setObject:selstatusID forKey:@"pattest_status"];
        //[obj.MethodParameters setObject:@"-1" forKey:@"site_id"];
        
        [obj initiateConnection];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [SVProgressHUD dismiss];
        [SVProgressHUD show];
    }
    
}

-(IBAction)backToDeshboardView:(id)sender{
    NSArray *array = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    hexColor = [[HexColorToUIColor alloc] init];
    
    appDataObj = [AppData sharedInstance];
    
 /*   [productNamelbl setTextColor:[hexColor colorFromHexString:@"#555555" alpha:1.0]];
    [productCodelbl setTextColor:[hexColor colorFromHexString:@"#8a8989" alpha:1.0]];
    [productNamelbl setFont:[UIFont fontWithName:CORBEL_FONT_BOLD size:18.0f]];
    [productCodelbl setFont:[UIFont fontWithName:CORBEL_FONT size:14.0f]];
    
    [currentDatetf setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    [currentDatetf setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];
    [currentstatustf setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    [currentstatustf setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];
    [newDatetf setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    [newDatetf setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];
    [newstatustf setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    [newstatustf setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];*/
    
    newstatustf.inputView = dataPicker;
    newDatetf.inputView = timedatePicker;
    
    productNamelbl.text = [NSString stringWithFormat:@"%@ %@",[item manufacturerText],[item modelText]] ;
    productCodelbl.text = [item categorynameText];
    currentDatetf.text = [NSString stringWithFormat:@"%@",[item pattest_dateText]];
    currentstatustf.text = [NSString stringWithFormat:@"%@",[item pattest_statusText]];
    
    newDatetf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Pat Date" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    
    newstatustf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Pat Status" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    
    profilePic.layer.borderColor = [[hexColor colorFromHexString:FONT_COLOR alpha:1.0] CGColor];
    profilePic.layer.borderWidth = 1.0f;
    NSLog(@"IMG - %@",[NSString stringWithFormat:@"%@%@",appDataObj.apiURL_IMAGE,[item itemphotopathText]]);
    
    AppData *appData=[AppData sharedInstance];
    [appData setLoaderOnImageView:profilePic];
    if ([[item itemphotopathText] length] != 0) {
//        profilePic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",appDataObj.apiURL_IMAGE,[item itemphotopathText]]]]];
        [profilePic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",appDataObj.apiURL_IMAGE,[item itemphotopathText]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            [appData removeLoader];
        }];
    }
    
    currentDatetf.userInteractionEnabled = false;
    currentstatustf.userInteractionEnabled = false;
    
    selstatusID = @"-1";
    newstatustf.text = @"N/A";
    
    dataPicker.hidden = YES;
    timedatePicker.hidden = YES;
    
}

#pragma mark - Text field delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    pickerArray = [NSMutableArray array];
    pickerIDArray = [NSMutableArray array];
    
    if ([textField isEqual:newstatustf]) {
         txtTypefld = newstatustf;
        
        [pickerArray addObject:@"Unknown"];
        [pickerIDArray addObject:@"-1"];
        
        [pickerArray addObject:@"Pass"];
        [pickerIDArray addObject:@"1"];
        
        [pickerArray addObject:@"Fail"];
        [pickerIDArray addObject:@"0"];
        
        [pickerArray addObject:@"Not Required"];
        [pickerIDArray addObject:@"5"];
       
        dataPicker.hidden = NO;
        [dataPicker reloadAllComponents];
        [dataPicker selectRow:0 inComponent:0 animated:YES];
    }
    if ([textField isEqual:newDatetf]) {
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd/MM/yyyy";
        
        newDatetf.text = [dateFormatter stringFromDate:[NSDate date]];
        
        timedatePicker.hidden = NO;
        txtTypefld = newDatetf;
    }
}

- (IBAction)valueChangeForDatePicker:(id)sender {
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy";
    NSLog(@"%@",[dateFormatter stringFromDate:[timedatePicker date]]);
    
    if ([txtTypefld isEqual:newDatetf]) {
        newDatetf.text = [dateFormatter stringFromDate:[timedatePicker date]];
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
    
    if ([txtTypefld isEqual:newstatustf]) {
        [newstatustf setText:[pickerArray objectAtIndex:row]];
        selstatusID = [pickerIDArray objectAtIndex:row];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}


#pragma mark -
#pragma mark WebServiceHelper delegate method
-(void)WebServiceHelper:(WebServiceHelper *)editor didFinishWithResult:(BOOL)result{
    [SVProgressHUD dismiss];
	if (result)
	{
        if ([[editor currentCall] isEqualToString:@"itempat"])
        {
            NSLog(@"result -- %@",[[editor ReturnStr] JSONValue]);
            [[[UIAlertView alloc] initWithTitle:@"Success !" message:@"PAT Test Updated" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            NSArray *array = [self.navigationController viewControllers];
            [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];

        }
    }
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
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
