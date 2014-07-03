//
//  WebServiceHelper.m
//  NavDemo
//
//  Created by ajeet singh on 12/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WebServiceHelper.h"
#import "AppData.h"

@implementation WebServiceHelper

@synthesize MethodName;
@synthesize MethodParameters;
@synthesize XMLURLAddress;
@synthesize MethodResult;
@synthesize ReturnStr;
@synthesize MethodType;
@synthesize delegate;

@synthesize currentCall;


@synthesize myData;

- (void)initiateConnectionWithURL_GOOGLE
{
	 [self setXMLURLAddress:@"http://maps.googleapis.com/maps/api/"];
	
	XMLURLAddress=[XMLURLAddress stringByAppendingFormat:@"%@",MethodName];
	
	NSMutableString *sRequest = [[NSMutableString alloc] init];
	
	NSEnumerator *tableIterator = [MethodParameters keyEnumerator];
	NSString *keyID;
	while((keyID = [tableIterator nextObject]))
	{
		[sRequest appendString:[NSString stringWithFormat:@"%@=%@&", keyID,[MethodParameters objectForKey:keyID]]];
	}
    
//    NSURL *myWebserverURL = [NSURL URLWithString:[XMLURLAddress stringByAppendingFormat:@"?%@sensor=true&key=AIzaSyCViiuvu60o0MRojz6F9c1vv6h3Yqe6c9M",sRequest]];

    NSURL *myWebserverURL = [NSURL URLWithString:[XMLURLAddress stringByAppendingFormat:@"?%@sensor=true",sRequest]];

	
//    NSLog(@"Bundle %@",[[NSBundle mainBundle] bundleIdentifier]);
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:myWebserverURL];
	[request setTimeoutInterval:239];
	
	[request addValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setValue:@"application/json" forHTTPHeaderField:@"accept"];
	
	[request setHTTPMethod:@"GET"];
	
	[sRequest release];
	
	myData =[[NSMutableData alloc] init];
	
	[NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)initiateConnection
{
    objAppData = [AppData sharedInstance];
    
	self.isDidGetResponse = NO;
    [self setXMLURLAddress:[@"" stringByAppendingFormat:@"%@/", objAppData.apiURL]];
    
    NSString *urlString=[XMLURLAddress stringByAppendingFormat:@"%@", MethodName];
	
	
	NSMutableString *sRequest = [[NSMutableString alloc] init];
		
	NSEnumerator *tableIterator = [MethodParameters keyEnumerator];
	NSString *keyID;
	while((keyID = [tableIterator nextObject]))
	{
		[sRequest appendString:[NSString stringWithFormat:@"&%@=%@", keyID,[self getURLEncodedString:[MethodParameters objectForKey:keyID]]]];
    }
    if ([sRequest length]!=0) {
        
        NSRange range;
        range.location = 0;
        range.length = 1;
        [sRequest deleteCharactersInRange:range];
    }
    
    NSMutableURLRequest *request=nil;
    
    if ([MethodType isEqualToString:@"GET"]) {
     
        urlString=[urlString stringByAppendingFormat:@"?%@", sRequest];
        NSURL *myWebserverURL = [NSURL URLWithString:urlString];
        
        request = [NSMutableURLRequest requestWithURL:myWebserverURL];
        [request setTimeoutInterval:239];
        [request setHTTPMethod:@"GET"];
    }
    else {
        
        NSURL *myWebserverURL = [NSURL URLWithString:urlString];
        
        request = [NSMutableURLRequest requestWithURL:myWebserverURL];
        [request setTimeoutInterval:239];
        
        [request addValue:[[NSString alloc] initWithFormat:@"%lu",(unsigned long)[sRequest length]] forHTTPHeaderField:@"Content-Length"];
        
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[sRequest dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSLog(@"urlString -- %@",urlString);
    
    [sRequest release];
	
	myData =[[NSMutableData alloc] init];
	
	self.urlConnection=[NSURLConnection connectionWithRequest:request delegate:self];
	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[myData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
	[self setReturnStr:[[NSString alloc] initWithData:myData encoding:NSUTF8StringEncoding ]];
	if(delegate!=nil)
	{
        self.isDidGetResponse = YES;
		[delegate WebServiceHelper:self	didFinishWithResult:YES];
	}

}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	
	NSLog(@"%@",error);
	
	if(delegate!=nil)
	{
        self.isDidGetResponse = YES;
		[delegate WebServiceHelper:self	didFinishWithResult:NO];
	}
}

-(NSString *)getURLEncodedString:(NSString *)stringvalue{
	NSString * encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(
																				   NULL,
																				   (CFStringRef)stringvalue,
																				   NULL,
																				   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																				   kCFStringEncodingUTF8 );
	return encodedString;
}


-(void)dealloc
{
	
	[myData release];
    [super dealloc];
}
@end
