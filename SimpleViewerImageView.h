//
//  SimpleViewerView.h
//  SimpleCap
//
//  Created by - on 08/12/21.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/CAAnimation.h>

enum SV_TRANTYPE {
	SV_TRANTYPE_NONE,
	SV_TRANTYPE_OPEN,
	SV_TRANTYPE_TRASH,
	SV_TRANTYPE_NEXT,
	SV_TRANTYPE_PREVIOUS,
	SV_TRANTYPE_NEW,
	SV_TRANTYPE_UPDATE
};

@class SimpleViewerController;

@interface SimpleViewerImageView : NSView <CAAnimationDelegate>

- (id)initWithFrame:(NSRect)frame withController:(SimpleViewerController*)controller;
- (void)setImage:(NSImage*)image withDirection:(int)direction;
- (NSImage*)image;
- (CGFloat)reductionRatio;

@end
