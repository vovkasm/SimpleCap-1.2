//
//  FileList.h
//  SimpleCap
//
//  Created by - on 09/01/18.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "FileEntry.h"

@interface FileList : NSObject

@property (nonatomic, readonly) NSUInteger count;

- (void)setPath:(NSString*)path;
- (NSUInteger)indexWithFilename:(NSString*)filename;
- (FileEntry*)fileEntryAtIndex:(NSUInteger)index;
- (void)removeAtIndex:(NSUInteger)index;
@end
