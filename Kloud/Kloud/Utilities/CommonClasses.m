//
//  CommonClasses.m
//  Kloud
//
//  Created by Devesh sharma on 22/11/15.
//  Copyright (c) 2015 Sandeep Malhotra. All rights reserved.
//

#import "CommonClasses.h"

@implementation CommonClasses

+(NSString*)checkForNull:(id)object
{
NSString *str = @"";
	if (!object || object == [NSNull null] ) {
		return str;
	}
	else
		return object;
}
@end
