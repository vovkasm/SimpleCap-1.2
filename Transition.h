//
//  Transition.h
//  SimpleCap
//
//  Created by - on 08/10/13.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Transition : NSObject

@property (retain) NSNumber* inputTime;
@property (retain) NSNumber *inputWidth;
@property (retain) NSNumber *inputScale;
@property (retain) NSNumber *framePerSec;
@property (retain) NSNumber *totalSec;

- (id)initWithView:(NSView*)view;
- (void)draw;
- (void)startWithTarget:(id)target CGImage:(CGImageRef)cgimage;

@end
