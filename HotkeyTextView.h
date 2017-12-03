//
//  HotkeyTextView.h
//

#import <Cocoa/Cocoa.h>

@class Hotkey;
@interface HotkeyTextView : NSTextView

@property (strong) Hotkey* hotkey;
@property (strong) id target;

- (void)endEdit;

@end
