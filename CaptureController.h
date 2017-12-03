//
//  DelegateWindow.h
//  SimpleCap
//
//  Created by - on 08/03/08.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "Handler.h"
#import "HandlerFactory.h"
#import "CaptureWindow.h"
#import "FileManager.h"
#import "AppController.h"
#import "Transition.h"
#import "TimerClient.h"

@interface CaptureController : NSObject

- (id)initWithAppController:(AppController*)appController;
- (void)setFileManager:(FileManager*)fileManager;
- (void)startCaptureWithHandlerName:(NSString*)handlerName withObject:(id)object;

// for handlers
- (void)exit;
- (void)showResultMessage;
- (void)cancel;
- (AppController*)appController;
- (BOOL)isSameHandlerWhenPreviousCapture;
- (void)setContinouslyFlag:(BOOL)flag;
- (void)openViewerWithLastfile;

- (void)saveImage:(CGImageRef)cgimage imageFrame:(NSRect)frame;
- (void)saveImage:(CGImageRef)cgimage withMouseCursorInRect:(NSRect)rect imageFrame:(NSRect)frame;
- (void)saveImage:(CGImageRef)cgimage withMouseCursorInWindowList:(NSArray*)list imageFrame:(NSRect)frame;
- (void)saveImage:(CGImageRef)cgimage withMouseCursorInRect:(NSRect)rect offset:(NSSize)offset imageFrame:(NSRect)frame;

- (void)copyImageWithBitmapImageRep:(NSBitmapImageRep*)bitmap_rep;
- (void)copyImage:(CGImageRef)cgimage imageFrame:(NSRect)frame;
- (void)copyImage:(CGImageRef)cgimage withMouseCursorInRect:(NSRect)rect imageFrame:(NSRect)frame;
- (void)copyImage:(CGImageRef)cgimage withMouseCursorInWindowList:(NSArray*)list imageFrame:(NSRect)frame;
- (void)copyImage:(CGImageRef)cgimage withMouseCursorInRect:(NSRect)rect offset:(NSSize)offset imageFrame:(NSRect)frame;

- (void)disableMouseEventInWindow;
- (void)enableMouseEventInWindow;


- (CGWindowID)windowID;

- (CaptureView*)view;
- (CaptureWindow*)window;
- (Transition*)transition;

- (void)setMenuTitle:(NSString*)title;

- (void)startTimerOnClient:(id<TimerClient>)client title:(NSString*)title image:(NSImage*)image;

- (void)openWindowConfigMenuWithView:(NSView*)view event:(NSEvent*)event;
- (void)openSelectionConfigMenuWithView:(NSView*)view event:(NSEvent*)event;
- (void)openScreenConfigMenuWithView:(NSView*)view event:(NSEvent*)event;
- (void)openMenuConfigMenuWithView:(NSView*)view event:(NSEvent*)event;

// for conroller
- (void)resetSelection;

// delegate
- (void)changedImageFormatTo:(int)image_format;

@end
