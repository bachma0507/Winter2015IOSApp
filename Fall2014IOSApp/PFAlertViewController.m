//
//  PFAlertViewController.m
//  Winter2014IOSApp
//
//  Created by Barry on 10/11/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "PFAlertViewController.h"

@interface PFAlertViewController ()

@end

@implementation PFAlertViewController

- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
        // This table displays items in the Todo class
        self.parseClassName = @"Alerts";
        self.textKey = @"text";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 25;
    }
    
    //NSLog(@"initWithCoder method is called");
    
    return self;
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.
    //    if ([self.objects count] == 0) {
    //        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    //    }
    //
    [query orderByDescending:@"createdAt"];
    
    //NSLog(@"OFQuery method is called");
    
    return query;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
    //PFTableViewCell *cell = (PFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell to show todo item with a priority at the bottom
    cell.textLabel.text = [object objectForKey:@"text"];
    //NSString *createdDt = [[NSString alloc] initWithFormat:@"%@",[object objectForKey:@"createdAt"]];
    //NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //[dateFormat setDateFormat:@"MMM dd yyyy hh:mm a"];
    //NSString *dateStr = [dateFormat stringFromDate:[object objectForKey:@"createdAt"]];
    
    //cell.detailTextLabel.text = dateStr;
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"Priority: %@",
    //[object objectForKey:@"priority"]];
    //cell.detailTextLabel.text = @"Priority";
    
    //NSLog(@"UITableView method is called");
    
    return cell;
}
@end