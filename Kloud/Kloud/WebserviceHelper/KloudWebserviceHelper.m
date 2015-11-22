//
//  KloudWebserviceHelper.m
//  Kloud
//
//  Created by Devesh sharma on 21/11/15.
//  Copyright (c) 2015 Sandeep Malhotra. All rights reserved.
//

#import "KloudWebserviceHelper.h"

NSString* const HTTPMethodTypeGetKey                							=       @"GET";
NSInteger const HTTPRequestTimeOutIntervalValue   						=       60;

@interface KloudWebserviceHelper ()
{
	NSURL *url;
}

@end

@implementation KloudWebserviceHelper

-(instancetype)initForGetMethodWithUrl:(NSURL*)dataurl andParams:(NSDictionary*)dict
{
	self = [super init];
	if (self) {
		url = dataurl;
	}
	return self;
}

-(void)start
{
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:url];
	request.HTTPMethod = HTTPMethodTypeGetKey;
	[request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
	[request setTimeoutInterval:HTTPRequestTimeOutIntervalValue];

	NSURLSession *session = [NSURLSession sharedSession];
	NSURLSessionDataTask *task = [session dataTaskWithRequest:request
										 completionHandler:
							   ^(NSData *data, NSURLResponse *response, NSError *error)
								  {
									  if (error)
									  {
										  if ([_delegate respondsToSelector:@selector(onWebServiceResponseFailedWithErrorCode:andErrorMessage:)]) {
											  [_delegate onWebServiceResponseFailedWithErrorCode:(int)[error code] andErrorMessage:[error localizedDescription]];
										  }
									  }
									  else  if ([response isKindOfClass:[NSHTTPURLResponse class]])
								   {
									   NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
									   int _responseCode 	=	(int)[httpResponse statusCode];

									   if (_responseCode == 200)
									   {
										   NSString* receivedString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
										   receivedString = [receivedString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];//response was not in proper formate
										   NSData *data1 = [receivedString dataUsingEncoding:NSUTF8StringEncoding];
										   NSError *jsonDictionaryError;
										   id responseObject = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:&jsonDictionaryError];

										   if ([_delegate respondsToSelector:@selector(onWebServiceSuccessResponse:)]) {
											   [_delegate onWebServiceSuccessResponse:responseObject];
										   }

									   }
									   else
									   {
										   if ([_delegate respondsToSelector:@selector(onWebServiceResponseFailedWithErrorCode:andErrorMessage:)]) {
											   [_delegate onWebServiceResponseFailedWithErrorCode:(int)[error code] andErrorMessage:[error localizedDescription]];
										   }
									   }
								   }
							   }];
 [task resume];
}

@end
