//
//  HandlerFactory.h
//  SimpleCap
//
//  Created by - on 08/03/16.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CaptureType.h"
#import "Handler.h"

@class CaptureController;

@interface HandlerFactory : NSObject

- (id)initWithCaptureController:(CaptureController*)capture_controller;
- (id<Handler>)handlerWithName:(NSString*)name;

@end
