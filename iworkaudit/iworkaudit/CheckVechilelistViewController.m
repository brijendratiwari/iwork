//
//  CheckVechilelistViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 01/06/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "CheckVechilelistViewController.h"
#import "CheckVechicleCell.h"
#import "AppData.h"
#import "HexColorToUIColor.h"
#import "WebServiceHelper.h"
#import "SVProgressHUD.h"
#import "JSON.h"

@interface CheckVechilelistViewController ()<WebServiceHelperDelegate,CheckVechicleCellDelgate>{
    AppData *appDataObj;
    HexColorToUIColor *hexColor ;
    NSString *checkStr;
    BOOL ispassed;
    NSMutableArray *selectedIndexArray,*indexPathArray;
     BOOL iscloseEnable[100];
    NSMutableArray *notesArr;
}

@end

@implementation CheckVechilelistViewController
@synthesize checkListArr,vechicleID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    for (int k = 0; k < checkListArr.count; k++) {
        iscloseEnable[k] = YES;
        [notesArr addObject:@""];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    appDataObj = [AppData sharedInstance];
    
    ispassed = NO;
    
    hexColor = [[HexColorToUIColor alloc] init];
    
    selectedIndexArray=[[NSMutableArray alloc] init];
    indexPathArray = [[NSMutableArray alloc] init];
    
    notesArr = [[NSMutableArray alloc] init];

    
    [Itemstable setSeparatorColor:[UIColor clearColor]];
    [Itemstable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
    Itemstable.contentInset = inset;

}

-(IBAction)backToDeshboardView:(id)sender{
    NSArray *array = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
}

-(IBAction)backToPrevView:(id)sender{
    [[self navigationController] popViewControllerAnimated:YES];
}

-(void)submitAudit:(NSString *)selectedIDs :(NSString *)removedIDs :(NSMutableArray *)indArr{
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
        
        [obj setMethodName:[NSString stringWithFormat:@"vehiclechecks/%@",vechicleID]];
        [obj setMethodResult:@""];
        [obj setMethodType:@"POST"];
        [obj setCurrentCall:@"vehiclechecks"];
        
        [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
        [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
        [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
       
        
        [obj.MethodParameters setObject:@"" forKey:@"passed"];
        if (selectedIDs.length > 0) {
             [obj.MethodParameters setObject:selectedIDs forKey:@"passed"];
        }
        
        [obj.MethodParameters setObject:@"" forKey:@"failed"];
        if (removedIDs.length > 0) {
            [obj.MethodParameters setObject:removedIDs forKey:@"failed"];
        }
        
        if (indArr.count > 0) {
            for (int i= 0; i < indArr.count; i++) {
                NSIndexPath *indP = [indArr objectAtIndex:i];
                CheckVechicleCell *cell = (CheckVechicleCell *)[Itemstable cellForRowAtIndexPath:indP];
                
                if (cell.notesTxtV.text.length == 0) {
                    [[[UIAlertView alloc] initWithTitle:@"Error !" message:@"You must enter notes for any failed checks" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                    
                    return ;
                }
                
                [obj.MethodParameters setObject:cell.notesTxtV.text forKey:[NSString stringWithFormat:@"notes_%@",[[checkListArr objectAtIndex:indP.row] objectForKey:@"id"]]];
                
            }
        }
        
        
        [obj initiateConnection];
    }
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [SVProgressHUD dismiss];
    [SVProgressHUD show];
}


-(IBAction)completeAuditClick:(id)sender{
    //perform action
    NSLog(@"Seleted Index : %lu",(unsigned long)indexPathArray.count);
    NSString *sellocID = [NSString string];
    NSString *removelocID = [NSString string];
   
    NSMutableArray *itemArr = [NSMutableArray array];
    NSIndexPath *selIndexPath;
    NSIndexPath *removeIndexPath;
    
    if (selectedIndexArray.count > 0) {
        selIndexPath = [selectedIndexArray objectAtIndex:0];
        [indexPathArray removeObject:selIndexPath];
        itemArr = [checkListArr objectAtIndex:selIndexPath.row];
        sellocID = [itemArr valueForKey:@"id"];
        
        for (int i = 1; i < [selectedIndexArray count]; i++) {
            selIndexPath = [selectedIndexArray objectAtIndex:i];
            itemArr = [checkListArr objectAtIndex:selIndexPath.row];
            sellocID = [sellocID stringByAppendingString:[NSString stringWithFormat:@",%@",[itemArr valueForKey:@"id"]]];
            
             NSLog(@"select -- %@",[itemArr valueForKey:@"id"]);
            [indexPathArray removeObject:selIndexPath];
        }
    }
    
    if (indexPathArray.count > 0) {
        removeIndexPath = [indexPathArray objectAtIndex:0];
        
        itemArr = [checkListArr objectAtIndex:removeIndexPath.row];
        removelocID = [itemArr valueForKey:@"id"];
        
        for (int j = 1; j < [indexPathArray count]; j++) {
            removeIndexPath = [indexPathArray objectAtIndex:j];
            itemArr = [checkListArr objectAtIndex:removeIndexPath.row];
            removelocID = [removelocID stringByAppendingString:[NSString stringWithFormat:@",%@",[itemArr valueForKey:@"id"]]];
            NSLog(@"remove -- %@",[itemArr valueForKey:@"id"]);
            
        }
    }
    
    
    NSLog(@"%@",sellocID);
    NSLog(@"%@",removelocID);
    NSLog(@"%lu",(unsigned long)indexPathArray.count);
    
    [self submitAudit:sellocID :removelocID :indexPathArray];
//    for (int i=0; i<checkListArr.count; i++) {
//        [indexPathArray addObject:[[checkListArr objectAtIndex:i] objectForKey:@"id"]];
//    }

}

#pragma Mark - UITableViewDelegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [checkListArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *itemTableCellIdentifier = @"CheckVechicleCell";
    
    CheckVechicleCell *cell = (CheckVechicleCell *)[tableView dequeueReusableCellWithIdentifier:itemTableCellIdentifier];
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.ispassed = NO;
    
    if(![indexPathArray containsObject:indexPath])
    {
        [indexPathArray addObject:indexPath];
    }
    
    if([selectedIndexArray containsObject:indexPath]){
        cell.tittleName.selected = TRUE;
        
        cell.notesTxtV.alpha = 0.0;
        cell.noteslbl.alpha = 0.0;
        //cell.notesTxtV.text = @"";
    }
    else{
        cell.tittleName.selected = FALSE;
        cell.notesTxtV.alpha = 1.0;
        cell.noteslbl.alpha = 1.0;
       
    }
    
     cell.notesTxtV.text = [notesArr objectAtIndex:indexPath.row];
    
    [[cell tittleName] setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 28.0f:14.0f)]];
    [[cell tittleName] setTitleColor:[hexColor colorFromHexString:@"#353535" alpha:1.0] forState:UIControlStateNormal];
    NSString *strr = [[checkListArr objectAtIndex:indexPath.row] objectForKey:@"check_name"];
   // strr = [strr stringByAppendingString:[NSString stringWithFormat:@": %@",[[checkListArr objectAtIndex:indexPath.row] objectForKey:@"check_long_description"]]];
    
    [[cell tittleName] setTitle:strr forState:UIControlStateNormal];
    
    [cell notesTxtV].layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [cell notesTxtV].layer.borderWidth = 1.0f;
    [[cell notesTxtV] setTextColor:[hexColor colorFromHexString:@"#4C4C4C" alpha:1.0]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
}

-(void)selectCellTextView:(NSIndexPath *)indexPath{
    CheckVechicleCell *cell=(CheckVechicleCell *)[Itemstable cellForRowAtIndexPath:indexPath];
     NSLog(@"text - %@",cell.notesTxtV.text);
    
    if([selectedIndexArray containsObject:indexPath]){
        NSLog(@"remove");
        [notesArr removeObjectAtIndex:indexPath.row];
    }else{
        NSLog(@"add");
        [notesArr insertObject:cell.notesTxtV.text atIndex:indexPath.row];
    }
    
}

#pragma mark - ComplienceCheckCell DelegateMethods
-(void)selectCellItem:(NSString *)type indexPath:(NSIndexPath *)indexPath{
  
    CheckVechicleCell *cell=(CheckVechicleCell *)[Itemstable cellForRowAtIndexPath:indexPath];
      cell.tittleName.selected=!cell.tittleName.selected;
    
    if([selectedIndexArray containsObject:indexPath])
    {
        [selectedIndexArray removeObject:indexPath];
        cell.notesTxtV.alpha = 1.0;
        cell.noteslbl.alpha = 1.0;
        
        iscloseEnable[indexPath.row] = YES;
        
       // [notesArr insertObject:cell.notesTxtV.text atIndex:indexPath.row];
        
    }
    else
    {
        [selectedIndexArray addObject:indexPath];
        cell.notesTxtV.alpha = 0.0;
        cell.noteslbl.alpha = 0.0;
        
        iscloseEnable[indexPath.row] = NO;
       // [notesArr removeObjectAtIndex:indexPath.row];
    }
    
    [Itemstable beginUpdates];
    //[Itemstable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [Itemstable endUpdates];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (iscloseEnable[indexPath.row]) {
        if (IS_IPAD) {
            return 245.0f;
        }
        return 140.0f;
    }else{
        if (IS_IPAD) {
            return 80.0f;
        }
        return 40.0f;
    }
}

#pragma mark -
#pragma mark WebServiceHelper delegate method
-(void)WebServiceHelper:(WebServiceHelper *)editor didFinishWithResult:(BOOL)result{
    [SVProgressHUD dismiss];
	if (result)
	{
        if ([[editor currentCall] isEqualToString:@"vehiclechecks"])
        {
            NSLog(@"result -- %@",[[editor ReturnStr] JSONValue]);
            [[[UIAlertView alloc] initWithTitle:@"Success !" message:@"Vehicle Checks Successfully recorded." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
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
