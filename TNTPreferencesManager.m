#import "TNTPreferencesManager.h"
#import <libcolorpicker.h>

static NSString *const kTNTEnabledKey = @"EnableTweak";
static NSString *const kTNTTailsKey = @"EnableTails";
static NSString *const kTNTTailsiMessageKey = @"imessage-EnableTails";
static NSString *const kTNTTailsSMSKey = @"sms-EnableTails";
static NSString *const kTNTSMSEnable = @"sms-Enable";
static NSString *const kTNTiMessageEnable = @"imessage-Enable";
static NSString *const kTNTTopColor = @"TopColor";
static NSString *const kTNTBotColor = @"BotColor";
static NSString *const kTNTSender = @"sender";
static NSString *const kTNTReceived = @"received";


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
	[_preferences registerBool:&_enableiMessageTails default:YES forKey:kTNTTailsiMessageKey];
	[_preferences registerBool:&_enablesmsTails default:YES forKey:kTNTTailsSMSKey];
	[_preferences registerBool:&_smsEnable default:YES forKey:kTNTSMSEnable];
	[_preferences registerBool:&_imessageEnable default:YES forKey:kTNTiMessageEnable];
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
-(NSDictionary *)getPrefDictionary:(NSString *)section
{
	UIColor *tSC, *bSC, *tRC, *bRC;
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	tSC = [self colorForPreference:[NSString stringWithFormat:@"%@-%@-%@",section,kTNTSender,kTNTTopColor]];
	bSC = [self colorForPreference:[NSString stringWithFormat:@"%@-%@-%@",section,kTNTSender,kTNTBotColor]];
	tRC = [self colorForPreference:[NSString stringWithFormat:@"%@-%@-%@",section,kTNTReceived,kTNTTopColor]];
	bRC = [self colorForPreference:[NSString stringWithFormat:@"%@-%@-%@",section,kTNTReceived,kTNTBotColor]];
	[dictionary setObject:tSC forKey:[NSString stringWithFormat:@"%@-%@", kTNTSender, kTNTTopColor]];
	[dictionary setObject:bSC forKey:[NSString stringWithFormat:@"%@-%@", kTNTSender, kTNTBotColor]];
	[dictionary setObject:tRC forKey:[NSString stringWithFormat:@"%@-%@", kTNTReceived, kTNTTopColor]];
	[dictionary setObject:bRC forKey:[NSString stringWithFormat:@"%@-%@", kTNTReceived, kTNTBotColor]];
	return dictionary;
}


#pragma mark - Memory management

- (void)dealloc {
	[_preferences release];

	[super dealloc];
}

@end