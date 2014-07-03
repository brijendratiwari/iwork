//
//  VechileListViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 09/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "VechileListViewController.h"
#import "iTeamDetailsViewController.h"
#import "AddSimilarViewController.h"
#import "VechicleDetailsViewController.h"
#import "VehicleResults.h"
#import "Vechicles.h"
#import "AppData.h"
#import "HexColorToUIColor.h"
#import "ReportFaultViewController.h"
#import "ChangeVechicleViewController.h"

@interface VechileListViewController (){
    VehicleResults *resltvechleObj;
    AppData *appDataObj;
    HexColorToUIColor *hexColor;
}

@end

@implementation VechileListViewController

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
    
    hexColor = [[HexColorToUIColor alloc] init];
    
    //[resultCountlbl setFont:[UIFont fontWithName:CORBEL_FONT_BOLD size:14.0f]];
    //[resultCountlbl setTextColor:[hexColor colorFromHexString:@"#3f3f3f" alpha:1.0]];
    
    [searchTable setSeparatorColor:[UIColor darkGrayColor]];
    if (IS_IPAD) {
        searchTable.rowHeight = 88.0f;
    }
    
    resltvechleObj = [VehicleResults sharedInstance];
    appDataObj = [AppData sharedInstance];
    
    NSLog(@"%lu",(unsigned long)[[resltvechleObj vechicles] count]);
    
    if ([[resltvechleObj vechicles] count] != 0) {
        resultCountlbl.text = [NSString stringWithFormat:@"Search result found %lu items",(unsigned long)[[resltvechleObj vechicles] count]];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert !" message:@"No result found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backToPrevView:(id)sender{
    [[self navigationController] popViewControllerAnimated:YES];
}

-(IBAction)backToDeshboardView:(id)sender{
    NSArray *array = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
}

#pragma Mark - UITableViewDelegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[resltvechleObj vechicles] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SearchResultCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Vechicles *vechicle = [[resltvechleObj vechicles] objectAtIndex:indexPath.row];
    
    NSString *tittleStr = [[vechicle barcodeText] stringByAppendingString:[NSString stringWithFormat:@": %@ %@",[vechicle makeText],[vechicle modelText]]];

    cell.textLabel.font = [UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)];
    cell.textLabel.textColor = [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0];
    [cell setTintColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    cell.textLabel.text = tittleStr;
    //cell.accessoryType = UITableViewCellAccessoryDetailButton;
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    //[self pushToNextView:indexPath];
    
    if ([appDataObj.deshboardNavType isEqualToString:@"reportvechiclefault"]) {
        ReportFaultViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ReportFaultViewController"];
        pushContoller.vechicle = [[resltvechleObj vechicles] objectAtIndex:indexPath.row];
        [[self navigationController] pushViewController:pushContoller animated:YES];
        
    }
    
    else if ([appDataObj.deshboardNavType isEqualToString:@"vechicleownership"])
    {
        ChangeVechicleViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangeVechicleViewController"];
        pushContoller.vechicle = [[resltvechleObj vechicles] objectAtIndex:indexPath.row];
        [[self navigationController] pushViewController:pushContoller animated:YES];
    }
    
    else{
        VechicleDetailsViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"VechicleDetailsViewController"];
        pushContoller.vechicle = [[resltvechleObj vechicles] objectAtIndex:indexPath.row];
        [[self navigationController] pushViewController:pushContoller animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    //[self pushToNextView:indexPath];
    
    if ([appDataObj.deshboardNavType isEqualToString:@"reportvechiclefault"]) {
        ReportFaultViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ReportFaultViewController"];
        pushContoller.vechicle = [[resltvechleObj vechicles] objectAtIndex:indexPath.row];
        [[self navigationController] pushViewController:pushContoller animated:YES];
        
    }
    
    else if ([appDataObj.deshboardNavType isEqualToString:@"vechicleownership"])
    {
        ChangeVechicleViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangeVechicleViewController"];
        pushContoller.vechicle = [[resltvechleObj vechicles] objectAtIndex:indexPath.row];
        [[self navigationController] pushViewController:pushContoller animated:YES];
    }
    
    else{
        VechicleDetailsViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"VechicleDetailsViewController"];
        pushContoller.vechicle = [[resltvechleObj vechicles] objectAtIndex:indexPath.row];
        [[self navigationController] pushViewController:pushContoller animated:YES];
    }
    
    
}

-(void)pushToNextView:(NSIndexPath *)indexPath{
    if ([appDataObj.deshboardNavType isEqualToString:@"viewitem"]) {
        
        iTeamDetailsViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"iTeamDetailsViewController"];
        pushContoller.item = [[resltvechleObj vechicles] objectAtIndex:indexPath.row];
      //  [[self navigationController] pushViewController:pushContoller animated:YES];
        
    }else if ([appDataObj.deshboardNavType isEqualToString:@"addsimilar"]){
        
        AddSimilarViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"AddSimilarViewController"];
        pushContoller.item = [[resltvechleObj vechicles] objectAtIndex:indexPath.row];
       // [[self navigationController] pushViewController:pushContoller animated:YES];
        
    }else if ([appDataObj.deshboardNavType isEqualToString:@"compliancecheck"]){
        
//        ComplienceCheckViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ComplienceCheckViewController"];
//        pushContoller.item = [[resltItemObj items] objectAtIndex:indexPath.row];
//        [[self navigationController] pushViewController:pushContoller animated:YES];
    }
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
