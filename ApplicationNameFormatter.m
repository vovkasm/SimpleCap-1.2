//
//  LastComponentFormatter.m
//  SimpleCap
//
//  Created by - on 09/01/12.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import "ApplicationNameFormatter.h"

@implementation ApplicationNameFormatter

- (NSString *)stringForObjectValue:(id)anObject {
	NSString* name = nil;
    [[NSURL fileURLWithPath:anObject] getResourceValue:&name forKey:NSURLLocalizedNameKey error:nil];
	
	if (!name) {
		name = @"(not found)";
	}
	return name;
}

- (BOOL)getObjectValue:(id *)anObject forString:(NSString *)string errorDescription:(NSString **)error {
	return NO;
}

@end
