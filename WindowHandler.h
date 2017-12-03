//
//  WindowHandler.h
//  SimpleCap
//
//  Created by - on 08/06/25.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HandlerBase.h"
#import "Handler.h"
#import "TimerClient.h"
#import "ThinButtonBar.h"

@interface WindowHandler : HandlerBase <ThinButtonBarDelegate, Handler, TimerClient> 

@end
