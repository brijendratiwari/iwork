//
//  SupplierListViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 07/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "SupplierListViewController.h"
#import "SupplierDetailsViewController.h"
#import "WebServiceHelper.h"
#import "AppData.h"
#import "HexColorToUIColor.h"
#import "SVProgressHUD.h"
#import "JSON.h"
#import "SupplierResult.h"
#import "Supplier.h"

@interface SupplierListViewController ()<WebServiceHelperDelegate>{
    SupplierResult *resltSuplerObj;
    AppData *appDataObj;
    HexColorToUIColor *hexColor;
}

@end

@implementation SupplierListViewController

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
    
    [resultCountlbl setHidden:TRUE];
    [searchTable setHidden:TRUE];
    
    appDataObj = [AppData sharedInstance];
    

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
        
        [obj setMethodName:@"supplierlist"];
        [obj setMethodResult:@""];
        [obj setMethodType:@"POST"];
        [obj setCurrentCall:@"getSupplierlist"];
        
        [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
        [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
        [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
        
        [obj initiateConnection];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [SVProgressHUD dismiss];
        [SVProgressHUD show];
    }
    
    hexColor = [[HexColorToUIColor alloc] init];
    
    //[resultCountlbl setFont:[UIFont fontWithName:CORBEL_FONT_BOLD size:14.0f]];
    [resultCountlbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    [searchTable setSeparatorColor:[UIColor darkGrayColor]];
    
    resltSuplerObj = [SupplierResult sharedInstance];
    
   
    if (IS_IPAD) {
        searchTable.rowHeight = 88.0f;
    }
}

-(IBAction)backToDeshboardView:(id)sender{
    NSArray *array = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma Mark - UITableViewDelegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[resltSuplerObj suppliers] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SearchResultCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Supplier *supplier = [[resltSuplerObj suppliers] objectAtIndex:indexPath.row];
    
    NSString *tittleStr = [supplier supplier_title];
    cell.textLabel.font = [UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)];
    cell.textLabel.textColor = [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0];
    [cell setTintColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    cell.textLabel.text = tittleStr;
    //cell.accessoryType = UITableViewCellAccessoryDetailButton;
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    SupplierDetailsViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"SupplierDetailsViewController"];
    pushContoller.supplier = [[resltSuplerObj suppliers] objectAtIndex:indexPath.row];
    [[self navigationController] pushViewController:pushContoller animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    SupplierDetailsViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"SupplierDetailsViewController"];
    pushContoller.supplier = [[resltSuplerObj suppliers] objectAtIndex:indexPath.row];
    [[self navigationController] pushViewController:pushContoller animated:YES];
}


#pragma mark -
#pragma mark WebServiceHelper delegate method
-(void)WebServiceHelper:(WebServiceHelper *)editor didFinishWithResult:(BOOL)result
{
    [SVProgressHUD dismiss];
	if (result)
	{
        if ([[editor currentCall] isEqualToString:@"getSupplierlist"])
        {
            NSLog(@"result -- %@",[[editor ReturnStr] JSONValue]);
            
             NSMutableDictionary *resultDic = [[editor ReturnStr] JSONValue];
            if ([[resultDic objectForKey:@"arrSuppliers"] count] != 0) {
                
                [[SupplierResult sharedInstance] setAllSuppliersInArray:[resultDic objectForKey:@"arrSuppliers"]];
                
                [resultCountlbl setHidden:FALSE];
                [searchTable setHidden:FALSE];
                
                resultCountlbl.text = [NSString stringWithFormat:@"Search result found %lu items",(unsigned long)[[resltSuplerObj suppliers] count]];
                [searchTable reloadData];
                
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
