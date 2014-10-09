#include <AppKit/NSApplication.h>
#include <AppKit/NSWindow.h>
#include <AppKit/NSMenu.h>

// cc -framework AppKit -x objective-c main.m
void create_window() {
  @autoreleasepool {
    [NSApplication sharedApplication];
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];

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
