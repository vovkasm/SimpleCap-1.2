//
//  ButtonPallete.h
//  MatrixSample
//
//  Created by - on 09/12/08.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ApplicationButtonPallete : NSObject

@property (strong) id target;
@property (assign) SEL action;

-(void)addButtonWithPath:(NSString*)path;
-(void)removeAll;

-(void)addToView:(NSView*)view;
-(void)setOrigin:(NSPoint)point;
-(void)updateLayout;

@end
