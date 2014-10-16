//
//  IpadUploadImageViewController.h
//  Winter2014IOSApp
//
//  Created by Barry on 10/14/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IpadUploadImageViewController : UIViewController <UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate, UITextFieldDelegate>
{
    UIPopoverController *popoverController;
}

@property (nonatomic, strong) IBOutlet UIImageView *imgToUpload;
@property (nonatomic, strong) IBOutlet UITextField *commentTextField;
@property (nonatomic, strong) NSString *username;
@property (strong, nonatomic) IBOutlet UIButton *selectPhotoBtn;

-(IBAction)selectPicturePressed:(id)sender;

- (IBAction)cameraPressed:(id)sender;

@end