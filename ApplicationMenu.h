//
//  PreferedApplications.h
//  FindingAllApps
//
//  Created by - on 08/10/29.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ApplicationMenu : NSObject

- (instancetype)initWithTargetPath:(NSString*)path delegate:(id)delegate;
- (NSArray*)menuItems;
- (NSMenu*)menu;
- (NSInteger)indexForPath:(NSString*)path;
- (NSString*)pathAtIndex:(NSInteger)index;

@end
