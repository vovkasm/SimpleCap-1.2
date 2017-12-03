//
//  MenuHandler.m
//  SimpleCap
//
//  Created by - on 08/05/31.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import "MenuHandler.h"
#import "CaptureController.h"
#import "TimerController.h"
#import "Window.h"
#import "UserDefaults.h"

#define SC_MARGIN_WIDTH			30
#define SC_MARGIN_HEIGHT		25
#define SC_MARGIN_STATUSBAR_X	15
#define SC_MAINMENUBAR_HEIGHT	22
#define SC_CLIP_MARGIN			10

enum MENU_KIND {
	MENU_KIND_NORMAL,
	MENU_KIND_STATUSBAR,
	MENU_KIND_SPOTLIGHT,
	MENU_KIND_POPUP
};


@implementation MenuHandler {
    BOOL _is_menu_only;
}

- (void)reset
{
}

- (BOOL)startWithObject:(id)object
{
	_is_menu_only = NO;
	[self.captureController startTimerOnClient:self
									  title:NSLocalizedString(@"TimerTitleMenu", @"")
									  image:nil];
	[self.captureController disableMouseEventInWindow];
	
	return YES;
}

- (void)tearDown
{
	[self.captureController enableMouseEventInWindow];
}

- (void)drawRect:(NSRect)rect
{
}

- (void)mouseDown:(NSEvent *)theEvent
{
}

- (void)mouseMoved:(NSEvent *)theEvent
{
}
- (void)keyDown:(NSEvent *)theEvent
{
//	[super keyDown:theEvent];
}

- (NSInteger)windowLevel
{
	return kCGDockWindowLevel-1;
}



//
// <TimerClient>
//
- (void)timerStarted:(TimerController*)controller
{
}

- (void)timerCounted:(TimerController*)controller
{
}


