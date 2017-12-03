//
//  PreferedApplications.m
//  FindingAllApps
//
//  Created by - on 08/10/29.
//  Copyright 2008 Hiroshi Hashiguchi. All rights reserved.
//

#import "ApplicationMenu.h"
#import "UserDefaults.h"

//---------------------------------------------------------------------------
@interface AppEntry : NSObject
{
    NSString* _path;
    NSString* _name;
    NSImage* _image;
}
@property (strong) NSString* path;
@property (strong) NSString* name;
@property (strong) NSImage* image;

-(id)initWithPath:(NSString*)path;
@end

@implementation AppEntry
@synthesize path = _path;
@synthesize name = _name;
@synthesize image = _image;

-(id)initWithPath:(NSString*)app_path
{
    self = [super init];
    if (self) {
        _path = app_path;
        
        CFStringRef name = nil;
        LSCopyDisplayNameForURL((__bridge CFURLRef)[NSURL fileURLWithPath:_path], &name);
        _name = (__bridge NSString*)name;
        CFRelease(name);
        
        _image = [[NSWorkspace sharedWorkspace] iconForFile:_path];
        [_image setSize:NSMakeSize(16, 16)];
    }
    return self;
}

- (NSComparisonResult)compare:(AppEntry*)entry
{
    return [_name compare:entry.name];
}

@end

//---------------------------------------------------------------------------
@interface ApplicationMenu ()

@property (nonatomic, weak) id<ApplicationMenuDelegate> delegate;

@end

@implementation ApplicationMenu {
    NSArray* _menu_items;
    NSMenu* _prefered_menu;
    NSMenuItem* _prefered_menu_item;
}

- (NSMenuItem*)menuItemWithAppEntry:(AppEntry*)entry
{
    NSMenuItem* item = [[NSMenuItem alloc] init];
    [item setTitle:entry.name];
    [item setImage:entry.image];
    [item setTarget:_delegate];
    [item setAction:@selector(openWithApplication:)];
    [item setRepresentedObject:
     [NSDictionary dictionaryWithObjectsAndKeys:entry.path, @"path", nil]];
    return item;
}

- (void)createMenuItemsWithTargetPath:(NSString*)target_path
{
    // *not be used* 2009-02-23
    NSURL* target_url = [NSURL fileURLWithPath:target_path];
    NSMutableArray* item_list = [NSMutableArray array];
    AppEntry* entry;
    NSString* path;

    // (1) default application
    FSRef outAppRef;
    CFURLRef default_url_cf = nil;

    LSGetApplicationForURL((__bridge CFURLRef)target_url, kLSRolesAll, &outAppRef, &default_url_cf);
    NSURL* default_url = (__bridge_transfer NSURL*)default_url_cf;
    
    entry = [[AppEntry alloc] initWithPath:[default_url path]];
    [item_list addObject:[self menuItemWithAppEntry:entry]];

    path = @"/Applications/Mail.app";
    entry = [[AppEntry alloc] initWithPath:path];
    [item_list addObject:[self menuItemWithAppEntry:entry]];
        
    // (-) separator
    [item_list addObject:[NSMenuItem separatorItem]];
    

    // (2) preffered applications
    NSArray* app_list = (NSArray*)CFBridgingRelease(LSCopyApplicationURLsForURL((__bridge CFURLRef)target_url, kLSRolesAll));
    
    NSMutableArray* entry_list = [NSMutableArray array];
    
    for (NSURL* url in app_list) {
        if ([url isEqual:default_url]) {
            continue;
        }
        entry = [[AppEntry alloc] initWithPath:[url path]];
        [entry_list addObject:entry];
    }
    
    NSArray* sorted_entry_list = [entry_list sortedArrayUsingSelector:@selector(compare:)];
    
    _prefered_menu = [[NSMenu alloc] initWithTitle:@"Prefered Applications"];
    for (AppEntry* entry in sorted_entry_list) {
        [_prefered_menu addItem:[self menuItemWithAppEntry:entry]];
    }
    _prefered_menu_item = [[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"AppMenuOther", @"")
                                                      action:nil
                                               keyEquivalent:@""];
    [item_list addObject:_prefered_menu_item];

    _menu_items = item_list;
}

- (instancetype)initWithTargetPath:(NSString*)path delegate:(id)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
//        [self createMenuItemsWithTargetPath:path];
    }
    return self;
}

- (NSArray*)menuItems
{
    return _menu_items;
}

- (NSInteger)indexForPath:(NSString*)path
{
    NSInteger index = 0;
    for (NSMenuItem* item in _menu_items) {
        NSDictionary* dict = [item representedObject];
        NSString* item_path = [dict objectForKey:@"path"];
        if ([item_path isEqualToString:path]) {
            break;
        }
        index++;
    }
    return index;
    // not found: return 0
}

- (NSString*)pathAtIndex:(NSInteger)index
{
    NSMenuItem* item = [_menu_items objectAtIndex:index];
    NSDictionary* dict = [item representedObject];
    return [dict objectForKey:@"path"];
}

-(NSMenu*)menu
{
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@"Application Menu"];
    NSString* path;
    AppEntry* entry;

    // (1) preest applications
    path = [UserDefaults valueForKey:UDKEY_APPLICATION1];
    if (path) {
        entry = [[AppEntry alloc] initWithPath:path];
        [menu addItem:[self menuItemWithAppEntry:entry]];
    }
    
    path = [UserDefaults valueForKey:UDKEY_APPLICATION2];
    if (path) {
        entry = [[AppEntry alloc] initWithPath:path];
        [menu addItem:[self menuItemWithAppEntry:entry]];
    }
    
    path = [UserDefaults valueForKey:UDKEY_APPLICATION3];
    if (path) {
        entry = [[AppEntry alloc] initWithPath:path];
        [menu addItem:[self menuItemWithAppEntry:entry]];
    }
    
    path = [UserDefaults valueForKey:UDKEY_APPLICATION4];
    if (path) {
        entry = [[AppEntry alloc] initWithPath:path];
        [menu addItem:[self menuItemWithAppEntry:entry]];
    }
    
    path = [UserDefaults valueForKey:UDKEY_APPLICATION5];
    if (path) {
        entry = [[AppEntry alloc] initWithPath:path];
        [menu addItem:[self menuItemWithAppEntry:entry]];
    }
    
    // (-) separator
    [menu addItem:[NSMenuItem separatorItem]];

    // open preferences
    NSString* title = NSLocalizedString(@"MenuSetupApplications", @"");
    NSMenuItem* item = [[NSMenuItem alloc] initWithTitle:title action:@selector(openPereferecesWindow:) keyEquivalent:@""];
    [item setTarget:_delegate];
    [item setRepresentedObject:[NSNumber numberWithInt:3]];        // 3->Preference Tab:3 (viewer option)
    [menu addItem:item];
    
    /*
    // (-) separator
    [menu addItem:[NSMenuItem separatorItem]];

    // (2) prefered applications
    for (NSMenuItem* item in _menu_items) {
        [menu addItem:item];
    }

    [menu setSubmenu:_prefered_menu forItem:_prefered_menu_item];
    */
    return menu;
}

@end
