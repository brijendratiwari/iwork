//
//  ReportFaultViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 06/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "ReportFaultViewController.h"
#import "AppData.h"
#import "HexColorToUIColor.h"
#import "WebServiceHelper.h"
#import "SVProgressHUD.h"
#import "JSON.h"
#import "StatusClass.h"
#import "UIImageView+WebCache.h"

@interface ReportFaultViewController ()<WebServiceHelperDelegate>{
    AppData *appDataObj;
    StatusClass *statusClsObj;
    NSMutableArray *pickerArray,*pickerIDArray;
    NSString *selstautsID,*selPriortyID;
    UITextField *txtTypefld;
    
}

@end

@implementation ReportFaultViewController
@synthesize item,vechicle;

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
    [scroller setContentSize:CGSizeMake(320,(IS_IPAD ? 650:325))];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    appDataObj = [AppData sharedInstance];
    statusClsObj = [StatusClass sharedInstance];
    
    HexColorToUIColor *hexColor = [[HexColorToUIColor alloc] init];
    
   /* [productNamelbl setTextColor:[hexColor colorFromHexString:@"#555555" alpha:1.0]];
    [productCodelbl setTextColor:[hexColor colorFromHexString:@"#8a8989" alpha:1.0]];
    [productQRlbl setTextColor:[hexColor colorFromHexString:@"#8a8989" alpha:1.0]];
    
    [productNamelbl setFont:[UIFont fontWithName:CORBEL_FONT_BOLD size:13.0f]];
    [productCodelbl setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];
    [productQRlbl setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];
    
    [noteslbl setFont:[UIFont fontWithName:CORBEL_FONT_BOLD size:12.0f]];
    [noteslbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [ticketDlbl setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];
    [ticketDlbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [selitemStatslbl setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];
    [selitemStatslbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];*/
    
    //[subjectTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    subjectTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Subject" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [subjectTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    //[prioritylbl setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];
    //[prioritylbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    //[priorityTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    
    msgTxtV.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Further Information" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [msgTxtV setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    priorityTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Priority" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [priorityTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    //[selitemStatsTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    selitemStatsTxtF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Item Status" attributes:@{NSForegroundColorAttributeName: [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0f]}];
    [selitemStatsTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    selitemStatsTxtF.inputView = dataPicker;
    priorityTxtF.inputView = dataPicker;
    dataPicker.hidden = YES;
    
    profilePic.layer.borderColor = [[hexColor colorFromHexString:FONT_COLOR alpha:1.0] CGColor];
    profilePic.layer.borderWidth = 1.0f;
    
    if ([appDataObj.deshboardNavType isEqualToString:@"reportvechiclefault"]){
        productCodelbl.hidden = YES;
       // productQRlbl.hidden = YES;
       // profilePic.hidden = YES;
        
        productNamelbl.text = [[vechicle makeText] stringByAppendingString:[NSString stringWithFormat:@" %@",[vechicle modelText]]];
        
        [productQRlbl setText:[vechicle barcodeText]];
        
    }else{
        
        
        AppData *appData=[AppData sharedInstance];
       
        if ([[item itemphotopathText] length] != 0) {

             [appData setLoaderOnImageView:profilePic];
            
            [profilePic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",appDataObj.apiURL_IMAGE,[item itemphotopathText]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                [appData removeLoader];
            }];
        }
        
        productNamelbl.text = [NSString stringWithFormat:@"%@ %@",[item manufacturerText],[item modelText]] ;
        productQRlbl.text = [NSString stringWithFormat:@"QR CODE : %@",[item barcodeText]];
        productCodelbl.text = [NSString stringWithFormat:@"STATUS : %@",[item statusnameText]];
        
    }
    
    if ([appDataObj.deshboardNavType isEqualToString:@"reportvechiclefault"]){
        selitemStatslbl.hidden = YES;
        selitemStatsTxtF.hidden = YES;
        lineslbl.hidden = YES;
    }
}

