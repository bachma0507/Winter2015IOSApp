//
//  ExhibitHallScheduleCell.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/19/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExhibitHallScheduleCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *scheduleDate;
@property (nonatomic, strong) IBOutlet UILabel *sessionName;
@property (nonatomic, strong) IBOutlet UILabel *sessionTime;

@end
