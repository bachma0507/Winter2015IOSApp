//
//  UploadImageViewController.m
//  Winter2014IOSApp
//
//  Created by Barry on 10/11/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "UploadImageViewController.h"

#import <Parse/Parse.h>

#import "Constants.h"

#import "AppConstant.h"

#import <AudioToolbox/AudioToolbox.h>

//#import "UIImage+ResizeAdditions.h"

@interface UploadImageViewController ()

-(void)showErrorView:(NSString *)errorMsg;
@property UIImage *resizedImage;

@end

@implementation UploadImageViewController

@synthesize imgToUpload = _imgToUpload;
@synthesize username = _username;
@synthesize commentTextField = _commentTextField;
@synthesize resizedImage;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    _commentTextField.delegate = self;
    
    
    CALayer *layer = self.imgToUpload.layer;
    layer.masksToBounds = NO;
    layer.shadowRadius = 3.0f;
    layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    layer.shadowOpacity = 0.5f;
    layer.shouldRasterize = YES;
    
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    NSURL *fileURL = [NSURL URLWithString:@"/System/Library/Audio/UISounds/Modern/sms_alert_bamboo.caf"]; // see list below
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)fileURL,&soundID);
    AudioServicesPlaySystemSound(soundID);
    
    NSString *message = @"All photos and comments will be reviewed before being posted to the gallery. Any photos with potential indecency issues will not be posted and your user account will be terminated.";
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Notification"
                                                       message:message
                                                      delegate:self
                                             cancelButtonTitle:@"Ok"
                                             otherButtonTitles:nil,nil];
    [alertView show];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.imgToUpload = nil;
    self.username = nil;
    self.commentTextField = nil;
    

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark IB Actions

-(IBAction)selectPicturePressed:(id)sender
{
    
    
    
    //Open a UIImagePickerController to select the picture
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.navigationController presentViewController:imgPicker animated:YES completion:nil];
}

- (IBAction)cameraPressed:(id)sender {
    
    
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchesBegan:withEvent:");
//    [self.view endEditing:YES];
//    [super touchesBegan:touches withEvent:event];
//}


-(IBAction)sendPressed:(id)sender
{
    
    
    
    [self.commentTextField resignFirstResponder];
    
    
    //Disable the send button until we are ready
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    //Place the loading spinner
    UIActivityIndicatorView *loadingSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [loadingSpinner setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
    [loadingSpinner startAnimating];
    
    [self.view addSubview:loadingSpinner];
    
    double ratio;
    double delta;
    CGPoint offset;
    
    //make a new square size, that is the resized imaged width
    CGSize sz = CGSizeMake(600, 600);
    
    
    //figure out if the picture is landscape or portrait, then
    //calculate scale factor and offset
    if (self.imgToUpload.image.size.width > self.imgToUpload.image.size.height) {
        ratio = 600 / self.imgToUpload.image.size.width;
        delta = (ratio*self.imgToUpload.image.size.width - ratio*self.imgToUpload.image.size.height);
        offset = CGPointMake(delta/2, 0);
    } else {
        ratio = 600 / self.imgToUpload.image.size.height;
        delta = (ratio*self.imgToUpload.image.size.height - ratio*self.imgToUpload.image.size.width);
        offset = CGPointMake(0, delta/2);
    }
    
    //make the final clipping rect based on the calculated values
    CGRect clipRect = CGRectMake(-offset.x, -offset.y,
                                 (ratio * self.imgToUpload.image.size.width) + delta,
                                 (ratio * self.imgToUpload.image.size.height) + delta);
    
    //start a new context, with scale factor 0.0 so retina displays get
    //high quality image
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(sz, YES, 0.0);
    } else {
        UIGraphicsBeginImageContext(sz);
    }
    UIRectClip(clipRect);
    [self.imgToUpload.image drawInRect:clipRect];
     resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    //UIImage *resizedImage = [self.imgToUpload.image resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(560.0f, 560.0f) interpolationQuality:kCGInterpolationHigh];
    
    
    //Upload a new picture
    NSData *pictureData = UIImageJPEGRepresentation(resizedImage, 0.8f);
    
    PFFile *file = [PFFile fileWithName:@"img" data:pictureData];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded){
            PFUser * user = [PFUser currentUser];
            
            //Add the image to the object, and add the comments, the user, and the geolocation (fake)
            PFObject *imageObject =
            
            [PFObject objectWithClassName:WALL_OBJECT];
            [imageObject setObject:file forKey:KEY_IMAGE];
            //[imageObject setObject:[PFUser currentUser].username forKey:KEY_USER];
            [imageObject setObject:[user objectForKey:PF_USER_FULLNAME] forKey:KEY_USER];
            
            [imageObject setObject:self.commentTextField.text forKey:KEY_COMMENT];
            
            PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:52 longitude:-4];
            [imageObject setObject:point forKey:KEY_GEOLOC];
            
            [imageObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (succeeded){
                    //Go back to the wall
                    
                    //Begin Send email
                    NSString *post =[[NSString alloc] initWithFormat:@"message=%@",self.commentTextField.text];
                    NSLog(@"PostData: %@",post);
                    
                    NSURL *url=[NSURL URLWithString:@"https://speedyreference.com/newpicsubmitted.php"];
                    
                    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
                    
                    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
                    
                    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                    [request setURL:url];
                    [request setHTTPMethod:@"POST"];
                    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
                    //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
                    [request setHTTPBody:postData];
                    
                    NSError *error = [[NSError alloc] init];
                    NSHTTPURLResponse *response = nil;
                    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                    
                    NSLog(@"Response code: %ld", (long)[response statusCode]);
                    
                    if ([response statusCode] >= 200 && [response statusCode] < 300)
                    {
                        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                        NSLog(@"Response ==> %@", responseData);
                    }
                    
                    //End send email
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else{
                    NSString *errorString = [[error userInfo] objectForKey:@"error"];
                    [self showErrorView:errorString];
                }
            }];
        
        }
        else{
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            [self showErrorView:errorString];
        }
        
        [loadingSpinner stopAnimating];
        [loadingSpinner removeFromSuperview];
        
    } progressBlock:^(int percentDone) {
        
    }];
    
}
     
#pragma mark UIImagePicker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //Place the image in the imageview
    self.imgToUpload.image = img;
}

#pragma mark Error View


-(void)showErrorView:(NSString *)errorMsg
{
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 50) ? NO : YES;
}


@end

