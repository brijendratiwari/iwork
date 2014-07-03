//
//  VechicleDetailsViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 09/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "VechicleDetailsViewController.h"
#import "AppData.h"
#import "HexColorToUIColor.h"

@interface VechicleDetailsViewController (){
    AppData *appDataObj;
}

@end

@implementation VechicleDetailsViewController
@synthesize vechicle;
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
    [self.scroller setContentSize:CGSizeMake(320,(IS_IPAD ? 1610:950))];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     HexColorToUIColor *hexColor = [[HexColorToUIColor alloc] init];
    
    for (UIView *view in self.scroller.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            textField.userInteractionEnabled = false;
            textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            textField.layer.borderWidth = 1.0f;
        }
    }
    
    appDataObj = [AppData sharedInstance];
    motDuelbl.text = @"MOD Due";
    reglbl.text = @"Reg No.";
    
    if ([appDataObj.countryName isEqualToString:@"au"]) {
        reglbl.text = @"Plate Number";
        motDuelbl.text = @"Vehicle Inspection";
    }
    
    notesTxtV.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    notesTxtV.layer.borderWidth = 1.0f;
    [notesTxtV setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    
    //[productNamelbl setFont:[UIFont fontWithName:CORBEL_FONT_BOLD size:14.0f]];
    //[productNamelbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    productNamelbl.text = [[vechicle makeText] stringByAppendingString:[NSString stringWithFormat:@" %@",[vechicle modelText]]];
    
   // [barcodelbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
    //[barcodelbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
   // [reglbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
   // [reglbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
   // [enginlbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
   // [enginlbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
   // [valuelbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
   // [valuelbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
   // [userlbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
   // [userlbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    //[sitelbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
   // [sitelbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
   // [loclbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
   // [loclbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
  //  [serviceDuelbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
   // [serviceDuelbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
   // [motDuelbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
  //  [motDuelbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
  //  [noteslbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
  //  [noteslbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
   // [purchasedlbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
   // [purchasedlbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
  //  [warrentylbl setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
   // [warrentylbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
  //  [barcodeTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
   // [barcodeTxtF setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    [barcodeTxtF setText:[vechicle barcodeText]];
    
   // [regTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
   // [regTxtF setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    [regTxtF setText:[vechicle reg_noText]];
    
  //  [enginTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
  //  [enginTxtF setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    [enginTxtF setText:[vechicle engine_sizeText]];
    
   // [valueTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
   // [valueTxtF setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    [valueTxtF setText:[vechicle vehicle_valueText]];
    
   // [userTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
  //  [userTxtF setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    [userTxtF setText:[vechicle ownerText]];
    
   // [siteTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
  //  [siteTxtF setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    [siteTxtF setText:[vechicle siteText]];
    
  //  [locTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
  //  [locTxtF setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    [locTxtF setText:@"Not Available"];
    
  //  [serviceDueTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
   // [serviceDueTxtF setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    [serviceDueTxtF setText:@""]; //not get
    
   // [motDueTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
  //  [motDueTxtF setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    [motDueTxtF setText:@""]; //not get
    
   // [notesTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
   // [notesTxtF setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    [notesTxtV setText:[vechicle notesText]];
    
   // [purchasedTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
   // [purchasedTxtF setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    [purchasedTxtF setText:[vechicle purchase_dateText]];
    
   // [warrentyTxtF setFont:[UIFont fontWithName:CORBEL_FONT size:12.0f]];
   // [warrentyTxtF setTextColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    [warrentyTxtF setText:[vechicle warranty_expirationText]];
    
}

-(IBAction)backToDeshboardView:(id)sender{
    NSArray *array = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
}

- (IBAction)backToPrevView:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning{
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
