//
//  FukidashiView.h
//  Fukidashi
//
//  Created by - on 08/12/05.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FukidashiView : NSView

- (void)setMessage:(NSString*)message;
- (NSSize)areaSize;
- (NSPoint)trianglePoint;

@end
