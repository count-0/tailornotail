#import <libcolorpicker.h>
#import <CepheiPrefs/HBListController.h>

@interface tailsiBubbleListController : HBListController
@end

@implementation tailsiBubbleListController

+ (NSString *)hb_specifierPlist {
    return @"iMessageBubble";
}

@end
