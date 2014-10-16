//
//  ExhibitHallScheduleCell.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/19/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "ExhibitHallScheduleCell.h"

@implementation ExhibitHallScheduleCell

@synthesize scheduleDate;
@synthesize sessionName;
@synthesize sessionTime;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
