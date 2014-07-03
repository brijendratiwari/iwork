//
//  DashboardViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 29/04/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "DashboardViewController.h"
#import "AppData.h"
#import "WebServiceHelper.h"
#import "SVProgressHUD.h"
#import "JSON.h"
#import "ManufactureClass.h"
#import "CategoriesClass.h"
#import "MakeClass.h"
#import "LocationClass.h"
#import "SitesClass.h"
#import "StatusClass.h"
#import "UsersClass.h"
#import "HexColorToUIColor.h"
#import "SupplierResult.h"

#import "MyLauncherView.h"
#import "MyLauncherItem.h"


@interface DashboardViewController ()<WebServiceHelperDelegate,MyLauncherViewDelegate>{
    
    AppData *appDataObj;
    ManufactureClass *manufacClassObj;
    CategoriesClass *catgrClassObj;
    LocationClass *locClassObj;
    SitesClass *sitesClassObj;
    UsersClass *userClassObj;
    MakeClass *makeClassObj;
    StatusClass *statusClassObj;
    
    BOOL pageControlBeingUsed;
    
    NSMutableArray *launcherItems;
}

@end

@implementation DashboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)doneEditting:(id)sender{
    [launcherView endEditing];
    [launcherView savePages];
}

-(void)launcherItemSelected:(MyLauncherItem*)item{
    NSLog(@"item -- %d",item.itemTag);
    
    switch (item.itemTag) {
        case 1:
            NSLog(@"addtome");
            appDataObj.deshboardNavType = @"addtome";
            [self navigateToAnotherView:@"AddItemViewController"];
            break;
        case 2:
            NSLog(@"viewitem");
            appDataObj.deshboardNavType = @"viewitem";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 3:
            NSLog(@"compliancecheck");
            appDataObj.deshboardNavType = @"compliancecheck";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 4:
            NSLog(@"addsimilar");
            appDataObj.deshboardNavType = @"addsimilar";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 5:
            NSLog(@"viewvehicle");
            appDataObj.deshboardNavType = @"viewvehicle";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 6:
            NSLog(@"vehiclecheck");
            appDataObj.deshboardNavType = @"vehiclecheck";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 7:
            NSLog(@"searchloc");
            appDataObj.deshboardNavType = @"searchloc";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 8:
            NSLog(@"ownership");
            appDataObj.deshboardNavType = @"ownership";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 9:
            NSLog(@"editloc");
            appDataObj.deshboardNavType = @"editloc";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 10:
            NSLog(@"reportfault");
            appDataObj.deshboardNavType = @"reportfault";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 11:
            NSLog(@"suppliers");
            appDataObj.deshboardNavType = @"suppliers";
            [self navigateToAnotherView:@"SupplierListViewController"];
            break;
        case 12:
            NSLog(@"auditloc");
            appDataObj.deshboardNavType = @"auditloc";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 13:
            NSLog(@"viewdoc");
            appDataObj.deshboardNavType = @"viewdoc";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 14:
            NSLog(@"pattest");
            appDataObj.deshboardNavType = @"pattest";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 15:
            NSLog(@"vechicleownership");
            appDataObj.deshboardNavType = @"vechicleownership";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 16:
            NSLog(@"reportvechiclefault");
            appDataObj.deshboardNavType = @"reportvechiclefault";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 17:
            NSLog(@"changetome");
            appDataObj.deshboardNavType = @"changetome";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        default:
            break;
    }
}

-(NSArray*)retrieveFromUserDefaults:(NSString *)key
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSArray *val = nil;
	
	if (standardUserDefaults)
		val = [standardUserDefaults objectForKey:key];
	
	return val;
}

