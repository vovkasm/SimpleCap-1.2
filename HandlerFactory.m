//
//  HandlerFactory.m
//  SimpleCap
//
//  Created by - on 08/03/16.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import "HandlerFactory.h"

#import "Handler.h"
#import "WindowHandler.h"
#import "TrackWindowHandler.h"
#import "SelectionHandler.h"
#import "ScreenHandler.h"
#import "MenuHandler.h"
#import "ApplicationHandler.h"
#import "WidgetHandler.h"
#import "CaptureController.h"

@implementation HandlerFactory  {
    NSMutableDictionary<NSString*, id<Handler>> *_handlers;
    CaptureController *_capture_controller;
}

- (id)initWithCaptureController:(CaptureController*)capture_controller
{
    self = [super init];
    if (self) {
        _handlers = [[NSMutableDictionary alloc] init];
        _capture_controller = capture_controller;
    }
    return self;
}



- (id<Handler>)handlerWithName:(NSString*)name
{
    id<Handler> handler = [_handlers objectForKey:name];
    if (!handler) {
        if ([name isEqualToString:CAPTURE_WINDOW]) {
            handler = [[WindowHandler alloc] initWithCaptureController:_capture_controller];
            [_handlers setObject:handler forKey:name];
            
        } else if ([name isEqualToString:CAPTURE_TRACKWINDOW]) {
                handler = [[TrackWindowHandler alloc] initWithCaptureController:_capture_controller];
                [_handlers setObject:handler forKey:name];
            
        } else if ([name isEqualToString:CAPTURE_SELECTION]) {
            handler = [[SelectionHandler alloc] initWithCaptureController:_capture_controller];
            [_handlers setObject:handler forKey:name];

        } else if ([name isEqualToString:CAPTURE_SCREEN]) {
            handler = [[ScreenHandler alloc] initWithCaptureController:_capture_controller];
            [_handlers setObject:handler forKey:name];

        } else if ([name isEqualToString:CAPTURE_MENU]) {
            handler = [[MenuHandler alloc] initWithCaptureController:_capture_controller];
            [_handlers setObject:handler forKey:name];

        } else if ([name isEqualToString:CAPTURE_APPLICATION]) {
            handler = [[ApplicationHandler alloc] initWithCaptureController:_capture_controller];
            [_handlers setObject:handler forKey:name];
            
        } else if ([name isEqualToString:CAPTURE_WIDGET]) {
            handler = [[WidgetHandler alloc] initWithCaptureController:_capture_controller];
            [_handlers setObject:handler forKey:name];
        }
                
        [handler setup];
    }
    return handler;
}

@end
