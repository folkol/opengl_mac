#include <AppKit/NSApplication.h>
#include <AppKit/NSWindow.h>
#include <AppKit/NSMenu.h>

void create_window() {
  @autoreleasepool {
    [NSApplication sharedApplication];
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];

    id menubar = [[NSMenu new] autorelease];
    id appMenuItem = [[NSMenuItem new] autorelease];
    [menubar addItem:appMenuItem];
    [NSApp setMainMenu:menubar];
    id appMenu = [[NSMenu new] autorelease];
    id appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    id quitTitle = [@"Quit " stringByAppendingString:appName];
    id quitMenuItem = [[[NSMenuItem alloc] initWithTitle:quitTitle
                                           action:@selector(terminate:)
                                           keyEquivalent:@"q"] autorelease];
    [appMenu addItem:quitMenuItem];
    [appMenuItem setSubmenu:appMenu];

    NSRect frame = NSMakeRect(100, 100, 500, 500);
    NSWindow* window  = [[[NSWindow alloc] initWithContentRect:frame
                                           styleMask:NSBorderlessWindowMask
                                           backing:NSBackingStoreBuffered
                                           defer:NO] autorelease];

    [window makeKeyAndOrderFront:NSApp];

    [NSApp activateIgnoringOtherApps:YES];
    [NSApp run];
  }
}

int main ()
{
  create_window();
}
