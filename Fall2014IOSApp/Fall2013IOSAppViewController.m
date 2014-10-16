//
//  Fall2013IOSAppViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 5/16/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "Fall2013IOSAppViewController.h"
#import "InfoDetailViewController.h"
#import "infoItems.h"

@interface Fall2013IOSAppViewController ()

@end

@implementation Fall2013IOSAppViewController
NSArray *moreItems;
NSArray *iconthumbnails;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    

    
//    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
//    self.tableView.contentInset = inset;
//    
//    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg.png"]];
//    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg.png"]]; //[UIColor clearColor];

    
    infoItems *item1 = [infoItems new];
    item1.name = @"Conference Schedule";
    item1.httpSource = @"http://speedyreference.com/schedpre.html";
    item1.fullUrl = [NSURL URLWithString:item1.httpSource];
    item1.httpRequest = [NSURLRequest requestWithURL:item1.fullUrl];
    
    infoItems *item2 = [infoItems new];
    item2.name = @"Exhibit Hall Schedule";
    item2.httpSource = @"http://speedyreference.com/exhallsched.html";
    item2.fullUrl = [NSURL URLWithString:item2.httpSource];
    item2.httpRequest = [NSURLRequest requestWithURL:item2.fullUrl];
    
    infoItems *item3 = [infoItems new];
    item3.name = @"Exhibit Hall Floor Plan";
    item3.httpSource = @"http://s23.a2zinc.net/clients/BICSI/fall2013//Public/GeneratePDF.aspx?IMID=undefined&EventId=20&MapId=20";
    //item3.httpSource = @"http://s23.a2zinc.net/clients/BICSI/fall2013/public/Eventmap.aspx?shmode=E";
    item3.fullUrl = [NSURL URLWithString:item3.httpSource];
    item3.httpRequest = [NSURLRequest requestWithURL:item3.fullUrl];
    
    infoItems *item4 = [infoItems new];
    item4.name = @"CEC Information";
    item4.httpSource = @"http://speedyreference.com/cecinfo.html";
    item4.fullUrl = [NSURL URLWithString:item4.httpSource];
    item4.httpRequest = [NSURLRequest requestWithURL:item4.fullUrl];
    
    infoItems *item5= [infoItems new];
    item5.name = @"Sponsors";
    item5.httpSource = @"http://bicsi.org/fall/2013/exhibitor.aspx#sidebar";
    item5.fullUrl = [NSURL URLWithString:item5.httpSource];
    item5.httpRequest = [NSURLRequest requestWithURL:item5.fullUrl];
    
    infoItems *item6 = [infoItems new];
    item6.name = @"Hotel Information";
    item6.httpSource = @"http://speedyreference.com/hotel.html";
    item6.fullUrl = [NSURL URLWithString:item6.httpSource];
    item6.httpRequest = [NSURLRequest requestWithURL:item6.fullUrl];
    
    infoItems *item7 = [infoItems new];
    item7.name = @"Contact Us";
    item7.httpSource = @"http://speedyreference.com/contactus.html";
    item7.fullUrl = [NSURL URLWithString:item7.httpSource];
    item7.httpRequest = [NSURLRequest requestWithURL:item7.fullUrl];
    
    
    
    moreItems = [NSArray arrayWithObjects:item1, item2, item3, item4, item5, item6, item7, nil];
    iconthumbnails = [NSArray arrayWithObjects:@"cellnavleft.png", @"cellnavleft.png", @"cellnavleft.png", @"cellnavleft.png", @"cellnavleft.png", @"cellnavleft.png", @"cellnavleft.png", nil];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [moreItems count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"infoCell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    //cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:15.0];
    cell.textLabel.textColor = [UIColor brownColor];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    infoItems *infoitems = [moreItems objectAtIndex:indexPath.row];
    cell.textLabel.text = infoitems.name;
    cell.imageView.image = [UIImage imageNamed:[iconthumbnails objectAtIndex:indexPath.row]];
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"infoDetailCell"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        InfoDetailViewController *destViewController = segue.destinationViewController;
        destViewController.infoitems = [moreItems objectAtIndex:indexPath.row];
        
        // Hide bottom tab bar in the detail view
        destViewController.hidesBottomBarWhenPushed = YES;
        
    }
}



@end
