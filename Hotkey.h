//
//  Hotkey.h
//

#import <Foundation/Foundation.h>
#import <Carbon/Carbon.h>

@interface Hotkey : NSObject

@property UInt32 keyid;
@property UInt32 modifier;
@property UInt32 code;
@property EventHotKeyRef ref;
@property (strong) NSString* savekey;
@property (strong) id target;

+ (NSNumber*)numberValueWithKeycode:(UInt32)code modifier:(UInt32)modifier;
- (NSNumber*)numberValue;
- (id)initWithSavekey:(NSString*)savekey number:(NSNumber*)number target:(id)target;
//- (id)initWithCode:(UInt32)code modifier:(UInt32)modifier target:(id)target;
//+ (id)hotkeyWithCode:(UInt32)code modifier:(UInt32)modifier target:(id)target;

- (NSString*)string;
- (BOOL)isHotkey;

+ (BOOL)isHotKeyForKeyCode:(UInt32)keycode;
+ (BOOL)isHotKeyForModifier:(UInt32)modifier;

- (NSString*)dump;


@end
