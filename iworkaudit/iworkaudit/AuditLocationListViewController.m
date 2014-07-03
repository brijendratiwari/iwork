//
//  AuditLocationListViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 15/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "AuditLocationListViewController.h"
#import "iTeamDetailsViewController.h"
#import "AddSimilarViewController.h"
#import "ResultItems.h"
#import "Item.h"
#import "AppData.h"
#import "HexColorToUIColor.h"
#import "ComplienceCheckViewController.h"
#include "ChangeOwnerShipViewController.h"
#import "ReportFaultViewController.h"
#import "WebServiceHelper.h"
#import "SVProgressHUD.h"
#import "JSON.h"

@interface AuditLocationListViewController()<WebServiceHelperDelegate> {
    ResultItems *resltItemObj;
    AppData *appDataObj;
    HexColorToUIColor *hexColor;
    NSMutableArray *indexPathArray;
}

@end

@implementation AuditLocationListViewController

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
     appDataObj = [AppData sharedInstance];
    
    //[resultCountlbl setFont:[UIFont fontWithName:CORBEL_FONT_BOLD size:14.0f]];
    //[resultCountlbl setTextColor:[hexColor colorFromHexString:@"#3f3f3f" alpha:1.0]];
    
    [searchTable setSeparatorColor:[UIColor darkGrayColor]];
    if (IS_IPAD) {
        searchTable.rowHeight = 88.0f;
    }
    
    resltItemObj = [ResultItems sharedInstance];
    // NSLog(@"%lu",(unsigned long)[[resltItemObj items] count]);
    
   
    
    selectedIndexArray=[[NSMutableArray alloc] init];
    indexPathArray = [[NSMutableArray alloc] init];
    
    
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

