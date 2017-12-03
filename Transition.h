//
//  Transition.h
//  SimpleCap
//
//  Created by - on 08/10/13.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Transition : NSObject

@property (strong) NSNumber* inputTime;
@property (strong) NSNumber *inputWidth;
@property (strong) NSNumber *inputScale;
@property (strong) NSNumber *framePerSec;
@property (strong) NSNumber *totalSec;

- (id)initWithView:(NSView*)view;
- (void)draw;
- (void)startWithTarget:(id)target CGImage:(CGImageRef)cgimage;

@end
