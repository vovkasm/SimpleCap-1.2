//
//  WindowUtility.m
//  SimpleCap
//
//  Created by - on 09/01/03.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import "DesktopWindow.h"

@implementation DesktopWindow {
    NSArray* _idList;
}

static DesktopWindow* _desktop_window = nil;

+ (DesktopWindow*)sharedDesktopWindow {
    if (!_desktop_window) {
        _desktop_window = [[DesktopWindow alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:_desktop_window
                                                 selector:@selector(screenChanged:)
                                                     name:NSApplicationDidChangeScreenParametersNotification
                                                   object:nil];
        [_desktop_window update];
    }
    return _desktop_window;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)update {
    CFArrayRef ar = CGWindowListCopyWindowInfo(kCGWindowListOptionOnScreenOnly, kCGNullWindowID);
    
    NSMutableArray* windowIds = [[NSMutableArray alloc] init];
    
    for (CFIndex i=0; i < CFArrayGetCount(ar); i++) {
        CFDictionaryRef window = CFArrayGetValueAtIndex(ar, i);
        NSString* name = (NSString*)CFDictionaryGetValue(window, kCGWindowName);
        NSString* owner_name = (NSString*)CFDictionaryGetValue(window, kCGWindowOwnerName);
        if ([name isEqualToString:@"Desktop"] && [owner_name isEqualToString:@"Window Server"]) {
            CGWindowID wid;
            CFNumberGetValue(CFDictionaryGetValue(window, kCGWindowNumber), kCGWindowIDCFNumberType, &wid);
            [windowIds addObject:[NSNumber numberWithUnsignedInt:wid]];
        }
    }
    
    CFRelease(ar);
    
    _idList = windowIds;
}

- (NSArray*)CGWindowIDlist {
    return _idList;
}

- (void)screenChanged:(NSNotification *)notification {
    [self update];
}

@end
