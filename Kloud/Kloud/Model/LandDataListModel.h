//
//  LandDataListModel.h
//  Kloud
//
//  Created by Devesh sharma on 22/11/15.
//  Copyright (c) 2015 Sandeep Malhotra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LandDataListModel : NSObject
-(instancetype)initWithDictionary:(NSDictionary*)dict;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *dataDecription;
@property (nonatomic,strong) NSString *imageUrl;
@end
