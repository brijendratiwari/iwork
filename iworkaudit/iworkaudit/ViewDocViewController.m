//
//  ViewDocViewController.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 16/06/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "ViewDocViewController.h"
#import "ReaderViewController.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "AppData.h"
#import "HexColorToUIColor.h"

@interface ViewDocViewController ()<ReaderViewControllerDelegate>{
    AppData *appDataObj;
    HexColorToUIColor *hexColor;
    int scrollerHeight;
    UIActivityIndicatorView *spinner[100];
}

@end

@implementation ViewDocViewController
@synthesize pdfListArr,itemID;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)backToPrevView:(id)sender{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)viewDidLayoutSubviews
{
    [self.scroller setContentSize:CGSizeMake(320, (scrollerHeight+20))];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    hexColor = [[HexColorToUIColor alloc] init];
    
     appDataObj = [AppData sharedInstance];
    
    scrollerHeight = 0;
    
    if (pdfListArr.count == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"No pdf available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }else{
        
        
        if (IS_IPAD) {
            [self addPDFViewsforiPad];
        }else{
            [self addPDFViewsforiPhone];
        }
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [[self navigationController] popViewControllerAnimated:YES];
}

-(IBAction)backToDeshboardView:(id)sender{
    NSArray *array = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
}

-(void)addPDFViewsforiPad{
    int ypos = 20;
    int space = 20;
    int viewH = 86;
    scrollerHeight = 0;
    
    for (int i= 0; i < pdfListArr.count; i++) {
        UIView *viewaa = [[UIView alloc] initWithFrame:CGRectMake(141, ypos, 420, viewH)];
        viewaa.layer.borderWidth = 1.0f;
        viewaa.layer.borderColor = [[UIColor blackColor] CGColor];
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(35, 13, 58, 60)];
        imgV.image = [UIImage imageNamed:@"pdf_icon.png"];
        [viewaa addSubview:imgV];
        
        UIButton *buttn = [UIButton buttonWithType:UIButtonTypeCustom];
        buttn.frame = CGRectMake(123, 13, 266, 48);
        [buttn setTitle:[pdfListArr objectAtIndex:i] forState:UIControlStateNormal];
        buttn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        buttn.tag = i;
        [buttn setTitleColor:[hexColor colorFromHexString:@"#000000" alpha:1.0] forState:UIControlStateNormal];
        [buttn setFont:[UIFont fontWithName:CORBEL_FONT size:26.0f]];
        [buttn addTarget:self action:@selector(readPDF_ViewDoc:) forControlEvents:UIControlEventTouchUpInside];
        //[viewaa setBackgroundColor:[UIColor redColor]];
        [viewaa addSubview:buttn];
        
        spinner[i] = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner[i].frame = CGRectMake(35, 13, 58, 60);
        spinner[i].hidesWhenStopped = YES;
        spinner[i].backgroundColor = [UIColor lightGrayColor];
        [viewaa bringSubviewToFront:spinner[i]];
        
        [viewaa addSubview:spinner[i]];

        
        
        [[self scroller] addSubview:viewaa];
        ypos = ypos+viewH+space;
        scrollerHeight = ypos+viewH+space;
    }

}


-(void)addPDFViewsforiPhone{
    
    int ypos = 10;
    int space = 10;
    int viewH = 43;
    scrollerHeight = 0;
    
    for (int i= 0; i < pdfListArr.count; i++) {
        UIView *viewaa = [[UIView alloc] initWithFrame:CGRectMake(30, ypos, 260, viewH)];
        viewaa.layer.borderWidth = 1.0f;
        viewaa.layer.borderColor = [[UIColor blackColor] CGColor];
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 6, 29, 30)];
        imgV.image = [UIImage imageNamed:@"pdf_icon.png"];
        [viewaa addSubview:imgV];
        
        UIButton *buttn = [UIButton buttonWithType:UIButtonTypeCustom];
        buttn.frame = CGRectMake(62, 11, 173, 20);
        [buttn setTitle:[pdfListArr objectAtIndex:i] forState:UIControlStateNormal];
        buttn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        buttn.tag = i;
        [buttn setTitleColor:[hexColor colorFromHexString:@"#000000" alpha:1.0] forState:UIControlStateNormal];
        [buttn setFont:[UIFont fontWithName:CORBEL_FONT size:13.0f]];
        [buttn addTarget:self action:@selector(readPDF_ViewDoc:) forControlEvents:UIControlEventTouchUpInside];
        //[viewaa setBackgroundColor:[UIColor redColor]];
        [viewaa addSubview:buttn];
        
        spinner[i] = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner[i].frame = CGRectMake(20, 6, 29, 30);
        spinner[i].hidesWhenStopped = YES;
        spinner[i].backgroundColor = [UIColor lightGrayColor];
        [viewaa bringSubviewToFront:spinner[i]];
        
        [viewaa addSubview:spinner[i]];
        
        
        [[self scroller] addSubview:viewaa];
        ypos = ypos+viewH+space;
        scrollerHeight = ypos+viewH+space;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)readPDF_ViewDoc:(UIButton *)btn{
    NSLog(@"tag - %ld",(long)btn.tag);
    
    [spinner[btn.tag] startAnimating];
    
    if (!networkQueue) {
		networkQueue = [[ASINetworkQueue alloc] init];
	}
	[networkQueue reset];
	//[networkQueue setDownloadProgressDelegate:progressIndicator];
	[networkQueue setRequestDidFinishSelector:@selector(pdfFetchComplete_Doc:)];
	[networkQueue setRequestDidFailSelector:@selector(pdfFetchFailed_Doc:)];
	//[networkQueue setShowAccurateProgress:[accurateProgress isOn]];
	[networkQueue setDelegate:self];
    
    ASIHTTPRequest *request;
    NSString *strURL = [NSString stringWithFormat:@"%@/%@/%@",appDataObj.apiURL_PDF,self.itemID,[self.pdfListArr objectAtIndex:btn.tag]];
    
    NSString* encodedUrl = [strURL stringByAddingPercentEscapesUsingEncoding:
                            NSASCIIStringEncoding];
    
    NSLog(@"PDF URL - %@",encodedUrl);
    
    request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:encodedUrl]];
	[request setDownloadDestinationPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[self.pdfListArr objectAtIndex:btn.tag]]];
	//[request setDownloadProgressDelegate:progressView[btn.tag]];
    request.tag = btn.tag;
    [request setUserInfo:[NSDictionary dictionaryWithObject:[self.pdfListArr objectAtIndex:btn.tag] forKey:@"name"]];
	[networkQueue addOperation:request];
	
	[networkQueue go];
    
}

- (void)pdfFetchFailed_Doc:(ASIHTTPRequest *)request
{
    [spinner[request.tag] stopAnimating];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Download failed" message:@"Failed to download files" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] ;
    [alertView show];
}


- (void)pdfFetchComplete_Doc:(ASIHTTPRequest *)request
{
     [spinner[request.tag] stopAnimating];
    
    ReaderDocument *document = [ReaderDocument withDocumentFilePath:[request downloadDestinationPath] password:nil];
    
	if (document != nil)
	{
		ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
        
		readerViewController.delegate = self;
        
        readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
		readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        
		[self presentViewController:readerViewController animated:YES completion:NULL];
    }
}



- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
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
