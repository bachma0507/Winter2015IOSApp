//
//  AllNotesCell.h
//  Fall2013IOSApp
//
//  Created by Barry on 7/22/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllNotesCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *sessionNoteLabel;
@property (nonatomic, strong) IBOutlet UITextView *sessionNoteDesc;

@end
