#include "tailsRootListController.h"
#import <CepheiPrefs/HBSupportController.h>
#include "Generic.h"
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

-(void) viewWillAppear:(BOOL) animated{
	[super viewWillAppear:animated];
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad){
        self.table.contentInset = UIEdgeInsetsMake(-5, 0, 0, 0);
    }
	[self setupHeader];
    [self setupTitle];
}

-(void)setupTitle{
    UIImage *titleImage;
    if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
        titleImage = [UIImage imageNamed:@"images/TNTVector.png" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
    }
    else {
        titleImage = [UIImage imageNamed:@"images/TNTVector.png" inBundle:[NSBundle bundleForClass:self.class]];
    }
    titleImage = [titleImage changeImageColor:[UIColor blueColor]];
    UIImageView *titleView = [[UIImageView alloc] initWithImage:titleImage];
    titleView.contentMode = UIViewContentModeScaleAspectFit;
    [self.navigationItem setTitleView:titleView];
}


-(void)setupHeader{
	UIView *header = nil;
    header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0,30,self.view.bounds.size.width,45)];
    name.text = @"Tails or no Tails";
    name.textAlignment = NSTextAlignmentCenter;
    name.font = [name.font fontWithSize:55];
    [header addSubview:name];
    [self.table setTableHeaderView:header];
}

@end
