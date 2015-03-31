//
//  HLGroupCalloutView.m
//  HotelLook
//
//  Created by Anton Chebotov on 21/02/14.
//  Copyright (c) 2014 Anton Chebotov. All rights reserved.
//

#import "HLGroupCalloutView.h"
#import "HLGroupCalloutCell.h"

@interface HLGroupCalloutView () <UITableViewDataSource, UITableViewDelegate>
{
}
@property (weak) IBOutlet UITableView * tableView;
@property (weak) IBOutlet UIButton * cancelButton;
- (IBAction)cancel;
@end

@implementation HLGroupCalloutView

- (void) awakeFromNib
{
	[super awakeFromNib];
	_tableView.scrollsToTop = NO;
	[_tableView registerNib:[UINib nibWithNibName:@"HLGroupCalloutCell" bundle:nil] forCellReuseIdentifier:@"groupCalloutCell"];
}

- (void) setVariants:(NSArray *) newVariants
{
	_variants = newVariants;
	
	[_cancelButton setTitle:NSLocalizedString(@"HL_LOC_CLOSE_GROUP_CALLOUT", @"") forState:UIControlStateNormal];
	[_tableView reloadData];
	
	if(newVariants.count < 4){
		_tableView.scrollEnabled = NO;
	}
	else{
		_tableView.scrollEnabled = YES;
	}
}

- (IBAction)cancel
{
}


#pragma mark -
#pragma mark UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.variants.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HLGroupCalloutCell * cell = (HLGroupCalloutCell *)[tableView dequeueReusableCellWithIdentifier:@"groupCalloutCell"];
	cell.backgroundColor = [UIColor clearColor];
	HLResultVariant * variant = self.variants[indexPath.row];
	[cell setupWithVariant:variant];
	return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return HL_GROUP_CALLOUT_CELL_HEIGHT;
}

#pragma mark -
#pragma mark UITableViewDelegate Methods
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	HLResultVariant * variant = self.variants[indexPath.row];
	[_delegate showFullHotelInfo:variant];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
