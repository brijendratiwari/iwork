//
//  AppData.m
//  iworkaudit
//
//  Created by Brijendra Tiwari on 30/04/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import "AppData.h"
#import "Reachability.h"

static AppData *sharedObj;

@implementation AppData
@synthesize deshboardNavType;
@synthesize manufactureArr;
@synthesize nickname,password,levelname,accountname,username,photopath;
@synthesize apiURL,apiURL_IMAGE,apiURL_PDF,userID,countryName;

+ (AppData *)sharedInstance
{
    if(sharedObj == nil)
    {
        sharedObj = [[AppData alloc] init];
    }
    return sharedObj;
}

-(void)callNoNetworkAlert
{
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Internet Connection." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
}

-(NSString *)checkNetworkConnectivity
{
	NSString *networkValue = nil;
    NSLog(@"tets- %@",[Reachability reachabilityForInternetConnection]);
	if(![Reachability reachabilityForInternetConnection])
	{
		networkValue = @"NoAccess";
	}
	return networkValue;
}

-(void)setAPIdetails:(NSString *)areaStr{
    
    if ([areaStr isEqualToString:@"Australia"]) {

        /*
        [self setApiURL:@"http://dev.ictracker.co.uk/iwa/index.php/appV2"];
        [self setApiURL_IMAGE:@"http://dev.ictracker.co.uk/iwa/"];
        [self setApiURL_PDF:@"http://dev.ictracker.co.uk/iwa/index.php/items/pdf_download/iwauk_docs"];
         */
        
        self.countryName = @"au";
        
        [self setApiURL:@"http://devapp.iworkaudit.com.au/iwa/index.php/appV2"];
        [self setApiURL_IMAGE:@"http://devapp.iworkaudit.com.au/iwa/"];
        [self setApiURL_PDF:@"http://devapp.iworkaudit.com.au/iwa/index.php/items/pdf_download/iwauk_docs"];
        
    }else{
        /*
        [self setApiURL:@"http://dev.ictracker.co.uk/iwa/index.php/appV2"];
        [self setApiURL_IMAGE:@"http://dev.ictracker.co.uk/iwa/"];
        [self setApiURL_PDF:@"http://dev.ictracker.co.uk/iwa/index.php/items/pdf_download/iwauk_docs"];
        */
        
        self.countryName = @"uk";
        
        [self setApiURL:@"http://devapp.iworkaudit.com/iwa/index.php/appV2"];
        [self setApiURL_IMAGE:@"http://devapp.iworkaudit.com/iwa/"];
        [self setApiURL_PDF:@"http://devapp.iworkaudit.com/iwa/index.php/items/pdf_download/iwauk_docs"];
        
        
    }
    
    NSLog(@"API URL - %@",apiURL);
    
}

- (UIImage *)fixrotation:(UIImage *)image{
    
    if (image.imageOrientation == UIImageOrientationUp) return image;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
    
}
//Set Loader on ImageView
-(void)setLoaderOnImageView:(UIImageView *)imageView
{
    if(loaderindicator==nil)
    {
        loaderindicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    loaderindicator.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |                                        UIViewAutoresizingFlexibleRightMargin |                                        UIViewAutoresizingFlexibleTopMargin |                                        UIViewAutoresizingFlexibleBottomMargin);
    loaderindicator.center = CGPointMake(CGRectGetWidth(imageView.bounds)/2, CGRectGetHeight(imageView.bounds)/2);
    [loaderindicator startAnimating];
 
    [imageView addSubview:loaderindicator];
}
-(void)removeLoader
{
    [loaderindicator removeFromSuperview];
}

@end
