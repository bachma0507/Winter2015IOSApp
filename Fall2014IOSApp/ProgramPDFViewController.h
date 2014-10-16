//
//  ProgramPDFViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 8/31/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProgramPDFViewController;

@protocol ProgramPDFViewControllerDelegate

@end

@interface ProgramPDFViewController : UIViewController <UIWebViewDelegate, UIDocumentInteractionControllerDelegate>

@property (weak, nonatomic) id <ProgramPDFViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *openInButton;


- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer;

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;

- (IBAction)shareButton:(id)sender;


@end
