//
//  Screen.h
//  SimpleCap
//
//  Created by - on 08/07/27.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Screen : NSObject

+ (Screen*)defaultScreen;
- (NSRect)frame;
- (NSRect)menuScreenFrame;
- (CGRect)frameInCGCoordinate;

@end