-(NSMutableArray *)savedLauncherItems
{
	NSArray *savedPages = [self retrieveFromUserDefaults:@"myLauncherView"];
	
	if(savedPages)
	{
		NSMutableArray *savedLauncherItems = [[NSMutableArray alloc] init];
		
		for (NSArray *page in savedPages)
		{
			NSMutableArray *savedPage = [[NSMutableArray alloc] init];
			for(NSDictionary *item in page)
			{
                
                NSLog(@"get tag - %ld",(long)[item objectForKey:@"tag"]);
				[savedPage addObject:[[MyLauncherItem alloc]
                                      initWithTitle:[item objectForKey:@"title"]
                                      image:[item objectForKey:@"image"]
                                      target:[item objectForKey:@"controller"]
                                      deletable:[[item objectForKey:@"deletable"]  boolValue]
                                      tag:[[item objectForKey:@"tag"]  integerValue]] ];
                
			}
			
			[savedLauncherItems addObject:savedPage];
		}
        
        return savedLauncherItems;
	}
    
	return nil;
}


-(void)initilizePages{
    
    launcherView = [[MyLauncherView alloc] init];
    NSMutableArray *imgArr = [[NSMutableArray alloc] init];
    
    if (IS_IPAD) {
        [launcherView setFrame:CGRectMake(0, 320 , 768, 550)];
        
        [imgArr addObject:@"add_new_icon_new"];
        [imgArr addObject:@"view_item_icon_new"];
        [imgArr addObject:@"Complience_icon_new"];
        [imgArr addObject:@"add_similar_icon_new"];
        [imgArr addObject:@"view_vehicle_icon_new"];
        [imgArr addObject:@"vehicle_check_icon_new"];
        [imgArr addObject:@"search_location_icon_new"];
        [imgArr addObject:@"change_ownership_icon_new"];
        [imgArr addObject:@"change_location_icon_new"];
        [imgArr addObject:@"report_fault_icon_new"];
        [imgArr addObject:@"suppliers_icon_new"];
        [imgArr addObject:@"audit_loation_icon_new"];
        [imgArr addObject:@"view_documents_icon_new"];
        [imgArr addObject:@"pat_test_icon_new"];
        [imgArr addObject:@"Vechile_ownership_icon_new"];
        [imgArr addObject:@"report_vehicle_icon_new"];
        [imgArr addObject:@"change_to_me_icon_new"];
    }else{
        if (IS_IPHONE_5) {
            [launcherView setFrame:CGRectMake(0, 220 , 320, 270)];
            
            [imgArr addObject:@"add_new_icon_new"];
            [imgArr addObject:@"view_item_icon_new"];
            [imgArr addObject:@"Complience_icon_new"];
            [imgArr addObject:@"add_similar_icon_new"];
            [imgArr addObject:@"view_vehicle_icon_new"];
            [imgArr addObject:@"vehicle_check_icon_new"];
            [imgArr addObject:@"search_location_icon_new"];
            [imgArr addObject:@"change_ownership_icon_new"];
            [imgArr addObject:@"change_location_icon_new"];
            [imgArr addObject:@"report_fault_icon_new"];
            [imgArr addObject:@"suppliers_icon_new"];
            [imgArr addObject:@"audit_loation_icon_new"];
            [imgArr addObject:@"view_documents_icon_new"];
            [imgArr addObject:@"pat_test_icon_new"];
            [imgArr addObject:@"Vechile_ownership_icon_new"];
            [imgArr addObject:@"report_vehicle_icon_new"];
            [imgArr addObject:@"change_to_me_icon_new"];
            
        }else{
            [launcherView setFrame:CGRectMake(0, 230 , 320, 170)];
            [imgArr addObject:@"add_new_icon_new@2x_40"];
            [imgArr addObject:@"view_item_icon_new@2x_40"];
            [imgArr addObject:@"complaince_due_icon_new@2x_40"];
            [imgArr addObject:@"add_similar_icon_new@2x_40"];
            [imgArr addObject:@"view_vehicle_icon_new@2x_40"];
            [imgArr addObject:@"vehicle_check_icon_new@2x_40"];
            [imgArr addObject:@"search_location_icon_new@2x_40"];
            [imgArr addObject:@"change_ownership_icon_new@2x_40"];
            [imgArr addObject:@"change_location_icon_new@2x_40"];
            [imgArr addObject:@"report_fault_icon_new@2x_40"];
            [imgArr addObject:@"suppliers_icon_new@2x_40"];
            [imgArr addObject:@"audit_loation_icon_new@2x_40"];
            [imgArr addObject:@"view_documents_icon_new@2x_40"];
            [imgArr addObject:@"pat_test_icon_new@2x_40"];
            [imgArr addObject:@"Vechile_ownership_icon_new@2x_40"];
            [imgArr addObject:@"report_vehicle_icon_new@2x_40"];
            [imgArr addObject:@"change_to_me_icon_new@2x_40"];
        }
    }
    
    launcherView.backgroundColor = [UIColor clearColor];
    launcherView.delegate = self;
    [[self view] addSubview:launcherView];
    
    launcherItems = [self savedLauncherItems];
	
    if(!launcherItems)
	{
		[launcherView setPages:[NSMutableArray arrayWithObjects:
								[NSMutableArray arrayWithObjects:
								 [[MyLauncherItem alloc] initWithTitle:@"Add New"
                                                                  image:[imgArr objectAtIndex:0]
                                                                 target:@"ItemViewController"
                                                              deletable:NO tag:1] ,
                                 
                                 [[MyLauncherItem alloc] initWithTitle:@"View Item"
                                                                  image:[imgArr objectAtIndex:1]
                                                                 target:@"ItemViewController"
                                                              deletable:NO  tag:2] ,
                                 
                                 [[MyLauncherItem alloc] initWithTitle:@"Compliance Check"
                                                                  image:[imgArr objectAtIndex:2]
                                                                 target:@"ItemViewController"
                                                              deletable:NO tag:3],
                                 
                                 [[MyLauncherItem alloc] initWithTitle:@"Add Similar"
                                                                  image:[imgArr objectAtIndex:3]
                                                                 target:@"ItemViewController"
                                                              deletable:NO tag:4] ,
                                 
                                 [[MyLauncherItem alloc] initWithTitle:@"Search Location"
                                                                  image:[imgArr objectAtIndex:6]
                                                                 target:@"ItemViewController"
                                                              deletable:NO tag:7],
                                 
                                 [[MyLauncherItem alloc] initWithTitle:@"Ownership"
                                                                  image:[imgArr objectAtIndex:7]
                                                                 target:@"ItemViewController" 
                                                              deletable:NO tag:8] ,
                                 
                                 [[MyLauncherItem alloc] initWithTitle:@"Change Location"
                                                                 image:[imgArr objectAtIndex:8]
                                                                target:@"ItemViewController"
                                                             deletable:NO tag:9] ,
                                 
                                 [[MyLauncherItem alloc] initWithTitle:@"Report Fault"
                                                                 image:[imgArr objectAtIndex:9]
                                                                target:@"ItemViewController"
                                                             deletable:NO tag:10] ,
                                 
                                 [[MyLauncherItem alloc] initWithTitle:@"Suppliers"
                                                                 image:[imgArr objectAtIndex:10]
                                                                target:@"ItemViewController"
                                                             deletable:NO tag:11],
                                 
                                 [[MyLauncherItem alloc] initWithTitle:@"Audit Location"
                                                                 image:[imgArr objectAtIndex:11]
                                                                target:@"ItemViewController"
                                                             deletable:NO tag:12] ,
                                 
                                 
                                 [[MyLauncherItem alloc] initWithTitle:@"View Documents"
                                                                 image:[imgArr objectAtIndex:12]
                                                                target:@"ItemViewController"
                                                             deletable:NO tag:13] ,
                                 
                                 [[MyLauncherItem alloc] initWithTitle:@"Pat Test"
                                                                 image:[imgArr objectAtIndex:13]
                                                                target:@"ItemViewController"
                                                             deletable:NO tag:14],

                                 nil],
                                [NSMutableArray arrayWithObjects:
                                 
                                 
                                 [[MyLauncherItem alloc] initWithTitle:@"View Vehicle"
                                                                 image:[imgArr objectAtIndex:4]
                                                                target:@"ItemViewController"
                                                             deletable:NO tag:5],
                                 
                                 [[MyLauncherItem alloc] initWithTitle:@"Vehicle Check"
                                                                 image:[imgArr objectAtIndex:5]
                                                                target:@"ItemViewController"
                                                             deletable:NO tag:6] ,

                                 
                                 [[MyLauncherItem alloc] initWithTitle:@"Vehicle Ownership"
                                                                 image:[imgArr objectAtIndex:14]
                                                                target:@"ItemViewController"
                                                             deletable:NO tag:15] ,
                                 
                                 [[MyLauncherItem alloc] initWithTitle:@"Report Vehicle"
                                                                 image:[imgArr objectAtIndex:15]
                                                                target:@"ItemViewController"
                                                             deletable:NO tag:16] ,
                                 
                                 
                                 [[MyLauncherItem alloc] initWithTitle:@"Change To Me"
                                                                 image:[imgArr objectAtIndex:16]
                                                                target:@"ItemViewController"
                                                             deletable:NO tag:17],

                                 nil],
                                nil]];
	}else{
        [launcherView setPages:launcherItems];
    }

}