-(void)submitAudit:(NSString *)selectedIDs :(NSString *)removedIDs{
    NSString *netStr = [[AppData sharedInstance] checkNetworkConnectivity];
    
    Item *item = [[resltItemObj items] objectAtIndex:0];
    
    if([netStr isEqualToString:@"NoAccess"])
    {
        [[AppData sharedInstance] callNoNetworkAlert];
    }
    else{
        WebServiceHelper *obj=[[WebServiceHelper alloc] init];
        [obj setDelegate:self];
        [obj setMethodResult:@""];
        [obj setMethodParameters:[[NSMutableDictionary alloc] init]];
        
        [obj setMethodName:[NSString stringWithFormat:@"locationAudit/%@",[item location_nowText]]];
        [obj setMethodResult:@""];
        [obj setMethodType:@"POST"];
        [obj setCurrentCall:@"locationAudit"];
        
        [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
        [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
        [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
        [obj.MethodParameters setObject:selectedIDs forKey:@"items_present"];
        [obj.MethodParameters setObject:removedIDs forKey:@"items_missing"];
        [obj.MethodParameters setObject:[item locationnameText] forKey:@"locationname"];
        
        [obj initiateConnection];
    }
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [SVProgressHUD dismiss];
    [SVProgressHUD show];
}

-(IBAction)editButtonClick:(id)sender{
   /* if(editButton.selected)
    {
        //perform action
        NSLog(@"Seleted Index : %lu",(unsigned long)indexPathArray.count);
        NSString *sellocID = [NSString string];
        NSString *removelocID = [NSString string];
        Item *item;
        NSIndexPath *selIndexPath;
        NSIndexPath *removeIndexPath;
        
        if (selectedIndexArray.count > 0) {
            selIndexPath = [selectedIndexArray objectAtIndex:0];
            [indexPathArray removeObject:selIndexPath];
            item = [[resltItemObj items] objectAtIndex:selIndexPath.row];
            sellocID = [item itemidText];
            
            for (int i = 1; i < [selectedIndexArray count]; i++) {
                selIndexPath = [selectedIndexArray objectAtIndex:i];
                item = [[resltItemObj items] objectAtIndex:selIndexPath.row];
                sellocID = [sellocID stringByAppendingString:[NSString stringWithFormat:@",%@",[item itemidText]]];
                
                // NSLog(@"select -- %@",[item modelText]);
                //[indexPathArray removeObjectAtIndex:selIndexPath.row];
                [indexPathArray removeObject:selIndexPath];
            }
        }
        if (indexPathArray.count > 0) {
            removeIndexPath = [indexPathArray objectAtIndex:0];
            
            item = [[resltItemObj items] objectAtIndex:removeIndexPath.row];
            removelocID = [item itemidText];
            
            for (int j = 1; j < [indexPathArray count]; j++) {
                removeIndexPath = [indexPathArray objectAtIndex:j];
                item = [[resltItemObj items] objectAtIndex:removeIndexPath.row];
                removelocID = [removelocID stringByAppendingString:[NSString stringWithFormat:@",%@",[item itemidText]]];
                // NSLog(@"remove -- %@",[item modelText]);
                
            }
        }
        
        NSLog(@"%@",sellocID);
        NSLog(@"%@",removelocID);
        
        [self submitAudit:sellocID :removelocID];
        
    }
    else
    {
        [selectedIndexArray removeAllObjects];
    }*/
    
    //perform action
    NSLog(@"Seleted Index : %lu",(unsigned long)indexPathArray.count);
    NSString *sellocID = [NSString string];
    NSString *removelocID = [NSString string];
    Item *item;
    NSIndexPath *selIndexPath;
    NSIndexPath *removeIndexPath;
    
    if (selectedIndexArray.count > 0) {
        selIndexPath = [selectedIndexArray objectAtIndex:0];
        [indexPathArray removeObject:selIndexPath];
        item = [[resltItemObj items] objectAtIndex:selIndexPath.row];
        sellocID = [item itemidText];
        
        for (int i = 1; i < [selectedIndexArray count]; i++) {
            selIndexPath = [selectedIndexArray objectAtIndex:i];
            item = [[resltItemObj items] objectAtIndex:selIndexPath.row];
            sellocID = [sellocID stringByAppendingString:[NSString stringWithFormat:@",%@",[item itemidText]]];
            
            // NSLog(@"select -- %@",[item modelText]);
            //[indexPathArray removeObjectAtIndex:selIndexPath.row];
            [indexPathArray removeObject:selIndexPath];
        }
    }
    if (indexPathArray.count > 0) {
        removeIndexPath = [indexPathArray objectAtIndex:0];
        
        item = [[resltItemObj items] objectAtIndex:removeIndexPath.row];
        removelocID = [item itemidText];
        
        for (int j = 1; j < [indexPathArray count]; j++) {
            removeIndexPath = [indexPathArray objectAtIndex:j];
            item = [[resltItemObj items] objectAtIndex:removeIndexPath.row];
            removelocID = [removelocID stringByAppendingString:[NSString stringWithFormat:@",%@",[item itemidText]]];
            // NSLog(@"remove -- %@",[item modelText]);
            
        }
    }
    
    NSLog(@"%@",sellocID);
    NSLog(@"%@",removelocID);
    
    [self submitAudit:sellocID :removelocID];
    
    //editButton.selected=!editButton.selected;
    //[searchTable reloadData];
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
    cell.textLabel.textColor = [UIColor darkGrayColor];
    [cell setTintColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    cell.textLabel.text = tittleStr;
    
    [indexPathArray addObject:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if([selectedIndexArray containsObject:indexPath]){
        cell.accessoryView = [[UIImageView alloc] initWithImage:
                              [UIImage imageNamed:@"check.png"]];
        cell.backgroundColor = [hexColor colorFromHexString:@"#8dc97d" alpha:1.0];
    }
    else{
        cell.accessoryView = [[UIImageView alloc] initWithImage:
                              [UIImage imageNamed:@"uncheck.png"]];
        cell.backgroundColor = [hexColor colorFromHexString:@"#ffbdbd" alpha:1.0];
    }

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
    
    UITableViewCell *cell=[searchTable cellForRowAtIndexPath:indexPath];
    if([selectedIndexArray containsObject:indexPath])
    {
        cell.accessoryView = [[UIImageView alloc] initWithImage:
                              [UIImage imageNamed:@"uncheck.png"]];
        cell.backgroundColor = [hexColor colorFromHexString:@"#ffbdbd" alpha:1.0];
        [selectedIndexArray removeObject:indexPath];
    }
    else
    {
        cell.accessoryView = [[UIImageView alloc] initWithImage:
                              [UIImage imageNamed:@"check.png"]];
        cell.backgroundColor = [hexColor colorFromHexString:@"#8dc97d" alpha:1.0];
        [selectedIndexArray addObject:indexPath];
    }
}

#pragma mark -
#pragma mark WebServiceHelper delegate method
-(void)WebServiceHelper:(WebServiceHelper *)editor didFinishWithResult:(BOOL)result{
    [SVProgressHUD dismiss];
	if (result)
	{
        if ([[editor currentCall] isEqualToString:@"locationAudit"])
        {
            NSLog(@"result -- %@",[[editor ReturnStr] JSONValue]);
            [[[UIAlertView alloc] initWithTitle:@"Success !" message:@"Audit Data Uploaded." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            NSArray *array = [self.navigationController viewControllers];
            [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];

        }
    }
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

@end
