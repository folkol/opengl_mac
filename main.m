#include <AppKit/NSApplication.h>
#include <AppKit/NSScreen.h>
#include <AppKit/NSWindow.h>
#include <AppKit/NSMenu.h>
#include <AppKit/NSOpenGL.h>
#include <AppKit/NSOpenGLView.h>

#include <OpenGL/gl.h>

void create_window() {
  @autoreleasepool {
    [NSApplication sharedApplication];
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];

    id menubar = [[NSMenu new] autorelease];
    id appMenuItem = [[NSMenuItem new] autorelease];
    id appMenu = [[NSMenu new] autorelease];
    id appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    id quitTitle = [@"Quit " stringByAppendingString:appName];
    id quitMenuItem = [[[NSMenuItem alloc] initWithTitle:quitTitle
                                           action:@selector(terminate:)
                                           keyEquivalent:@"q"] autorelease];
    [appMenu addItem:quitMenuItem];
    [appMenuItem setSubmenu:appMenu];
    [menubar addItem:appMenuItem];
    [NSApp setMainMenu:menubar];

    NSRect frame = [[NSScreen mainScreen] frame];
    NSWindow* window  = [[[NSWindow alloc] initWithContentRect:frame
                                           styleMask:NSBorderlessWindowMask
                                           backing:NSBackingStoreBuffered
                                           defer:YES] autorelease];
    [window setLevel:NSMainMenuWindowLevel+1];
    [window setOpaque:YES];
    [window setHidesOnDeactivate:YES];

    NSOpenGLPixelFormatAttribute attrs[] =
    {
      NSOpenGLPFADoubleBuffer,
      0
    };
    NSOpenGLPixelFormat* pixelFormat = [[NSOpenGLPixelFormat alloc] initWithAttributes:attrs];
    
    NSRect viewRect = NSMakeRect(0.0, 0.0, frame.size.width, frame.size.height);
    NSOpenGLView *fullScreenView = [[NSOpenGLView alloc] initWithFrame:viewRect pixelFormat: pixelFormat];
    [window setContentView: fullScreenView];
    
    [window makeKeyAndOrderFront:NSApp];

    [NSApp activateIgnoringOtherApps:YES];
    [NSApp run];
  }
}

int main ()
{
  create_window();
}
