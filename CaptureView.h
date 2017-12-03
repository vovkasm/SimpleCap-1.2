//
//  CaptureView.h
//  SimpleCap
//
//  Created by - on 08/03/05.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "Handler.h"

@interface CaptureView : NSView

- (void)setHandler:(id<Handler>)handler;

@end