-(IBAction)pressLogout:(id)sender{
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
        
        [obj setMethodName:@"logout"];
        [obj setMethodResult:@""];
        [obj setMethodType:@"POST"];
        [obj setCurrentCall:@"logout"];
        
        [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
        [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
        [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
        
        [obj initiateConnection];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [SVProgressHUD dismiss];
        [SVProgressHUD show];
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    appDataObj = [AppData sharedInstance];
    appDataObj.deshboardNavType  = @"";
    
    usernamelbl.text = [NSString stringWithFormat:@"Hi %@",appDataObj.nickname];
    accountNamelbl.text = appDataObj.accountname;
    levelNamelbl.text = appDataObj.levelname;
    
     HexColorToUIColor *hexColor = [[HexColorToUIColor alloc] init];
    //[usernamelbl setTextColor:[hexColor colorFromHexString:@"#555555" alpha:1.0]];
    //[accountNamelbl setTextColor:[hexColor colorFromHexString:@"#8a8989" alpha:1.0]];
    //[levelNamelbl setTextColor:[hexColor colorFromHexString:@"#8a8989" alpha:1.0]];

    //[usernamelbl setFont:[UIFont fontWithName:CORBEL_FONT_BOLD size:13.0f]];
    //[accountNamelbl setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];
    //[levelNamelbl setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];
    profilePic.layer.borderColor = [[hexColor colorFromHexString:@"#ffcd33" alpha:1.0] CGColor];
    profilePic.layer.borderWidth = 1.5f;
     profilePic.layer.cornerRadius = 32.0f;
    if (IS_IPAD) {
        profilePic.layer.cornerRadius = 57.0f;
    }
    
    profilePic.layer.masksToBounds = YES;
    
    manufacClassObj = [ManufactureClass sharedInstance];
    catgrClassObj = [CategoriesClass sharedInstance];
    locClassObj = [LocationClass sharedInstance];
    sitesClassObj = [SitesClass sharedInstance];
    userClassObj = [UsersClass sharedInstance];
    makeClassObj = [MakeClass sharedInstance];
    statusClassObj = [StatusClass sharedInstance];
    
     NSLog(@"IMG - %@",[NSString stringWithFormat:@"%@%@",appDataObj.apiURL_IMAGE,appDataObj.photopath]);
    
    if (appDataObj.photopath != (id)[NSNull null]) {
        if ([appDataObj.photopath length] != 0) {
            profilePic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",appDataObj.apiURL_IMAGE,appDataObj.photopath]]]];
        }
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
        
        [obj setMethodName:@"item_lookup_param"];
        [obj setMethodResult:@""];
        [obj setMethodType:@"POST"];
        [obj setCurrentCall:@"itemLookUp"];
        
        [obj initiateConnection];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [SVProgressHUD dismiss];
        [SVProgressHUD show];
    }
    
    [self initilizePages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*-(IBAction)navIconClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
            NSLog(@"addtome");
            appDataObj.deshboardNavType = @"addtome";
            [self navigateToAnotherView:@"AddItemViewController"];
            break;
        case 2:
            NSLog(@"viewitem");
            appDataObj.deshboardNavType = @"viewitem";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 3:
            NSLog(@"compliancecheck");
            appDataObj.deshboardNavType = @"compliancecheck";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 4:
            NSLog(@"addsimilar");
            appDataObj.deshboardNavType = @"addsimilar";
             [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 5:
            NSLog(@"viewvehicle");
            appDataObj.deshboardNavType = @"viewvehicle";
             [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 6:
            NSLog(@"vehiclecheck");
            appDataObj.deshboardNavType = @"vehiclecheck";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 7:
            NSLog(@"searchloc");
            appDataObj.deshboardNavType = @"searchloc";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 8:
            NSLog(@"ownership");
            appDataObj.deshboardNavType = @"ownership";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 9:
            NSLog(@"editloc");
            appDataObj.deshboardNavType = @"editloc";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 10:
            NSLog(@"reportfault");
            appDataObj.deshboardNavType = @"reportfault";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        case 11:
            NSLog(@"suppliers");
            appDataObj.deshboardNavType = @"suppliers";
            [self navigateToAnotherView:@"SupplierListViewController"];
            break;
        case 12:
            NSLog(@"auditloc");
            appDataObj.deshboardNavType = @"auditloc";
            [self navigateToAnotherView:@"ScanQRViewController"];
            break;
        default:
            break;
    }

    UIViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ScanQRViewController"];
    //[[self navigationController] pushViewController:pushContoller animated:YES];
    
}*/

-(void)navigateToAnotherView:(NSString *)viewStr{
    UIViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:viewStr];
    [[self navigationController] pushViewController:pushContoller animated:YES];
}

#pragma mark -
#pragma mark WebServiceHelper delegate method
-(void)WebServiceHelper:(WebServiceHelper *)editor didFinishWithResult:(BOOL)result
{
    [SVProgressHUD dismiss];
	if (result)
	{
        
        if ([[editor currentCall] isEqualToString:@"logout"])
        {
            NSLog(@"result -- %@",[[editor ReturnStr] JSONValue]);
            
            appDataObj.nickname = @"";
            appDataObj.password = @"";
            appDataObj.accountname = @"";
            appDataObj.levelname = @"";
            appDataObj.username = @"";
            appDataObj.photopath = @"";
            appDataObj.userID = @"";
            
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            [[self navigationController] popViewControllerAnimated:YES];
            
        }
        
        if ([[editor currentCall] isEqualToString:@"itemLookUp"])
        {
            NSLog(@"result -- %@",[[editor ReturnStr] JSONValue]);
            NSMutableDictionary *resultDic = [[editor ReturnStr] JSONValue];
            if (resultDic) {
                
                [[SupplierResult sharedInstance] setAllSuppliersInArray:[resultDic objectForKey:@"arrSuppliers"]];
                
                // get status
                NSMutableArray *stnameArr = [NSMutableArray array];
                NSMutableArray *stidArr = [NSMutableArray array];
                
                [stnameArr addObject:@"Select Status"];
                [stidArr addObject:@"-1"];
                
                for (NSMutableDictionary *mDic in [resultDic valueForKey:@"arrItemStatuses"]) {
                    [stidArr addObject:[mDic objectForKey:@"statusid"]];
                    [stnameArr addObject:[mDic objectForKey:@"statusname"]];
                }
                
                [statusClassObj setStatusID:stidArr];
                [statusClassObj setStatusName:stnameArr];
                
                
                // get make
                NSMutableArray *mknameArr = [NSMutableArray array];
                NSMutableArray *mkidArr = [NSMutableArray array];
                
                [mknameArr addObject:@"Select Make"];
                [mkidArr addObject:@"-1"];
                
                for (NSMutableDictionary *mDic in [resultDic valueForKey:@"arrMakes"]) {
                    [mkidArr addObject:[mDic objectForKey:@"makeid"]];
                    [mknameArr addObject:[mDic objectForKey:@"makename"]];
                }
                
                [makeClassObj setMakeID:mkidArr];
                [makeClassObj setMakeName:mknameArr];

              
                // get categories
                NSMutableArray *cnameArr = [NSMutableArray array];
                NSMutableArray *cidArr = [NSMutableArray array];
                
                [cnameArr addObject:@"Select Category"];
                [cidArr addObject:@"-1"];
                
                for (NSMutableDictionary *mDic in [resultDic valueForKey:@"categories"]) {
                    [cidArr addObject:[mDic objectForKey:@"id"]];
                    [cnameArr addObject:[mDic objectForKey:@"name"]];
                }
                
                [catgrClassObj setCategoriesID:cidArr];
                [catgrClassObj setCategoriesName:cnameArr];
                
                // get manufacturer
                NSMutableArray *mnameArr = [NSMutableArray array];
                [mnameArr addObject:@"Select Manufacturer"];
                
                for (NSMutableDictionary *mDic in [resultDic valueForKey:@"manufacturer"]) {
                    [mnameArr addObject:[mDic objectForKey:@"name"]];
                }
                
                [manufacClassObj setManufactureName:mnameArr];
                
                // get locations
                NSMutableArray *lnameArr = [NSMutableArray array];
                NSMutableArray *lidArr = [NSMutableArray array];
                NSMutableArray *lbcodeArr = [NSMutableArray array];
                
                [lnameArr addObject:@"Select Location"];
                [lidArr addObject:@"-1"];
                [lbcodeArr addObject:@"-1"];
                
                for (NSMutableDictionary *mDic in [resultDic valueForKey:@"locations"]) {
                    [lidArr addObject:[mDic objectForKey:@"id"]];
                    [lnameArr addObject:[mDic objectForKey:@"name"]];
                    [lbcodeArr addObject:[mDic objectForKey:@"barcode"]];
                }
                
                [locClassObj setLocationName:lnameArr];
                [locClassObj setLocationID:lidArr];
                [locClassObj setLocationBarCode:lbcodeArr];
                
                // get sites
                NSMutableArray *snameArr = [NSMutableArray array];
                NSMutableArray *sidArr = [NSMutableArray array];
                
                [snameArr addObject:@"Select Site"];
                [sidArr addObject:@"-1"];
                
                for (NSMutableDictionary *mDic in [resultDic valueForKey:@"sites"]) {
                    [snameArr addObject:[mDic objectForKey:@"name"]];
                    [sidArr addObject:[mDic objectForKey:@"id"]];
                }
                
                [sitesClassObj setSitesName:snameArr];
                [sitesClassObj setSitesID:sidArr];
                
                // get users
                NSMutableArray *unameArr = [NSMutableArray array];
                NSMutableArray *uidArr = [NSMutableArray array];
                
                [unameArr addObject:@"Select User"];
                [uidArr addObject:@"-1"];
                
                for (NSMutableDictionary *mDic in [resultDic valueForKey:@"users"]) {
                    [unameArr addObject:[mDic objectForKey:@"name"]];
                    [uidArr addObject:[mDic objectForKey:@"id"]];
                }
                
                [userClassObj setUsersName:unameArr];
                [userClassObj setUsersID:uidArr];
              
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
