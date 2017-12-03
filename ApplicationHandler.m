//
//  ApplicationHandler.m
//  SimpleCap
//
//  Created by - on 08/07/02.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import "ApplicationHandler.h"
#import "CaptureController.h"
#import "TimerController.h"
#import "Window.h"

@implementation ApplicationHandler {
    ThinButtonBar*    _button_bar;
    NSMutableArray* _app_windows;
    id _application;
}

// for protocol
- (void)reset
{
}

- (void)setup
{
	// setup array
	_app_windows = [[NSMutableArray alloc] init];
}

- (BOOL)startWithObject:(id)object
{
	_application = [object retain];
	[self.captureController disableMouseEventInWindow];
	[self setAnimationCounter:0];
	[self.captureController startTimerOnClient:self
									  title:[_application objectForKey:@"name"]
									  image:[_application objectForKey:@"image"]];
	return YES;
}

- (void) dealloc
{
	[_app_windows release];
	[super dealloc];
}

- (void)tearDown
{
	[_application release];
	[self.captureController enableMouseEventInWindow];
	[_app_windows removeAllObjects];
}

- (void)drawRect:(NSRect)rect
{
}

- (void)mouseMoved:(NSEvent *)theEvent
{
}

- (void)mouseDown:(NSEvent *)theEvent
{
}

- (void)keyDown:(NSEvent *)theEvent
{
	[super keyDown:theEvent];
}

- (NSInteger)windowLevel
{
	return [super defaultWindowLevel]+1;
}

- (CGImageRef)capture
{
	return [self cgimageWithWindowList:_app_windows
								cgrect:CGRectNull];
}

- (void)setAppWindows
{
	int pid = [[_application objectForKey:@"pid"] intValue];
	for(Window* window in [self getWindowAllList]) {
		
		if (pid == [window ownerPID]) {
			[_app_windows addObject:window];
		}
	}
}

//
// <TimerClient>
//
- (void)timerStarted:(TimerController*)controller
{
}

- (void)timerCounted:(TimerController*)controller
{
	[self incrementAnimationCounter];
	CaptureView* view = [self.captureController view];
	[view setNeedsDisplay:YES];
}

- (void)timerFinished:(TimerController*)controller
{
	[self setAppWindows];
	/*
	[_capture_controller saveImage:[self capture]
	   withMouseCursorInWindowList:_app_windows
						imageFrame:[Window unionNSRectWithWindowList:_app_windows]];
	[_capture_controller exit];
	 */
	if ([controller isCopy]) {
		[self.captureController copyImage:[self capture]
		   withMouseCursorInWindowList:_app_windows
							imageFrame:[Window unionNSRectWithWindowList:_app_windows]];
		[self.captureController exit];
		
	} else if ([controller isContinous]) {
		[self.captureController setContinouslyFlag:YES];
		[self.captureController saveImage:[self capture]
		   withMouseCursorInWindowList:_app_windows
							imageFrame:[Window unionNSRectWithWindowList:_app_windows]];
		[controller start];
		
	} else {
		// NORMAL
		[self.captureController saveImage:[self capture]
		   withMouseCursorInWindowList:_app_windows
							imageFrame:[Window unionNSRectWithWindowList:_app_windows]];
		[self.captureController openViewerWithLastfile];
		[self.captureController exit];
	}
	
}

- (void)timerCanceled:(TimerController*)controller
{
	[self.captureController cancel];
}

- (void)timerPaused:(TimerController*)controller
{
}

- (void)timerRestarted:(TimerController*)controller
{
}

- (void)openConfigMenuWithView:(NSView*)view event:(NSEvent*)event
{
	[self.captureController openWindowConfigMenuWithView:view event:event];
}


- (NSMenu *)menuForEvent:(NSEvent *)theEvent
{
	return [super menuForEvent:theEvent];
}

- (void)setupQuickConfigMenu:(NSMenu*)menu
{
	[super setupQuickConfigMenu:menu];
}

- (void)changedImageFormatTo:(int)image_format
{
}

@end
