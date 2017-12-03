//
//  PreferedApplications.h
//  FindingAllApps
//
//  Created by - on 08/10/29.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol ApplicationMenuDelegate

- (void)openWithApplication:(id)sender;
- (void)openPereferecesWindow:(id)tabIndex;

@end

@interface ApplicationMenu : NSObject

- (instancetype)initWithTargetPath:(NSString*)path delegate:(id<ApplicationMenuDelegate>)delegate;
- (NSArray*)menuItems;
- (NSMenu*)menu;
- (NSInteger)indexForPath:(NSString*)path;
- (NSString*)pathAtIndex:(NSInteger)index;

@end
