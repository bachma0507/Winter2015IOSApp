//
//  MoreViewController.m
//  BICSIapp
//
//  Created by Barry on 4/25/13.
//  Copyright (c) 2013 Barry. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreItemsViewController.h"
#import "BICSIitems.h"

@interface MoreViewController ()

@end

@implementation MoreViewController
 NSArray *moreItems;
//@synthesize tableView;


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
    
    BICSIitems *item1 = [BICSIitems new];
    item1.name = @"Join BICSI";
    item1.imageFile = @"bicsi-page2.png";
    item1.description = @"Enhance your career by becoming a member of BICSI! When you join, you gain access to amazing benefits and resources to help increase your knowledge and build you career. BICSI courses and credentials provide growth for your business, your career and yourself. BICSI News Magazine, reference manuals and standards give you access to the latest advancements and technology and provide educational resources. And, experience the networking opportunities created by BICSI conferences, Region Meetings, Breakfast Clubs and social media.";
    
    BICSIitems *item2 = [BICSIitems new];
    item2.name = @"Credentials & Exams";
    item2.imageFile = @"bicsi-page2.png";
    item2.description = @"BICSI established its credential programs to provide a level of assurance to the industry and to consumers that an individual has knowledge in a designated area of information technology systems (ITS) design or installation. Our professional designations are valued internationally and are recognized throughout the ITS industry.Candidates for BICSI credentials are required to show industry experience and pass rigorous exams based on the content of BICSI manuals. Those who pass must adhere to strict standards of conduct and keep their knowledge current through continuing education.";
    
    BICSIitems *item3 = [BICSIitems new];
    item3.name = @"Standards";
    item3.imageFile = @"bicsi-page2.png";
    item3.description = @"From its inception as the BICSI Standards Committee, the BICSI Standards Program creates standards and guidelines for use in the design, installation and integration of information technology systems (ITS) and related telecommunications fields. BICSI standards are written to define current practices and drive improvement in quality and performance over the spectrum of voice, data, electronic safety & security and audio & video technologies, and encompass optical,  fiber, copper and wireless-based distribution systems.The BICSI Standards Program is an ANSI-accredited, consensus-based standards development organization, with membership open to all interested parties.";
    
    BICSIitems *item4 = [BICSIitems new];
    item4.name = @"Training";
    item4.imageFile = @"bicsi-page2.png";
    item4.description = @"BICSI has internationally recognized training for voice, data, and video distribution design and installation. All training is provided by BICSI Master Instructors or BICSI Certified Trainers.";
    
    BICSIitems *item5 = [BICSIitems new];
    item5.name = @"Events";
    item5.imageFile = @"bicsi-page2.png";
    item5.description = @"BICSI provides numerous events so you can meet others in the field and earn continuing education credits (CECs). Through conferences, region meetings and breakfast clubs, BICSI is able to keep you updated on local BICSI news and discover the latest trends in information technology systems (ITS) products and solutions. BICSI events are not just limited to the United States. BICSI membership spans more than 140 countries, and Conferences, Region Meetings, Breakfast Clubs and Pub Clubs take place all over the world.";
    
    BICSIitems *item6 = [BICSIitems new];
    item6.name = @"BICSI Cares";
    item6.imageFile = @"bicsi-page2.png";
    item6.description = @"Over two decades ago, BICSI Cares started collecting donations for charities in cities where conferences are held. The idea started with BICSI member Ray Gendron. While attending a conference, Ray jokingly passed a hat around. It returned to him filled with money. Because there was no way to know who gave what amount, Ray gave the money to charity and that was the beginning of BICSI Cares. What started as one BICSI member making a gesture of goodwill has evolved into an ongoing, heartfelt effort by BICSI members, conference attendees and organization supporters.";
    
    moreItems = [NSArray arrayWithObjects:item1, item2, item3, item4, item5, item6, nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [moreItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"moreItemsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    BICSIitems *bicsiitems = [moreItems objectAtIndex:indexPath.row];
    cell.textLabel.text = bicsiitems.name;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showMoreItemsDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MoreItemsViewController *destViewController = segue.destinationViewController;
        destViewController.bicsiitems = [moreItems objectAtIndex:indexPath.row];
        
        // Hide bottom tab bar in the detail view
        destViewController.hidesBottomBarWhenPushed = YES;
    
    }
}

@end
