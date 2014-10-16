//
//  AgendaCell.h
//  Fall2013IOSApp
//
//  Created by Barry on 7/19/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgendaCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *sessionDateLabel;
@property (nonatomic, strong) IBOutlet UILabel *sessionNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *sessionTimeLabel;


@end
