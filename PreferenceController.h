//
//  PreferenceController.h
//  SimpleCap
//
//  Created by - on 08/09/12.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferenceController : NSObject <NSToolbarDelegate, NSAnimationDelegate>

- (void)chooseImageLocation:(id)sender;

- (IBAction)clickImageOptions:(id)sender;
- (IBAction)clickSelectionOptions:(id)sender;
//- (IBAction)clickScreenOptions:(id)sender;
- (IBAction)chooseApplication:(id)sender;

- (IBAction)selectImageFormat:(id)sender;

- (void)openAtTabIndex:(NSInteger)tab_index;
- (void)setTabIndex:(NSInteger)tab_index;

- (void)registHotkeysFromDefaults;
- (IBAction)resetHotkey:(id)sender;

- (void)applicationWillTerminate;

- (IBAction)clickAutostartCheckbox:(id)sender;
- (void)enableLoginItem;
- (void)disableLoginItem;
- (BOOL)isEnableLoginItem;
- (void)updateToolbarOnGeneral;

@end
