//
//  UIImageView+cellImageView.m
//  Kloud
//
//  Created by Devesh sharma on 22/11/15.
//  Copyright (c) 2015 Sandeep Malhotra. All rights reserved.
//

#import "UIImageView+cellImageView.h"

@implementation UIImageView (cellImageView)

-(void)setImageWithUrlStr:(NSString*)imageUrl
{
	NSString *imageStr = imageUrl;
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

		NSURL *_imageUrl = [NSURL URLWithString:imageStr];
		NSData *imageData = [NSData dataWithContentsOfURL:_imageUrl];
		UIImage *_image = [UIImage imageWithData:imageData];

		dispatch_async(dispatch_get_main_queue(), ^{
			[self setImage:nil];
			[self setImage:_image];
		});
	});
}
@end
