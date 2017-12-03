//
//  LaunchedApplications.h
//  SimpleCap
//
//  Created by - on 08/07/02.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface LaunchedApplications : NSObject {
	id	_delegate;
}

- (instancetype)initWithDelegate:(id)delegate;
- (void)updateApplicationMenu:(NSMenu*)menu;

@end
