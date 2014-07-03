//
//  SupplierDetailsViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 09/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "SupplierDetailsViewController.h"
#import "AppData.h"
#import "HexColorToUIColor.h"

@interface SupplierDetailsViewController ()<UIAlertViewDelegate>

@end

@implementation SupplierDetailsViewController

@synthesize supplier;
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
    [self.scroller setContentSize:CGSizeMake(320, (IS_IPAD ? 1455:920))];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (UIView *view in self.scroller.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            textField.userInteractionEnabled = false;
        }
    }
    
    email2TxtF.userInteractionEnabled = true;
    emailTxtF.userInteractionEnabled = true;
    
    HexColorToUIColor *hexColor = [[HexColorToUIColor alloc] init];
    [emailTxtF setDelegate:self];
    [contanctTxtF setDelegate:self];
    [telephoneTxtF setDelegate:self];
    [address1TxtF setDelegate:self];
    [address2TxtF setDelegate:self];
    [address3TxtF setDelegate:self];
    [towncityTxtF setDelegate:self];
    [contrystateTxtF setDelegate:self];
    [postcodeTxtF setDelegate:self];
    [emailTxtF setDelegate:self];
    
   /* [productNamelbl setFont:[UIFont fontWithName:CORBEL_FONT_BOLD size:14.0f]];
    [productNamelbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    
    [address1lbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [address1lbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [address2lbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [address2lbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [address3lbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [address3lbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [towncitylbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [towncitylbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [contrystatelbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [contrystatelbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [postcodelbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [postcodelbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [websitelbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [websitelbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [emaillbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [emaillbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [email2lbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [email2lbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [telephonelbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [telephonelbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [contanctlbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [contanctlbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];*/
    
    
     productNamelbl.text = [supplier supplier_title];
    
    //[address1TxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [address1TxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [address1TxtF setText:[supplier supplier_address1]];
    
    //[address2TxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [address2TxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [address2TxtF setText:[supplier supplier_address2]];
    
    //[address3TxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [address3TxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [address3TxtF setText:[supplier supplier_address3]];
    
    //[towncityTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [towncityTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [towncityTxtF setText:[supplier supplier_town]];
    
    //[contrystateTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [contrystateTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [contrystateTxtF setText:[supplier supplier_county]];
    
    //[postcodeTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [postcodeTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [postcodeTxtF setText:[supplier supplier_postcode]];
    
    [websiteTxtF setDelegate:self];
    //[websiteTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [websiteTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [websiteTxtF setText:[supplier supplier_website]];
    
    //[emailTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [emailTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [emailTxtF setText:[supplier supplier_email]];
    
    //[telephoneTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [telephoneTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [telephoneTxtF setText:[supplier supplier_telephone]];
    
    //[contanctTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [contanctTxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [contanctTxtF setText:[supplier supplier_contact_name]];
    
    //[email2TxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    [email2TxtF setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    [email2TxtF setText:[supplier supplier_contact_email]];

}

- (IBAction)backToPrevView:(id)sender {
    if ([self.controllerRoot isEqualToString:@"itemDetails"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [[self navigationController] popViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

-(IBAction)launchSafariBrowser:(id)sender{
    if ([[supplier supplier_website] length] > 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[supplier supplier_website]]]];
    }
    
}

-(IBAction)launchTelephone:(id)sender{
    
    if ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] ) {
     
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm Call ?" message:telephoneTxtF.text delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call", nil];
        alert.tag = 101;
        [alert show];
        
    } else {
        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Notpermitted show];
        
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.text.length > 0) {
        MFMailComposeViewController* Apicker = [[MFMailComposeViewController alloc] init];
        if (Apicker != nil)
        {
            NSArray *toRecipients = [NSArray arrayWithObjects:textField.text, nil];
            [Apicker setToRecipients:toRecipients];
            
            Apicker.mailComposeDelegate = self;
            
            if([MFMailComposeViewController canSendMail])
            {
                [self presentViewController:Apicker animated:YES completion:nil];
            }
        }
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    NSString *message;
    
    switch (result) {
        case MFMailComposeResultCancelled:
            message =@"You have canceled your email.";
            break;
        case MFMailComposeResultFailed:
            message=@"Your email is failed";
            break;
        case MFMailComposeResultSent:
            message=@"Your email was successfully sent.";
            break;
        case MFMailComposeResultSaved:
            message=@" Your email has been saved";
            break;
            
        default:
            message=@" Your email is not send";
            break;
    }
    UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alt show];
   
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 101) {
        if (alertView.cancelButtonIndex != buttonIndex) {
            NSString *trimmedString = [alertView.message stringByReplacingOccurrencesOfString:@" " withString:@""];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",trimmedString]]];
        }
    }
    
}

/*
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField.tag == 907)
    {
        //if(isActive)
        {
            if(websiteTxtF.text.length > 0)
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:websiteTxtF.text]];
            }
        }
    }
    else if (textField.tag == 909)
    {
        //if(isActive)
        {
            if(telephoneTxtF.text.length > 0)
            {
                if ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",telephoneTxtF.text]]];
                    
                } else {
                    UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [Notpermitted show];
                    
                }
            }
        }
        // return YES;
        
    }

}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
   // BOOL isActive = [textField isFirstResponder];
    NSLog(@"test -- %ld",(long)textField.tag);
    
    if(textField.tag == 907)
    {
        //if(isActive)
        {
            if(websiteTxtF.text.length > 0)
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:websiteTxtF.text]];
                return NO;
            }
        }
    }
    else if (textField.tag == 909)
    {
        //if(isActive)
        {
            if(telephoneTxtF.text.length > 0)
            {
                if ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] ) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",telephoneTxtF.text]]];
                    
                } else {
                    UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [Notpermitted show];
                    
                }
                return NO;
            }
        }
       // return YES;
        
    }
    return YES;
}*/

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
