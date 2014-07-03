//
//  AppData.h
//  iworkaudit
//
//  Created by Brijendra Tiwari on 30/04/14.
//  Copyright (c) 2014 Brijendra Tiwari. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define APP_URL				        @"http://www.ignisitsolutions.com/iwa/index.php/appV2/"

//#define APP_URL				        @"http://dev.ictracker.co.uk/iwa/index.php/appV2/"

//#define APP_URL				        @"https://www.iworkaudit.com.au/iwa/index.php/appV2_new"

//#define APP_URL_IMAGE				@"http://dev.ictracker.co.uk/iwa/"

#define USER_DEFULTS                [NSUserDefaults standardUserDefaults]
#define TimeStamp [NSString stringWithFormat:@"%f",[[NSDate new] timeIntervalSince1970] * 1000]

#define CORBEL_FONT @"Arial"
#define CORBEL_FONT_BOLD @"Arial-Bold"
#define FONT_COLOR @"#ffcd33"


#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )


@interface AppData : NSObject{
    NSString *deshboardNavType;
    NSMutableArray *manufactureArr;
    UIActivityIndicatorView *loaderindicator;
}

@property(nonatomic, retain)  NSString *deshboardNavType;
@property(nonatomic, retain)  NSMutableArray *manufactureArr;
@property(nonatomic, retain)  NSString *nickname;
@property(nonatomic, retain)  NSString *password;
@property(nonatomic, retain)  NSString *levelname;
@property(nonatomic, retain)  NSString *accountname;
@property(nonatomic, retain)  NSString *username;
@property(nonatomic, retain)  NSString *photopath;
@property(nonatomic, retain)  NSString *userID;
@property(nonatomic, retain)  NSString *countryName;

@property(nonatomic, retain)  NSString *apiURL;
@property(nonatomic, retain)  NSString *apiURL_IMAGE;
@property(nonatomic, retain)  NSString *apiURL_PDF;

+ (AppData *)sharedInstance;
- (void)callNoNetworkAlert;
-(NSString *)checkNetworkConnectivity;
-(void)setAPIdetails:(NSString *)areaStr;
- (UIImage *)fixrotation:(UIImage *)image;
//For ImagevIew Loader
-(void)setLoaderOnImageView:(UIImageView *)imageView;
-(void)removeLoader;
@end
