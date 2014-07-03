//
//  ComplienceCheckViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 06/05/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "ComplienceCheckViewController.h"
#import "AppData.h"
#import "HexColorToUIColor.h"
#import "WebServiceHelper.h"
#import "JSON.h"
#import "SVProgressHUD.h"
#import "ComplienceCheckCell.h"
#import "UIImageView+WebCache.h"

@interface ComplienceCheckViewController ()<WebServiceHelperDelegate,ComplienceCheckCellDelgate>{
     AppData *appDataObj;
     NSMutableArray *checkItemsArr;
     HexColorToUIColor *hexColor ;
    NSString *checkStr;
    BOOL ispassed;
    NSMutableArray *complnIDArr,*selectedIndexArray;
    NSMutableArray *indxpathArr;
    BOOL isReadMoreButtonTouched[100];
    
    BOOL iscloseEnable[100];
    
    int indexOfReadMoreButton ;
}

@end

@implementation ComplienceCheckViewController
@synthesize item;

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
    
    appDataObj = [AppData sharedInstance];
    complnIDArr = [[NSMutableArray alloc] init];
    selectedIndexArray=[[NSMutableArray alloc] init];
    
    
    
    ispassed = NO;
    
    checkItemsArr = [[NSMutableArray alloc] init];
     hexColor = [[HexColorToUIColor alloc] init];
    
    //[productNamelbl setFont:[UIFont fontWithName:CORBEL_FONT_BOLD size:15.0f]];
    [productNamelbl setTextColor:[hexColor colorFromHexString:@"#555555" alpha:1.0]];
    
    //[productCodelbl setFont:[UIFont fontWithName:CORBEL_FONT size:15.0f]];
    [productCodelbl setTextColor:[hexColor colorFromHexString:@"#555555" alpha:1.0]];
    
    [windowuplbl setFont:[UIFont fontWithName:CORBEL_FONT size:14.0f]];
    [windowuplbl setTextColor:[hexColor colorFromHexString:@"#353535" alpha:1.0]];
    
    [updatelbl setFont:[UIFont fontWithName:CORBEL_FONT size:14.0f]];
    [updatelbl setTextColor:[hexColor colorFromHexString:@"#353535" alpha:1.0]];
    
    [OSlbl setFont:[UIFont fontWithName:CORBEL_FONT size:14.0f]];
    [OSlbl setTextColor:[hexColor colorFromHexString:@"#353535" alpha:1.0]];
    
    [checktittlelbl setFont:[UIFont fontWithName:CORBEL_FONT size:14.0f]];
    [checktittlelbl setTextColor:[hexColor colorFromHexString:@"#353535" alpha:1.0]];
    
    [mouselbl setFont:[UIFont fontWithName:CORBEL_FONT size:14.0f]];
    [mouselbl setTextColor:[hexColor colorFromHexString:@"#353535" alpha:1.0]];
    
    productNamelbl.text = [NSString stringWithFormat:@"%@ %@",[item manufacturerText],[item modelText]] ;
    productCodelbl.text = [item categorynameText];
    
    profilePic.layer.borderColor = [[hexColor colorFromHexString:FONT_COLOR alpha:1.0] CGColor];
    profilePic.layer.borderWidth = 1.0f;
    
    
    AppData *appData=[AppData sharedInstance];
    [appData setLoaderOnImageView:profilePic];
    if ([[item itemphotopathText] length] != 0) {
//        profilePic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",appDataObj.apiURL_IMAGE,[item itemphotopathText]]]]];
        [profilePic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",appDataObj.apiURL_IMAGE,[item itemphotopathText]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            [appData removeLoader];
        }];
    }
    
    //[Itemstable setSeparatorColor:[hexColor colorFromHexString:FONT_COLOR alpha:1.0]];
    [Itemstable setSeparatorColor:[UIColor clearColor]];
    [Itemstable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
    Itemstable.contentInset = inset;
    
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
        
        [obj setMethodName:[NSString stringWithFormat:@"compliancechecks/%@",[item itemidText]]];
        [obj setMethodResult:@""];
        [obj setMethodType:@"POST"];
        [obj setCurrentCall:@"compliancechecks"];
        
        [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
        [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
        [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
    
        [obj initiateConnection];
    }
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [SVProgressHUD dismiss];
    [SVProgressHUD show];
}


-(IBAction)backToPrevView:(id)sender{
    [[self navigationController] popViewControllerAnimated:YES];
}


-(void)submitDataFromserver:(NSString *)passID : (NSString *)failID :(NSMutableArray *)indArr{

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
        
        [obj setMethodName:[NSString stringWithFormat:@"compliancechecks/%@",[item itemidText]]];
        [obj setMethodResult:@""];
        [obj setMethodType:@"POST"];
        [obj setCurrentCall:@"compliancesubmit"];
        
        [obj.MethodParameters setObject:appDataObj.username forKey:@"username"];
        [obj.MethodParameters setObject:appDataObj.password forKey:@"password"];
        [obj.MethodParameters setObject:TimeStamp forKey:@"timestamp"];
        
        [obj.MethodParameters setObject:@"" forKey:@"passed"];
        if (passID.length > 0) {
            [obj.MethodParameters setObject:passID forKey:@"passed"];
        }
        
        [obj.MethodParameters setObject:@"" forKey:@"failed"];
        if (failID.length > 0) {
            [obj.MethodParameters setObject:failID forKey:@"failed"];
        }
        
        
        if (indArr.count > 0) {
            for (int i= 0; i < indArr.count; i++) {
                NSIndexPath *indP = [indArr objectAtIndex:i];
                ComplienceCheckCell *cell = (ComplienceCheckCell *)[Itemstable cellForRowAtIndexPath:indP];
                
                if (cell.notesTxtV.text.length == 0) {
                    [[[UIAlertView alloc] initWithTitle:@"Error !" message:@"You must enter notes for any failed checks" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                    
                    return ;
                }
                
                NSLog(@"ttest -- %@ -- %@",[[checkItemsArr objectAtIndex:indP.row] objectForKey:@"test_id"],cell.notesTxtV.text);
                
                [obj.MethodParameters setObject:cell.notesTxtV.text forKey:[NSString stringWithFormat:@"notes_%@",[[checkItemsArr objectAtIndex:indP.row] objectForKey:@"test_id"]]];
                
            }
        }
        
        [obj initiateConnection];
    }
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [SVProgressHUD dismiss];
    [SVProgressHUD show];
    
}

- (IBAction)submitComplience:(id)sender {
    
    
    [complnIDArr removeAllObjects];
    for (int i = 0; i<checkItemsArr.count; i++) {
        [complnIDArr addObject:[[checkItemsArr objectAtIndex:i] valueForKey:@"test_id"]];
    }
    
    //perform action
    NSLog(@"Seleted Index : %lu",(unsigned long)complnIDArr.count);
    NSString *sellocID = [NSString string];
    NSString *removelocID = [NSString string];
    
    NSMutableArray *indxArr = (NSMutableArray *)indxpathArr;
    
    NSIndexPath *selIndexPath;
    
    if (selectedIndexArray.count > 0) {
        selIndexPath = [selectedIndexArray objectAtIndex:0];
        sellocID = [complnIDArr objectAtIndex:selIndexPath.row];
        
         [indxArr removeObject:selIndexPath];
        
        for (int i = 1; i < [selectedIndexArray count]; i++) {
            
            selIndexPath = [selectedIndexArray objectAtIndex:i];
            
             [indxArr removeObject:selIndexPath];
            
            sellocID = [sellocID stringByAppendingString:[NSString stringWithFormat:@",%@",[complnIDArr objectAtIndex:selIndexPath.row]]];
        }
        
        if (sellocID.length > 0) {
            NSArray * arr = [sellocID componentsSeparatedByString:@","];
            for (int j=0; j<arr.count; j++) {
                [complnIDArr removeObject:[arr objectAtIndex:j]];
            }
        }
    }
    
    if (complnIDArr.count > 0) {
        
        removelocID = [complnIDArr objectAtIndex:0];
        
        for (int i = 1; i < [complnIDArr count]; i++) {
           
            removelocID = [removelocID stringByAppendingString:[NSString stringWithFormat:@",%@",[complnIDArr objectAtIndex:i]]];
        }
    }
    
    NSLog(@"indxArr -- %@",indxArr);
    
    NSLog(@"remove -- %@",removelocID);
    NSLog(@"select -- %@",sellocID);

    [self submitDataFromserver:sellocID :removelocID :indxArr];
    
}


-(IBAction)backToDeshboardView:(id)sender{
    NSArray *array = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma Mark - UITableViewDelegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [checkItemsArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *itemTableCellIdentifier = @"ComplienceCheckCell";
    
    ComplienceCheckCell *cell = (ComplienceCheckCell *)[tableView dequeueReusableCellWithIdentifier:itemTableCellIdentifier];
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.ispassed = NO;
    
        if([selectedIndexArray containsObject:indexPath]){
            cell.tittleName.selected = TRUE;
           
            cell.notesTxtV.alpha = 0.0;
            cell.noteslbl.alpha = 0.0;
        }
        else{
            cell.tittleName.selected = FALSE;
            cell.notesTxtV.alpha = 1.0;
            cell.noteslbl.alpha = 1.0;
        }

    
    [[cell tittleName] setFont:[UIFont fontWithName:CORBEL_FONT size:(IS_IPAD ? 28.0f:14.0f)]];
    [[cell tittleName] setTitleColor:[hexColor colorFromHexString:@"#353535" alpha:1.0] forState:UIControlStateNormal];
    
    [[cell tittleName] setTitle:[NSString stringWithFormat:@"  %@",[[checkItemsArr objectAtIndex:indexPath.row] objectForKey:@"test_name"]] forState:UIControlStateNormal];
    
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

#pragma mark - ComplienceCheckCell DelegateMethods
-(void)selectCellItem:(NSString *)type indexPath:(NSIndexPath *)indexPath{
    NSLog(@"index path-- %@",[[checkItemsArr objectAtIndex:indexPath.row] objectForKey:@"test_id"]);
    checkStr = [[checkItemsArr objectAtIndex:indexPath.row] objectForKey:@"test_id"];
   
    ComplienceCheckCell *cell = (ComplienceCheckCell *)[Itemstable cellForRowAtIndexPath:indexPath];
    indexOfReadMoreButton = (int)[indexPath row];
     cell.tittleName.selected=!cell.tittleName.selected;
    
    if([selectedIndexArray containsObject:indexPath])
    {
        [selectedIndexArray removeObject:indexPath];
        cell.notesTxtV.alpha = 1.0;
        cell.noteslbl.alpha = 1.0;
        
        iscloseEnable[indexPath.row] = YES;
    }
    else
    {
        [selectedIndexArray addObject:indexPath];
        cell.notesTxtV.alpha = 0.0;
        cell.noteslbl.alpha = 0.0;
        
        iscloseEnable[indexPath.row] = NO;
       
    }
    
    [Itemstable beginUpdates];
   // [Itemstable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
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
        if ([[editor currentCall] isEqualToString:@"compliancechecks"])
        {
            NSLog(@"result -- %@",[[editor ReturnStr] JSONValue]);
            NSDictionary *result = [[editor ReturnStr] JSONValue];
          
            if ([[result valueForKey:@"checks"] count] != 0) {
                if (checkItemsArr.count != 0) {
                    [checkItemsArr removeAllObjects];
                }
                
                checkItemsArr = [result objectForKey:@"checks"];
                NSLog(@"test - %@",[[checkItemsArr objectAtIndex:0] objectForKey:@"test_name"]);
                
                indxpathArr = [NSMutableArray array];
                
                for (int k = 0; k < checkItemsArr.count; k++) {
                    [indxpathArr addObject:[NSIndexPath indexPathForRow:k inSection:0]];
                     isReadMoreButtonTouched[k]=YES;
                    iscloseEnable[k] = YES;
                }
              
                [Itemstable reloadData];
                
            }else{
                [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"Not Found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            }
        }else if ([[editor currentCall] isEqualToString:@"compliancesubmit"]) {
            NSLog(@"result -- %@",[[editor ReturnStr] JSONValue]);
            [[[UIAlertView alloc] initWithTitle:@"Success !" message:@"Item Compliance checks Successfully recorded" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
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
