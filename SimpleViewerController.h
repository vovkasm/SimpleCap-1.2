//
//  SimpleViewerController.h
//  SimpleCap
//
//  Created by - on 08/12/19.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "ApplicationMenu.h"

@interface SimpleViewerController : NSObject <ApplicationMenuDelegate, NSMenuDelegate, NSWindowDelegate, NSTextFieldDelegate>

- (void)close;
- (void)show;
- (BOOL)isOpened;
- (NSString*)filename;

- (void)openWithFile:(NSString*)filename isNew:(BOOL)new_flag;
- (void)showFile:(NSString*)filename isFitToImage:(BOOL)is_fit withDirection:(int)direction;

- (void)flagsChanged:(NSEvent *)theEvent;

- (CGFloat)reductionRatio;
- (NSBitmapImageRep*)currentBitmapImageRepIsReduction:(BOOL)is_reduction;
- (void)keyDown:(id)theEvent;

- (void)endEditFilenameIsCancel:(BOOL)is_cancel;

// delegate methods
// clickedSimpleViewerAtTag:withFilename:

// for SimpleViewerImageView
- (NSMenu *)menuForEvent:(NSEvent *)theEvent;
- (void)copyFileTo:(NSURL*)dst_url;

// for IB
- (IBAction)clickedCopy:(id)sender;
- (IBAction)clickedMoveToTrash:(id)sender;
- (IBAction)clickedSave:(id)sender;
- (IBAction)clickedPrevious:(id)sender;
- (IBAction)clickedNext:(id)sender;
- (IBAction)clickedCaptureAgain:(id)sender;
- (IBAction)clickedRetake:(id)sender;
- (IBAction)clickedOpenWithApplication:(id)sender;
- (IBAction)clickedDuplicate:(id)sender;

// for Context Menu (bindings)
- (BOOL)backgroundBlack;
- (void)setBackgroundBlack:(BOOL)flag;
- (BOOL)backgroundWhite;
- (void)setBackgroundWhite:(BOOL)flag;
- (BOOL)backgroundCheckboard;
- (void)setBackgroundCheckboard:(BOOL)flag;

// for File management
-(BOOL)updateOpendFile;

@end