- (void)timerFinished:(TimerController*)controller
{
	NSMutableArray* statusbar_windows = [NSMutableArray array];
	NSMutableArray* menu_windows = [NSMutableArray array];
	BOOL is_clipping = [[UserDefaults valueForKey:UDKEY_MENU_ACTUAL_WIDTH] boolValue];
	
	int menu_kind = MENU_KIND_NORMAL;
	
	Window* mainmenubar_window;
	
	NSArray *list = [self getWindowAllList];

	// (1) setup statusbar and mainmenubar
	for (Window* window in list) {
		if ([window layer] == kCGStatusWindowLevel) {

			if ([window cgrect].origin.x !=0 || [window cgrect].origin.y != 0) {
				// skip {{0, 0}, {1440, 22}}
				[statusbar_windows addObject:window];
			}
		} else if ([window layer] == kCGMainMenuWindowLevel) {
			// MAIN MENUBAR
			mainmenubar_window = window;
			
		}			
	}

	// (2) search menus
	BOOL is_pulldown_menu = NO;
	for (Window* window in list) {
		
		if ([window isSpotlight]) {
			// SPOTLIGHT MENU
			menu_kind = MENU_KIND_SPOTLIGHT;
			[menu_windows addObject:window];

		} else if ([window layer] == kCGPopUpMenuWindowLevel) {
			[menu_windows addObject:window];

			if ([window rect].origin.y == SC_MAINMENUBAR_HEIGHT) {
				is_pulldown_menu = YES;
			}
			for (Window* window2 in statusbar_windows) {
				if ([window ownerPID] == [window2 ownerPID]) {
					menu_kind = MENU_KIND_STATUSBAR;
					break;
				}
			}
		}
	}
	if (!is_pulldown_menu) {
		menu_kind = MENU_KIND_POPUP;
	}
	
	if ([menu_windows count] > 0) {
		
		CGRect cgrect0 = CGRectZero;	// temporary
		CGRect cgrect1 = CGRectZero;	// for image bounds
		CGRect cgrect2 = CGRectZero;	// for mouse cursor location
		
		// (3) calcurate rect
		if (_is_menu_only) {
			// CASE(1) MENU ONLY
			cgrect1 = CGRectNull;

		} else {
			// CASE(2) WITH MENUBAR
			switch (menu_kind) {
				case MENU_KIND_NORMAL:
					cgrect1 = [Window unionCGRectWithWindowList:menu_windows];

					if (is_clipping) {
						cgrect1.size.width += SC_CLIP_MARGIN*2;
						cgrect1.origin.x -= SC_CLIP_MARGIN;
					} else {
						cgrect1.size.width += SC_MARGIN_WIDTH  + cgrect1.origin.x;
						cgrect1.origin.x = 0.0;
					}

					cgrect1.size.height += SC_MARGIN_HEIGHT + [mainmenubar_window cgrect].size.height;
					cgrect1.origin.y = 0.0;

					[menu_windows addObject:mainmenubar_window];
					cgrect2 = cgrect1;
					break;

				case MENU_KIND_SPOTLIGHT:
				case MENU_KIND_STATUSBAR:
					cgrect0 = [Window unionCGRectWithWindowList:menu_windows];
					[menu_windows addObjectsFromArray:statusbar_windows];
					if (!is_clipping) {
						cgrect1 = [Window unionCGRectWithWindowList:menu_windows];
					} else {
						cgrect1 = cgrect0;
					}

					cgrect1.size.width  += SC_MARGIN_WIDTH;
					cgrect1.size.height += SC_MARGIN_HEIGHT + [mainmenubar_window cgrect].size.height;
					cgrect1.origin.x    -= SC_MARGIN_STATUSBAR_X;
					cgrect1.origin.y     = 0.0;
					[menu_windows addObject:mainmenubar_window];
					cgrect2 = cgrect1;
					break;
					
				case MENU_KIND_POPUP:
				default:
					cgrect1 = CGRectNull;
					break;
			}
		}
		
		// (4) adjust to screen rect
		NSScreen* screen = [NSScreen mainScreen];
		NSSize screen_size = [screen frame].size;
		//------------------
		if (cgrect1.origin.x + cgrect1.size.width > screen_size.width) {
			cgrect1.size.width = screen_size.width - cgrect1.origin.x;
		}
		if (cgrect2.origin.x + cgrect2.size.width > screen_size.width) {
			cgrect2.size.width = screen_size.width - cgrect2.origin.x;
		}
		//------------------
		
		// (5) create image
		CGImageRef cgimage = [self cgimageWithWindowList:menu_windows
												  cgrect:cgrect1];

		if ([controller isCopy]) {
			if (CGRectEqualToRect(cgrect1, CGRectNull)) {
				[self.captureController copyImage:cgimage
				   withMouseCursorInWindowList:menu_windows
									imageFrame:NSRectFromCGRect(cgrect1)];
			} else {
				[self.captureController copyImage:cgimage
						 withMouseCursorInRect:NSRectFromCGRect(cgrect2)
									imageFrame:NSRectFromCGRect(cgrect1)];
			}
			
			[self.captureController exit];
			
		} else if ([controller isContinous]) {
			[self.captureController setContinouslyFlag:YES];
			if (CGRectEqualToRect(cgrect1, CGRectNull)) {
				[self.captureController saveImage:cgimage
				   withMouseCursorInWindowList:menu_windows
									imageFrame:NSRectFromCGRect(cgrect1)];
			} else {
				[self.captureController saveImage:cgimage
						 withMouseCursorInRect:NSRectFromCGRect(cgrect2)
									imageFrame:NSRectFromCGRect(cgrect1)];
			}
			[self.captureController showResultMessage];
			[controller start];
			
		} else {
			// NORMAL
			if (CGRectEqualToRect(cgrect1, CGRectNull)) {
				[self.captureController saveImage:cgimage
				   withMouseCursorInWindowList:menu_windows
									imageFrame:NSRectFromCGRect(cgrect1)];
			} else {
				[self.captureController saveImage:cgimage
						 withMouseCursorInRect:NSRectFromCGRect(cgrect2)
									imageFrame:NSRectFromCGRect(cgrect1)];
			}			
			[self.captureController openViewerWithLastfile];
			[self.captureController exit];
		}
		
	} else {
		if ([controller isContinous]) {
			[self.captureController showResultMessage];
			[controller start];
		} else {
//			[_capture_controller openViewerWithLastfile];
			[self.captureController exit];
		}
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
	[self.captureController openMenuConfigMenuWithView:view event:event];
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

