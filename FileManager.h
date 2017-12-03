//
//  FileManager.h
//  SimpleCap
//
//  Created by - on 08/03/08.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class FileList;
@class FileEntry;

@interface FileManager : NSObject

- (NSString*)path;
- (NSString*)nextFilename;
- (NSString*)saveImage:(NSBitmapImageRep*)bitmap_rep;
- (NSString*)saveImage:(NSBitmapImageRep*)bitmap_rep withFilename:(NSString*)filename;
- (void)setSerialFlag:(BOOL)flag;

// for simple viewer
- (NSString*)previousFilenameInSaveFolderWithCurrentFilename:(NSString*)filename;
- (NSString*)nextFilenameInSaveFolderWithCurrentFilename:(NSString*)filename;
- (NSString*)filenameAfterDeleteFilename:(NSString*)filename;
- (NSString*)lastFilename;
- (void)moveToTrash:(NSString*)filename;
- (BOOL)renameFrom:(NSString*)old_path To:(NSString*)new_path;
- (BOOL)isExistPath:(NSString*)path;
- (int)index;
- (int)count;
- (FileEntry*)currentFile;
@end
