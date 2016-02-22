#import <libcolorpicker.h>
#import <CepheiPrefs/HBListController.h>
#import <Cephei/HBPreferences.h>
#include <notify.h>

@interface tailsdBubbleListController : HBListController
@end

@implementation tailsdBubbleListController

+ (NSString *)hb_specifierPlist {
    return @"defaultBubble";
}

@end
