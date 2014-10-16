//
//  LORichTextLabel.m
//  RichTextLabel
//
//  Created by Locassa on 19/06/2011.
//  Copyright 2011 Locassa Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LORichTextLabelStyle.h"


@interface LORichTextLabel : UIView {
	NSMutableDictionary *highlightStyles;
	NSArray *elements;
	UIColor *textColor;
	UIFont *font;
}

- (id)initWithWidth:(CGFloat)aWidth;
- (void)addStyle:(LORichTextLabelStyle *)aStyle forPrefix:(NSString *)aPrefix;
- (void)setFont:(UIFont *)value;
- (void)setTextColor:(UIColor *)value;
- (void)setText:(NSString *)value;

@end
