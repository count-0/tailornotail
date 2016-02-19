#import <libcolorpicker.h>
#import <CepheiPrefs/HBListController.h>

@interface tailssBubbleListController : HBListController
@end

@implementation tailssBubbleListController

+ (NSString *)hb_specifierPlist {
    return @"SMSBubble";
}

@end
