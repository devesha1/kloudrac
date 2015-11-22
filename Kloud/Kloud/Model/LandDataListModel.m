//
//  LandDataListModel.m
//  Kloud
//
//  Created by Devesh sharma on 22/11/15.
//  Copyright (c) 2015 Sandeep Malhotra. All rights reserved.
//

#import "LandDataListModel.h"
#import "CommonClasses.h"

NSString *const titleKey					=				@"title";
NSString *const descKey				=				@"description";
NSString *const imageKey				=				@"imageHref";

@implementation LandDataListModel

-(instancetype)initWithDictionary:(NSDictionary*)dict
{
	self = [super init];
	if (self)
	{
		_title = [CommonClasses checkForNull:[dict valueForKey:titleKey]];
		_dataDecription = [CommonClasses checkForNull:[dict valueForKey:descKey]];
		_imageUrl = [CommonClasses checkForNull:[dict valueForKey:imageKey]];
	}
	return self;
}

@end
