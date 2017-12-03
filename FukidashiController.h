//
//  FukidashiController.h
//  Fukidashi
//
//  Created by - on 08/12/06.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FukidashiController : NSObject

+(FukidashiController*)sharedConroller;
- (void)showMessage:(NSString*)message At:(NSPoint)p;
- (void)showMessage:(NSString*)message;
- (void)setBasePosition:(NSPoint)p;
- (void)setShowTime:(int)showtime;

@end
