//
//  HotkeyTextView.h
//

#import <Cocoa/Cocoa.h>

@class Hotkey;
@interface HotkeyTextView : NSTextView

@property (retain) Hotkey* hotkey;
@property (retain) id target;

- (void)endEdit;

@end
