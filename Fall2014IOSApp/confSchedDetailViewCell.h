//
//  confSchedDetailViewCell.h
//  Fall2013IOSApp
//
//  Created by Barry on 8/31/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface confSchedDetailViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *sessionName;
@property (nonatomic, strong) IBOutlet UILabel *sessionTime;
@property (nonatomic, strong) IBOutlet UILabel *sessionStatus;
@property (nonatomic, strong) IBOutlet UILabel *itscecs;
@property (strong, nonatomic) IBOutlet UIImageView *starUnSel;


@end
