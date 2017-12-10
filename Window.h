//
//  Window.h
//  SimpleCap
//
//  Created by - on 08/07/05.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Window : NSObject

-(int)order;
-(void)setOrder:(int)order;
-(CGWindowID)windowID;
-(NSNumber*)numberWindowID;
-(int)ownerPID;
-(NSString*)windowName;
-(NSString*)ownerName;
-(int)layer;
-(int)workspace;

-(NSRect)rect;
-(CGRect)cgrect;

-(void)setRect:(NSRect)rect;
-(NSImage*)image;
- (void)updateImage;
- (id)initWithWindowDictionaryRef:(CFDictionaryRef)window;

- (BOOL)isNormalWindow:(BOOL)normal;
- (BOOL)isWidget;
- (BOOL)isSpotlight;
- (BOOL)isDock;

+ (NSRect)unionNSRectWithWindowList:(NSArray*)list;
+ (CGRect)unionCGRectWithWindowList:(NSArray*)list;
+ (Window*)statusBarWindow;


@end
