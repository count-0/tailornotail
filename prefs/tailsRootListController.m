#include "tailsRootListController.h"
#import <CepheiPrefs/HBSupportController.h>

@implementation tailsRootListController

+ (NSString *)hb_specifierPlist {
    return @"Root";
}

+ (NSString *)hb_shareText {
    return @"Make your messages classy";
}

+(NSString *)hb_shareURL {
    return @"";
}

- (void)showSupportEmailController {
	UIViewController *viewController = (UIViewController *)[HBSupportController supportViewControllerForBundle:[NSBundle bundleForClass:self.class] preferencesIdentifier:@"com.dopeteam.tails"];
	[self.navigationController pushViewController:viewController animated:YES];
}

@end
