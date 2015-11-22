//
//  KoludDataListTableViewCell.h
//  Kloud
//
//  Created by Devesh sharma on 21/11/15.
//  Copyright (c) 2015 Sandeep Malhotra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LandDataListModel.h"
@interface KoludDataListTableViewCell : UITableViewCell
-(void)setCellDataWithTitle:(NSString*)title andDesc:(NSString*)desc andImageStr:(NSString*)imageStr;
@end
