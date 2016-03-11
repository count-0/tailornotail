#include "tailsRootListController.h"
#import <CepheiPrefs/HBSupportController.h>
#include "Generic.h"
@implementation tailsRootListController

+ (NSString *)hb_specifierPlist {
    return @"Root";
}

+ (NSString *)hb_shareText {
    return @"Make your messages classy using Tails or No Tails! ";
}

+(NSString *)hb_shareURL {
    return @"";
}

+ (UIColor *)hb_tintColor {
    return [UIColor colorWithRed:0.71 green:0.22 blue:0.19 alpha:1.0];
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
        titleImage = [UIImage imageNamed:@"TNTImages/TNTVector.png" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
    }
    else {
        titleImage = [UIImage imageNamed:@"TNTImages/TNTVector.png" inBundle:[NSBundle bundleForClass:self.class]];
    }
    titleImage = [titleImage changeImageColor:[UIColor colorWithRed:0.71 green:0.22 blue:0.19 alpha:1.0]];
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
    name.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:48];
    name.backgroundColor = [UIColor clearColor];
    name.textColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
    name.textAlignment = NSTextAlignmentCenter;
    [header addSubview:name];
    
    UILabel *subText = [[UILabel alloc] initWithFrame:CGRectMake(header.frame.origin.x, name.frame.origin.y + name.frame.size.height, header.frame.size.width, 20)];

    subText.text = @"The ignition for your messages!";
    subText.textAlignment = NSTextAlignmentCenter;
    subText.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    subText.backgroundColor = [UIColor clearColor];
    subText.textColor = [UIColor colorWithRed:0.71 green:0.22 blue:0.19 alpha:1.0];
    subText.textAlignment = NSTextAlignmentCenter;
    [header addSubview:subText];
    
    [self.table setTableHeaderView:header];
}


@end
