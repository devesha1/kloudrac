//
//  KloudWebserviceHelper.h
//  Kloud
//
//  Created by Devesh sharma on 21/11/15.
//  Copyright (c) 2015 Sandeep Malhotra. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KloudWebserviceHelperDelegate <NSObject>

-(void)onWebServiceSuccessResponse:(id)responseObject;
-(void)onWebServiceResponseFailedWithErrorCode:(int)errorCode andErrorMessage:(NSString*)errorMessage;

@end

@interface KloudWebserviceHelper : NSObject
-(instancetype)initForGetMethodWithUrl:(NSURL*)dataurl andParams:(NSDictionary*)dict;
@property(nonatomic,weak)id<KloudWebserviceHelperDelegate>delegate;
-(void)start;
@end
