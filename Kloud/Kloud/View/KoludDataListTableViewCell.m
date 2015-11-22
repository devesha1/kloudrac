//
//  KoludDataListTableViewCell.m
//  Kloud
//
//  Created by Devesh sharma on 21/11/15.
//  Copyright (c) 2015 Sandeep Malhotra. All rights reserved.
//

#import "KoludDataListTableViewCell.h"
#import "UIImageView+cellImageView.h"

@interface	KoludDataListTableViewCell()
{
	__weak IBOutlet UIImageView *cellImageView;
	__weak IBOutlet UILabel *cellTitleLabel;
	__weak IBOutlet UILabel *cellDescLabel;
}
@end

@implementation KoludDataListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellDataWithTitle:(NSString*)title andDesc:(NSString*)desc andImageStr:(NSString*)imageStr;
{
	cellTitleLabel.text = title;
	cellDescLabel.text = desc;
	[cellImageView setImageWithUrlStr:imageStr];
}

@end
