//
//  FileList.m
//  SimpleCap
//
//  Created by - on 09/01/18.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import "FileList.h"
#import "FileEntry.h"

@implementation FileList {
    NSMutableArray* _list;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _list = [[NSMutableArray alloc] init];
    }
    return self;
}


- (BOOL)isTargetFilename:(NSString*)filename {
    NSString* ext = [[filename pathExtension] lowercaseString];
    if ([ext isEqualToString:@"png"]) {
        return YES;
    }
    if ([ext isEqualToString:@"gif"]) {
        return YES;
    }
    if ([ext isEqualToString:@"jpg"]) {
        return YES;
    }
    return NO;
}

-(void)setPath:(NSString*)path {
    NSError* error;
    [_list removeAllObjects];    // **clear**

    NSFileManager* fm = [NSFileManager defaultManager];
    FileEntry* entry;
    for(NSString* filename in [fm contentsOfDirectoryAtPath:path error:&error]) {
        if ([self isTargetFilename:filename]) {
            entry = [[FileEntry alloc] initWithFilename:filename
                     fileAttributes:[fm fileAttributesAtPath:[path stringByAppendingPathComponent:filename] traverseLink:NO]];
            [_list addObject:entry];
        }
    }

    [_list sortUsingSelector:@selector(compare:)];
}

- (NSUInteger)count {
    return [_list count];
}

- (NSUInteger)indexWithFilename:(NSString*)filename {
    NSUInteger index = 0;
    for (FileEntry* entry in _list) {
        if ([entry.name isEqualToString:filename]) {
            break;
        }
        index++;
    }
    return index;
}

- (FileEntry*)fileEntryAtIndex:(NSUInteger)index {
    return [_list objectAtIndex:index];
}

- (void)removeAtIndex:(NSUInteger)index {
    if (index < _list.count) {
        [_list removeObjectAtIndex:index];
    }
}

@end
