//
//  GroupView.m
//  Fall2014IOSApp
//
//  Created by Barry on 10/6/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import "GroupView.h"
#import <Parse/Parse.h>
#import "ProgressHUD.h"

#import "AppConstant.h"
#import "utilities.h"

#import "GroupView.h"
#import "ChatView.h"
#import "ChatGallery.h"

@interface GroupView () 

{
    NSMutableArray *chatrooms;
}

@end

@implementation GroupView

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.tabBarItem.title = nil;
        [self.tabBarItem setImage:[UIImage imageNamed:@"tab_group"]];
        [self.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab_group"]];
        self.tabBarItem.title = @"Group";
    }
    return self;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewDidLoad];
    
//    self.tabBarItem.title = nil;
//    [self.tabBarItem setImage:[UIImage imageNamed:@"tab_group"]];
//    [self.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab_group"]];
//    self.tabBarItem.title = @"Group";
    
//    UIBarButtonItem *btn=[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(btnClick)];
//    self.navigationItem.leftBarButtonItem=btn;
    
    self.title = @"Group";
    //---------------------------------------------------------------------------------------------------------------------------------------------
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self
                                                                             action:@selector(actionNew)];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self
                                                                             action:@selector(btnClick)];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
    //---------------------------------------------------------------------------------------------------------------------------------------------
    chatrooms = [[NSMutableArray alloc] init];
}

-(void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//    
//    UIViewController *cg = [storyboard instantiateViewControllerWithIdentifier:@"ChatLoginViewController" ];
//    
//    [self.navigationController presentViewController:cg animated:YES completion:NULL];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewDidAppear:animated];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    if ([PFUser currentUser] == nil) LoginUser(self);
    //---------------------------------------------------------------------------------------------------------------------------------------------
    [self refreshTable];
}

#pragma mark - User actions

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)actionNew
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter a name for your group" delegate:self
                                          cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

#pragma mark - UIAlertViewDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    if (buttonIndex != alertView.cancelButtonIndex)
    {
        UITextField *textField = [alertView textFieldAtIndex:0];
        if ([textField.text isEqualToString:@""] == NO)
        {
            PFObject *object = [PFObject objectWithClassName:PF_CHATROOMS_CLASS_NAME];
            object[PF_CHATROOMS_ROOM] = textField.text;
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
             {
                 if (error == nil)
                 {
                     [self refreshTable];
                 }
                 else [ProgressHUD showError:@"Network error."];
             }];
        }
    }
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)refreshTable
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [ProgressHUD show:nil];
    PFQuery *query = [PFQuery queryWithClassName:PF_CHATROOMS_CLASS_NAME];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (error == nil)
         {
             [chatrooms removeAllObjects];
             for (PFObject *object in objects)
             {
                 [chatrooms addObject:object];
             }
             [ProgressHUD dismiss];
             [self.tableView reloadData];
         }
         else [ProgressHUD showError:@"Network error."];
     }];
}

#pragma mark - Table view data source

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    return 1;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    return [chatrooms count];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    PFObject *room = [chatrooms objectAtIndex:indexPath.row];
    cell.textLabel.text = room[PF_CHATROOMS_ROOM];
    
    return cell;
}

#pragma mark - Table view delegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PFObject *chatroom = [chatrooms objectAtIndex:indexPath.row];
    
    ChatView *chatView = [[ChatView alloc] initWith:chatroom.objectId];
    chatView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatView animated:YES];
}

@end
