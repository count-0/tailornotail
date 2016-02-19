#import <libcolorpicker.h>
#import <CepheiPrefs/HBListController.h>
#import <Cephei/HBPreferences.h>
#include <notify.h>

@interface tailsdBubbleListController : HBListController
@property (nonatomic, retain) NSString *setting;
-(void)colorPicker;
@end

@implementation tailsdBubbleListController

+ (NSString *)hb_specifierPlist {
    return @"defaultBubble";
}

- (void)setSpecifier:(PSSpecifier *)specifier {
	self.setting = [specifier propertyForKey:@"label"];
	if([self.setting isEqualToString:@"Default Bubble Theme"])
		self.setting = @"default";
	HBLogDebug(@"%@", self.setting);
}

-(void)colorPicker{
	HBLogDebug(@"libColorPickerAlert called");
	NSString *color;
   HBPreferences *_preferences = [[HBPreferences alloc] initWithIdentifier:@"com.dopeteam.tailornotail"];
   [_preferences registerObject:&color default:@"#FFFFFF" forKey:[NSString stringWithFormat:@"%@-botColor", self.setting]];

  if(!color)
    HBLogError(@"Error getting color value from prefs, using fallback");

  UIColor *startColor = LCPParseColorString(color, @"#FFFFFF");

  PFColorAlert *alert = [PFColorAlert colorAlertWithStartColor:startColor showAlpha:YES];

  [alert displayWithCompletion:
    ^void (UIColor *pickedColor){
      NSString *hexString = [UIColor hexFromColor:pickedColor];
      hexString = [hexString stringByAppendingFormat:@":%g", pickedColor.alpha];
      _preferences[[NSString stringWithFormat:@"%@-botColor", self.setting]] = hexString;
      notify_post("com.dopeteam.dopelock/ReloadPrefs");
    }
  ];
}

@end
