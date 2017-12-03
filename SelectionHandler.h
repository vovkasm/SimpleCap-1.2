//
//  SelectionHandler.h
//  SimpleCap
//
//  Created by - on 08/03/16.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HandlerBase.h"
#import "Handler.h"
#import "TimerClient.h"
#import "ThinButtonBar.h"

@interface SelectionHandler : HandlerBase <ThinButtonBarDelegate, Handler, TimerClient>

-(void)setRubberBandFrame:(NSRect)frame;

@end
