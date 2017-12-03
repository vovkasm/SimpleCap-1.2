//
//  LaunchedApplications.h
//  SimpleCap
//
//  Created by - on 08/07/02.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol LaunchedApplicationsDelegate

- (void)selectApplication:(id)sender;

@end

@interface LaunchedApplications : NSObject

@property (nonatomic, weak) id<LaunchedApplicationsDelegate> delegate;

- (instancetype)initWithDelegate:(id<LaunchedApplicationsDelegate>)delegate;
- (void)updateApplicationMenu:(NSMenu*)menu;

@end
