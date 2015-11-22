//
//  KloudDataViewController.m
//  Kloud
//
//  Created by Devesh sharma on 21/11/15.
//  Copyright (c) 2015 Sandeep Malhotra. All rights reserved.
//

#import "KloudDataViewController.h"
#import "KloudWebserviceHelper.h"
#import "KoludDataListTableViewCell.h"
#import "LandDataListModel.h"
#define PERMITTED_TITLE_WIDTH 			304
#define PERMITTED_DESC_WIDTH				200

//Permitted widths are according to itmes width in cell xib

@interface KloudDataViewController ()<KloudWebserviceHelperDelegate>
{
	__weak IBOutlet UITableView *dataListTable;
	NSMutableArray *_dataListArray;
	NSString *_dataTitle ;
}

@end

@implementation KloudDataViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	_dataListArray = [[NSMutableArray alloc] init];
	dataListTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
	[self getKloudData];
}

-(void)getKloudData
{
	NSString *urlStr = @"https://dl.dropboxusercontent.com/u/746330/facts.json";
	NSURL *_url = [NSURL URLWithString:urlStr];

	KloudWebserviceHelper *webHelper = [[KloudWebserviceHelper alloc] initForGetMethodWithUrl:_url andParams:nil];
	webHelper.delegate = self;
	[webHelper start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
	[cell setBackgroundColor:[UIColor whiteColor]];
	if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
		[tableView setSeparatorInset:UIEdgeInsetsZero];
	}

	if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
		[tableView setLayoutMargins:UIEdgeInsetsZero];
	}

	if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
		[cell setLayoutMargins:UIEdgeInsetsZero];
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_dataListArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LandDataListModel *model = [_dataListArray objectAtIndex:indexPath.row];

	NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Medium" size:17.0]};
	CGRect rect = [model.title boundingRectWithSize:CGSizeMake(PERMITTED_TITLE_WIDTH, 10000.0)
														  options:NSStringDrawingUsesLineFragmentOrigin
													   attributes:attributes
														  context:nil];
	float titleHeight = rect.size.height;

	NSDictionary *attributes1 = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Medium" size:13.0]};
	CGRect rect1 = [model.dataDecription boundingRectWithSize:CGSizeMake(PERMITTED_DESC_WIDTH, 10000.0)
											options:NSStringDrawingUsesLineFragmentOrigin
										 attributes:attributes1
											context:nil];
	float desciptionHeight = rect1.size.height;
	if (desciptionHeight < 54.0)//54.0 is image height
	{
		desciptionHeight = 54.0;
	}

	float finalRowHeight = titleHeight+desciptionHeight +8+10+8;//8+10+8 is top in between and bottom gap of cell items
	return finalRowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"kKoludDataListTableViewCell";
	LandDataListModel *model = [_dataListArray objectAtIndex:indexPath.row];
	KoludDataListTableViewCell *cell =  (KoludDataListTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell)
 {
		cell =  (KoludDataListTableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"KoludDataListTableViewCell" owner:self options:nil] lastObject];
	}
	[cell setCellDataWithTitle:model.title andDesc:model.dataDecription andImageStr:model.imageUrl];
	return cell;
}

#pragma  mark -  KloudWebserviceHelperDelegate methods
-(void)onWebServiceSuccessResponse:(id)responseObject
{
	if ([responseObject isKindOfClass:[NSDictionary class]])
 	{
		NSDictionary *dict = responseObject;
		_dataTitle = [dict valueForKey:@"title"];
		dispatch_async(dispatch_get_main_queue(), ^{
			self.navigationItem.title = _dataTitle;
		});
		NSArray  *dataArray = [dict valueForKey:@"rows"];
		[self makeModelWithdataArray:dataArray];
	}
}

-(void)makeModelWithdataArray:(NSArray*)arr
{
	if ([_dataListArray count])
 	{
		[_dataListArray removeAllObjects];
	}

	for (NSDictionary *dict  in arr)
	{
		if (![dict valueForKey:@"title"] || [dict valueForKey:@"title"] == [NSNull null]) //Not showing which has no title
		{
			continue;
		}
		LandDataListModel *_model = [[LandDataListModel alloc] initWithDictionary:dict];
		[_dataListArray addObject:_model];
	}
	dispatch_async(dispatch_get_main_queue(), ^{
		[dataListTable reloadData];
	});
}

-(void)onWebServiceResponseFailedWithErrorCode:(int)errorCode andErrorMessage:(NSString *)errorMessage
{
	[[[UIAlertView alloc] initWithTitle:@"Kloud" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
