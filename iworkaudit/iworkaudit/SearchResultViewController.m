//
//  SearchResultViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 02/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "SearchResultViewController.h"
#import "iTeamDetailsViewController.h"
#import "AddSimilarViewController.h"
#import "ResultItems.h"
#import "Item.h"
#import "AppData.h"
#import "HexColorToUIColor.h"
#import "ComplienceCheckViewController.h"
#include "ChangeOwnerShipViewController.h"
#import "ReportFaultViewController.h"
#import "PatTestViewController.h"
#import "ViewDocViewController.h"

@interface SearchResultViewController (){
    ResultItems *resltItemObj;
    AppData *appDataObj;
    HexColorToUIColor *hexColor;
}

@end

@implementation SearchResultViewController

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
    resltItemObj = [ResultItems sharedInstance];
    appDataObj = [AppData sharedInstance];
    
   // [resultCountlbl setFont:[UIFont fontWithName:CORBEL_FONT_BOLD size:(IS_IPAD ? 28.0f:14.0f)]];
    [resultCountlbl setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];

    
    [searchTable setSeparatorColor:[UIColor darkGrayColor]];
    
    if (IS_IPAD) {
        searchTable.rowHeight = 88.0f;
    }
    
   
    
    NSLog(@"%lu",(unsigned long)[[resltItemObj items] count]);
    
    if ([[resltItemObj items] count] != 0) {
        resultCountlbl.text = [NSString stringWithFormat:@"Search result found %lu items",(unsigned long)[[resltItemObj items] count]];
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
    return [[resltItemObj items] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SearchResultCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Item *item = [[resltItemObj items] objectAtIndex:indexPath.row];
    
    NSString *tittleStr = [[item barcodeText] stringByAppendingString:[NSString stringWithFormat:@": %@ %@",[item manufacturerText],[item modelText]]];
    cell.textLabel.font = [UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 24.0f:12.0f)];
    cell.textLabel.textColor = [hexColor colorFromHexString:@"#4C4C4C" alpha:1.0];
    [cell setTintColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    cell.textLabel.text = tittleStr;
   // cell.accessoryType = UITableViewCellAccessoryDetailButton;
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    [self pushToNextView:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
     [self pushToNextView:indexPath];
}

-(void)pushToNextView:(NSIndexPath *)indexPath{
    if ([appDataObj.deshboardNavType isEqualToString:@"viewitem"] || [appDataObj.deshboardNavType isEqualToString:@"searchloc"]) {

        iTeamDetailsViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"iTeamDetailsViewController"];
        pushContoller.item = [[resltItemObj items] objectAtIndex:indexPath.row];
        [[self navigationController] pushViewController:pushContoller animated:YES];
        
    }else if ([appDataObj.deshboardNavType isEqualToString:@"addsimilar"]){
        
        AddSimilarViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"AddSimilarViewController"];
        pushContoller.item = [[resltItemObj items] objectAtIndex:indexPath.row];
        [[self navigationController] pushViewController:pushContoller animated:YES];
        
    }else if ([appDataObj.deshboardNavType isEqualToString:@"compliancecheck"]){
        
        ComplienceCheckViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ComplienceCheckViewController"];
        pushContoller.item = [[resltItemObj items] objectAtIndex:indexPath.row];
        [[self navigationController] pushViewController:pushContoller animated:YES];
        
    }
    else if ([appDataObj.deshboardNavType isEqualToString:@"ownership"] || [appDataObj.deshboardNavType isEqualToString:@"editloc"]){
        
        ChangeOwnerShipViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangeOwnerShipViewController"];
        pushContoller.item = [[resltItemObj items] objectAtIndex:indexPath.row];
        [[self navigationController] pushViewController:pushContoller animated:YES];
    }
    else if ([appDataObj.deshboardNavType isEqualToString:@"reportfault"]){
        
        ReportFaultViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ReportFaultViewController"];
        pushContoller.item = [[resltItemObj items] objectAtIndex:indexPath.row];
        [[self navigationController] pushViewController:pushContoller animated:YES];
    }
    else if ([appDataObj.deshboardNavType isEqualToString:@"pattest"]){
        
        PatTestViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"PatTestViewController"];
        pushContoller.item = [[resltItemObj items] objectAtIndex:indexPath.row];
        [[self navigationController] pushViewController:pushContoller animated:YES];
    }
    else if ([appDataObj.deshboardNavType isEqualToString:@"viewdoc"]){
        
        ViewDocViewController *pushContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewDocViewController"];
        
        Item *item = [[resltItemObj items] objectAtIndex:indexPath.row];
        pushContoller.pdfListArr = (NSMutableArray *)[item pdf_nameArr] ;
        pushContoller.itemID = [item itemidText];
        [[self navigationController] pushViewController:pushContoller animated:YES];
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
