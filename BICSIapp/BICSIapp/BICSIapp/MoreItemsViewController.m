//
//  MoreItemsViewController.m
//  BICSIapp
//
//  Created by Barry on 4/25/13.
//  Copyright (c) 2013 Barry. All rights reserved.
//

#import "MoreItemsViewController.h"

@interface MoreItemsViewController ()

@end

@implementation MoreItemsViewController
@synthesize moreItemsLabel;
@synthesize moreItemsName;
@synthesize bicsiitems;
@synthesize itemPhoto;
@synthesize itemTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //moreItemsLabel.text = moreItemsName;
    
    self.title = bicsiitems.name;
    self.itemPhoto.image = [UIImage imageNamed:bicsiitems.imageFile];
    
    /*NSMutableString *itemText = [NSMutableString string];
    for (NSString* description in bicsiitems.description) {
        [itemText appendFormat:@"%@\n", description];
    }*/
    self.itemTextView.text = bicsiitems.description;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
