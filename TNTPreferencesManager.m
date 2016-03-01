#import "TNTPreferencesManager.h"
#import <libcolorpicker.h>

static NSString *const kTNTEnabledKey = @"EnableTweak";
static NSString *const kTNTTailsKey = @"EnableTails";
static NSString *const kTNTTailsiMessageKey = @"imessage-EnableTails";
static NSString *const kTNTTailsSMSKey = @"sms-EnableTails";
static NSString *const kTNTSMSEnableKey = @"sms-Enable";
static NSString *const kTNTiMessageEnableKey = @"imessage-Enable";
static NSString *const kTNTTopColorKey = @"TopColor";
static NSString *const kTNTBotColorKey = @"BotColor";
static NSString *const kTNTSenderKey = @"sender";
static NSString *const kTNTReceivedKey = @"received";
static NSString *const kTNTFontColorKey = @"FontColor";
static NSString *const kTNTColorBackgroundKey = @"colorBackground";
static NSString *const kTNTWallpaperBackgroundKey = @"wallpaperBackground";
static NSString *const kTNTVariantKey = @"variant";
static NSString *const kTNTLastPhotoKey = @"lastPhoto";


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
		//BOOL preferences
		[_preferences registerBool:&_enabled default:YES forKey:kTNTEnabledKey];
		[_preferences registerBool:&_enableTails default:YES forKey:kTNTTailsKey];
		[_preferences registerBool:&_enableiMessageTails default:YES forKey:kTNTTailsiMessageKey];
		[_preferences registerBool:&_enablesmsTails default:YES forKey:kTNTTailsSMSKey];
		[_preferences registerBool:&_smsEnable default:NO forKey:kTNTSMSEnableKey];
		[_preferences registerBool:&_imessageEnable default:NO forKey:kTNTiMessageEnableKey];
		[_preferences registerBool:&_enableCB default:YES forKey:kTNTColorBackgroundKey];
		[_preferences registerBool:&_enableWB default:NO forKey:kTNTWallpaperBackgroundKey];
		[_preferences registerBool:&_enableLB default:NO forKey:kTNTLastPhotoKey];

		//INT preferences
		[_preferences registerInteger:_variant default:0 forKey:kTNTVariantKey];
	}
	return self;
}

- (UIColor *)colorForPreference:(NSString *)string fallback:(NSString *)fallback {

	NSString *potentialIndividualTint = _preferences[string];
	if (potentialIndividualTint) {
		return LCPParseColorString(potentialIndividualTint, @"#000000");
	}
	return LCPParseColorString(fallback, @"#000000");
}

- (NSDictionary *)getColorDictionary:(NSString *)section
{
	UIColor *tSC, *bSC, *tRC, *bRC;
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	tSC = [self colorForPreference:[NSString stringWithFormat:@"%@-%@-%@",section,kTNTSenderKey,kTNTTopColorKey] fallback:@"#FFFFFF"];
	bSC = [self colorForPreference:[NSString stringWithFormat:@"%@-%@-%@",section,kTNTSenderKey,kTNTBotColorKey] fallback:@"#FFFFFF"];
	tRC = [self colorForPreference:[NSString stringWithFormat:@"%@-%@-%@",section,kTNTReceivedKey,kTNTTopColorKey] fallback:@"#FFFFFF"];
	bRC = [self colorForPreference:[NSString stringWithFormat:@"%@-%@-%@",section,kTNTReceivedKey,kTNTBotColorKey] fallback:@"#FFFFFF"];
	[dictionary setObject:tSC forKey:[NSString stringWithFormat:@"%@-%@", kTNTSenderKey, kTNTTopColorKey]];
	[dictionary setObject:bSC forKey:[NSString stringWithFormat:@"%@-%@", kTNTSenderKey, kTNTBotColorKey]];
	[dictionary setObject:tRC forKey:[NSString stringWithFormat:@"%@-%@", kTNTReceivedKey, kTNTTopColorKey]];
	[dictionary setObject:bRC forKey:[NSString stringWithFormat:@"%@-%@", kTNTReceivedKey, kTNTBotColorKey]];
	return dictionary;
}

- (NSDictionary *)getFontDictionary:(NSString *)section
{
	UIColor *fSC, *fRC;
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	fSC = [self colorForPreference:[NSString stringWithFormat:@"%@-%@-%@",section,kTNTSenderKey,kTNTFontColorKey] fallback:@"#000000"];
	fRC = [self colorForPreference:[NSString stringWithFormat:@"%@-%@-%@",section,kTNTReceivedKey,kTNTFontColorKey] fallback:@"#000000"];
	[dictionary setObject:fSC forKey:@"sender"];
	[dictionary setObject:fRC forKey:@"received"];
	return dictionary;
}


#pragma mark - Memory management

- (void)dealloc {
	[_preferences release];

	[super dealloc];
}

@end