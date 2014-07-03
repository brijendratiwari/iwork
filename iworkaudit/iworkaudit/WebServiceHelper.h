//
//  WebServiceHelper.h
//  NavDemo
//
//  Created by ajeet singh on 12/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebServiceHelperDelegate;
@class AppData;

@interface WebServiceHelper : NSObject {
	
	BOOL ReturnStrFound;
    AppData *objAppData;
}

@property(nonatomic, copy) NSString *XMLURLAddress;
@property(nonatomic, copy) NSString *MethodName;
@property(nonatomic, retain) NSMutableDictionary *MethodParameters;
@property(nonatomic,copy) NSString *MethodResult;
@property(nonatomic,copy) NSString *MethodType;
@property(nonatomic,copy) NSString *ReturnStr;

@property(nonatomic,assign) id<WebServiceHelperDelegate> delegate;

@property(nonatomic,copy) NSString *currentCall;

@property(nonatomic,retain) NSMutableData *myData;
@property(nonatomic,retain) NSURLConnection *urlConnection;
@property (nonatomic) BOOL isDidGetResponse;

-(void)initiateConnection;
- (void)initiateConnectionWithURL_GOOGLE;
-(NSString *)getURLEncodedString:(NSString *)stringvalue;
@end

@protocol WebServiceHelperDelegate
-(void)WebServiceHelper:(WebServiceHelper *)editor didFinishWithResult:(BOOL)result;
@end