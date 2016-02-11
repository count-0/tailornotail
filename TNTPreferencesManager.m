#import "TNTPreferencesManager.h"
#import <libcolorpicker.h>

static NSString *const kTNTEnabledKey = @"EnableTweak";
static NSString *const kTNTTailsKey = @"EnableTails";


@implementation TNTPreferencesManager {
	HBPreferences *_preferences;
}

+ (instancetype)sharedInstance {
	static TNTPreferencesManager *sharedInstance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[self alloc] init];
	});

	return sharedInstance;
}

- (instancetype)init {
	if (self = [super init]) {
		_preferences = [[HBPreferences alloc] initWithIdentifier:@"com.dopeteam.tailornotail"];
	//BOOL Preferences
	[_preferences registerBool:&_enabled default:YES forKey:kTNTEnabledKey];
	[_preferences registerBool:&_enableTails default:YES forKey:kTNTTailsKey];
	//HBLogDebug(@"%@ %@", _botColor, _topColor);
	}
	return self;
}

- (UIColor *)colorForPreference:(NSString *)string {

	NSString *potentialIndividualTint = _preferences[string];
	if (potentialIndividualTint) {
		return LCPParseColorString(potentialIndividualTint, @"#000000");
	}
	return [UIColor clearColor];
}

#pragma mark - Memory management

- (void)dealloc {
	[_preferences release];

	[super dealloc];
}

@end