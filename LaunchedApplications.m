//
//  LaunchedApplications.m
//  SimpleCap
//
//  Created by - on 08/07/02.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import "LaunchedApplications.h"

@implementation LaunchedApplications

- (instancetype)initWithDelegate:(id<LaunchedApplicationsDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

- (void)updateApplicationMenu:(NSMenu*)menu {
    [menu removeAllItems];
    NSWorkspace* ws = [NSWorkspace sharedWorkspace];
    for (NSDictionary* app in [ws launchedApplications]) {
        NSString* name = [app objectForKey:@"NSApplicationName"];
        NSImage* image = [ws iconForFile:[app objectForKey:@"NSApplicationPath"]];
        NSNumber *pid = [app objectForKey:@"NSApplicationProcessIdentifier"];
        [image setSize:NSMakeSize(16, 16)];

        NSMenuItem* item = [[NSMenuItem alloc] init];
        [item setTitle:name];
        [item setImage:image];
        [item setTarget:_delegate];
        [item setAction:@selector(selectApplication:)];
        [item setRepresentedObject:
         [NSDictionary dictionaryWithObjectsAndKeys:
          name, @"name", image, @"image", pid, @"pid", nil]];
        [menu addItem:item];
    }
}

@end
