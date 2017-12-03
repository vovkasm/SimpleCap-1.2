//
//  CustomButtonCell.h
//  MatrixSample
//
//  Created by - on 09/12/08.
//  Copyright 2009 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>
enum {
    CELL_STATE_OFF,
    CELL_STATE_ON,
    CELL_STATE_OVER
};

@interface ApplicationButtonCell : NSCell

@property (strong) NSImage* image;
@property (strong) NSString* name;
@property (strong) NSString* path;
@property (assign) NSUInteger cellState;

-(id)initWithPath:(NSString*)appPath;
+(ApplicationButtonCell*)cellWithPath:(NSString*)appPath;

@end