-(IBAction)doneButtonClick:(id)sender{

    
    if ([msgTxtV.text isEqualToString:@"FURTHER INFORMATION"]) {
        msgTxtV.text = @"";
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
        [obj setMethodType:@"POST"];
        [obj setCurrentCall:@"itemticket"];
        
        [obj setMethodParameters:[[NSMutableDictionary alloc] init]];
        
        if ([appDataObj.deshboardNavType isEqualToString:@"reportvechiclefault"]){
            [obj setMethodName:[NSString stringWithFormat:@"vehicleTicket/%@",[vechicle fleetidText]]];
            [obj.MethodParameters setObject:subjectTxtF.text forKey:@"message_title"];
            
        }else{
            [obj setMethodName:[NSString stringWithFormat:@"itemticket/%@",[item itemidText]]];
             [obj.MethodParameters setObject:subjectTxtF.text forKey:@"ticket_subject"];
            
            if (selitemStatsTxtF.text.length == 0) {
                [obj.MethodParameters setObject:@"-1" forKey:@"item_status"];
            }else{
                [obj.MethodParameters setObject:selstautsID forKey:@"item_status"];
            }
        }
        
        [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
        [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
        [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
        [obj.MethodParameters setObject:@"submit" forKey:@"mode"];
       
        [obj.MethodParameters setObject:msgTxtV.text forKey:@"ticket_message"];
        
     
        if (priorityTxtF.text.length == 0) {
            [obj.MethodParameters setObject:@"-1" forKey:@"ticket_priority"];
        }else{
            [obj.MethodParameters setObject:selPriortyID forKey:@"ticket_priority"];
        }
        
        [obj initiateConnection];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [SVProgressHUD dismiss];
        [SVProgressHUD show];
    }
    
}

-(IBAction)backToPrevView:(id)sender{
    [[self navigationController] popViewControllerAnimated:YES];
}

-(IBAction)backToDeshboardView:(id)sender{
    NSArray *array = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
}

#pragma mark - Text field delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ([textField isEqual:selitemStatsTxtF]) {
        if (statusClsObj.getStatusName) {
            txtTypefld = selitemStatsTxtF;
            pickerArray = statusClsObj.getStatusName;
            pickerIDArray = statusClsObj.getStatusID;
            dataPicker.hidden = NO;
            [dataPicker reloadAllComponents];
            [dataPicker selectRow:0 inComponent:0 animated:YES];
        }
    }
    
    if ([textField isEqual:priorityTxtF]) {
        
        txtTypefld = priorityTxtF;
        pickerArray = [NSMutableArray arrayWithObjects:@"Select Priority",@"Low",@"Medium",@"High",@"Critical", nil];
        
        pickerIDArray = [NSMutableArray arrayWithObjects:@"-1",@"1",@"2",@"3",@"4", nil];
        
        dataPicker.hidden = NO;
        [dataPicker reloadAllComponents];
        [dataPicker selectRow:0 inComponent:0 animated:YES];
       
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    //textView.text = @"FURTHER INFORMATION";
    if ([textView.text isEqualToString:@"FURTHER INFORMATION"]) {
        textView.text = @"";
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
    
    
    if ([txtTypefld isEqual:selitemStatsTxtF]) {
        [selitemStatsTxtF setText:[pickerArray objectAtIndex:row]];
        selstautsID = [pickerIDArray objectAtIndex:row];
    }
    
    if ([txtTypefld isEqual:priorityTxtF]) {
        [priorityTxtF setText:[pickerArray objectAtIndex:row]];
        selPriortyID = [pickerIDArray objectAtIndex:row];
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


#pragma mark -
#pragma mark WebServiceHelper delegate method
-(void)WebServiceHelper:(WebServiceHelper *)editor didFinishWithResult:(BOOL)result
{
    [SVProgressHUD dismiss];
	if (result)
	{
        if ([[editor currentCall] isEqualToString:@"itemticket"])
        {
            NSLog(@"result -- %@ %lu",[[editor ReturnStr] JSONValue],(unsigned long)[[[editor ReturnStr] JSONValue] count]);
            [[[UIAlertView alloc] initWithTitle:@"Success !" message:@"Fault Reported." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
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
