//
//  ThinButtonBar.h
//  Button
//
//  Created by hashi on 08/05/10.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

enum SC_BUTTON_POSITION {
	SC_BUTTON_POSITION_CENTER,
	SC_BUTTON_POSITION_CENTER_BOTTOM,
	SC_BUTTON_POSITION_LEFT_TOP,
	SC_BUTTON_POSITION_RIGHT_TOP,
	SC_BUTTON_POSITION_LEFT_BOTTOM,
	SC_BUTTON_POSITION_RIGHT_BOTTOM
};


@class ThinButton;

@protocol ThinButtonBarDelegate <NSObject>

- (void)clickedAtTag:(NSNumber*)tag event:(NSEvent*)event;

@end

@interface ThinButtonBar : NSView

@property (nonatomic, weak) id<ThinButtonBarDelegate> delegate;

- (void)addButtonWithImageResource:(NSString*)resource alterImageResource:(NSString*)resource2 tag:(UInt)tag tooltip:(NSString*)tooltip group:(NSString*)group isActOnMouseDown:(BOOL)is_act_mouse_down;
- (void)reset;
- (void)setButtonBarWithFrame:(NSRect)frame;
- (void)setPosition:(int)position;
- (void)resetGroup:(NSString*)group;
- (void)switchGroup:(NSString*)group;

- (void)setShadow:(BOOL)is_shadow;
- (void)setDrawOffset:(NSPoint)offset;

- (void)show;
- (void)hide;
- (void)update;

- (void)setPopupMenuMode:(BOOL)mode;

- (void)setMarginY:(CGFloat)marginY;

- (void)startFlasher;

- (NSSize)size;

@end
