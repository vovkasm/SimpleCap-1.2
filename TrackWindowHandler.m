//
//  TrackWindowHandler.m
//  SimpleCap
//
//  Created by - on 08/06/28.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import "TrackWindowHandler.h"
#import "CaptureController.h"
#import "ThinButtonBar.h"
#import "ButtonTags.h"
#import "ToolWindow.h"
#import "Window.h"

enum TRACKWINDOW_STATE {
    STATE_HIDE,
    STATE_TRACKING,
    STATE_SELECTING
};

@implementation TrackWindowHandler {    
    ThinButtonBar*    _button_bar;
    
    NSTimer*           _timer;
    
    BOOL               _is_display_selection;
    ToolWindow*        _tool_window;
    int                _state;
    
    Window*            _window;
}

-(void)changeState:(int)state
{
    CaptureView* view = [self.captureController view];
    
    if (_state == state) {
        return;
    }

    _state = state;
    switch (_state) {
        case STATE_HIDE:
            [self.captureController disableMouseEventInWindow];
            [_button_bar hide];
            [view setNeedsDisplay:YES];
            [_tool_window orderOut:self];
            break;
            
        case STATE_TRACKING:
            [self.captureController disableMouseEventInWindow];
            [_button_bar show];
            [view setNeedsDisplay:YES];
            [_tool_window makeKeyAndOrderFront:self];
            break;

        case STATE_SELECTING:
            [self.captureController enableMouseEventInWindow];
            [_button_bar hide];
            [view setNeedsDisplay:YES];
            [_tool_window orderOut:self];
            break;
            
        default:
            break;
    }
}

- (void)setWindow:(Window*)window
{
    _window = window;
}

// for protocol
- (void)reset
{
}

- (void)setup
{
    _tool_window = [[ToolWindow alloc] init];
    _button_bar = [[ThinButtonBar alloc] initWithFrame:NSZeroRect];
    [_button_bar addButtonWithImageResource:@"icon_cancel"
                         alterImageResource:@"icon_cancel2"
                                        tag:TAG_CANCEL
                                    tooltip:NSLocalizedString(@"CancelCapture", @"")
                                      group:nil
                           isActOnMouseDown:NO];
    [_button_bar addButtonWithImageResource:@"icon_copy_con"
                         alterImageResource:@"icon_copy_con2"
                                        tag:TAG_COPY
                                    tooltip:NSLocalizedString(@"ContinuouslyCopy", @"")
                                      group:nil
                           isActOnMouseDown:NO];
    [_button_bar addButtonWithImageResource:@"icon_continuous"
                         alterImageResource:@"icon_continuous2"
                                        tag:TAG_CONTINUOUS
                                    tooltip:NSLocalizedString(@"ContinuouslyCapture", @"")
                                      group:nil
                           isActOnMouseDown:NO];
    [_tool_window setFrame:[_button_bar frame] display:NO];
    [_tool_window setContentView:_button_bar];
    _button_bar.delegate = self;
    _is_display_selection = YES;
}
                    


- (BOOL)updateWindows
{
    // sort by lastest order
    BOOL is_exists = NO;
    BOOL is_overlaped = NO;

    for (Window* window in [self getWindowList]) {
        if ([window windowID] == [_window windowID]) {
            [_window setRect:[window rect]];
            is_exists = YES;
            break;
        } else {
            if (NSIntersectsRect([_window rect], [window rect])) {
//                is_overlaped = YES;
            }
        }
    }
    
    if (is_overlaped) {
        [self changeState:STATE_HIDE];
    } else {
        [self changeState:STATE_TRACKING];
    }
    return is_exists;
}

#define BUTTON_OFFSET 10.0
- (void)updateButtonWindow
{
    NSScreen* screen = [NSScreen mainScreen];
    NSRect srect = [screen frame];
    NSPoint p = [_window rect].origin;
    NSSize wsize = [_tool_window frame].size;
    p.x = p.x + [_window rect].size.width - wsize.width - BUTTON_OFFSET;
    p.y = srect.size.height - wsize.height - p.y - BUTTON_OFFSET;

    [_tool_window setFrameOrigin:p];
}

- (void)callBack:(NSTimer*)timer
{
    [self incrementAnimationCounter];
    if ([self updateWindows]) {
        [self updateButtonWindow];
        CaptureView* view = [self.captureController view];
        [view setNeedsDisplay:YES];
    } else {
        [_timer invalidate];
        _timer = nil;
        [self.captureController exit];
    }
}

- (BOOL)startWithObject:(id)object
{
/*    [self setWindow:[self topWindow]];
    if (_window) {
        [self changeState:STATE_SELECTING];
    } else {
        [self changeState:STATE_HIDE];
    }
*/    
    [self changeState:STATE_SELECTING];
    return YES;
}


- (void)tearDown
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    [self setWindow:nil];
    [self changeState:STATE_HIDE];
}

- (void)drawRect:(NSRect)rect
{
    switch (_state) {
        case STATE_TRACKING:
            if (_is_display_selection) {
                [self drawSelectedBoxRect2:[_window rect] Counter:self.animationCounter];
            }
            break;
            
        case STATE_SELECTING:
            [self drawBackground:rect];
            
            if (_window) {
                NSRect wr = [_window rect];
                [[_window image] drawInRect:wr fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:0.8 respectFlipped:YES hints:nil];
                [[NSColor grayColor] set];
                NSFrameRectWithWidth(wr, 0.5);
            }
            break;
            
        default:
            break;
    }
}

- (void)mouseMoved:(NSEvent *)theEvent
{
    if (_state != STATE_SELECTING) {
        return;
    }
    BOOL hit_flag = NO;
    NSPoint cp = [[self.captureController view] convertPoint:[theEvent locationInWindow]  fromView:nil];


    for (Window* window in [self getWindowList]) {
        if (![window isNormalWindow:NO]) {
            continue;
        }
        if (NSPointInRect(cp, [window rect])) {
            hit_flag = YES;
            if ([window windowID] != [_window windowID]) {
                [self setWindow:window];
                [[self.captureController view] setNeedsDisplay:YES];
            }
            break;
        }
    }
    if (!hit_flag) {
        [self setWindow:nil];
    }
}

- (void)mouseDown:(NSEvent *)theEvent
{
    if (_state != STATE_SELECTING) {
        return;
    }
    
    [self changeState:STATE_TRACKING];
    // set timer
    _timer = [NSTimer timerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(callBack:)
                                   userInfo:nil
                                    repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)keyDown:(NSEvent *)theEvent
{
    [super keyDown:theEvent];
}

- (NSInteger)windowLevel
{
    return NSDockWindowLevel-1;
}

- (CGImageRef)capture
{
    CGImageRef cgimage = CGWindowListCreateImage(CGRectNull,
                                                 kCGWindowListOptionIncludingWindow,
                                                 [_window windowID],
                                                 kCGWindowImageDefault);
    return cgimage;
}
-(void)clickedAtTag:(NSNumber*)tag  event:(NSEvent*)event
{
    // TODO
    switch ([tag intValue]) {
        case TAG_CANCEL:
            [self.captureController cancel];
            break;
            
        case TAG_CONTINUOUS:
            [self.captureController saveImage:[self capture] imageFrame:[_window rect]];
            break;
            
        case TAG_COPY:
            [self.captureController copyImage:[self capture] imageFrame:[_window rect]];
            break;
        
        default:
            [self.captureController cancel];
            break;
    }
}

- (NSMenu *)menuForEvent:(NSEvent *)theEvent
{
    return [super menuForEvent:theEvent];
}

- (void)changedImageFormatTo:(int)image_format
{
}

@end
