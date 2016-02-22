#import <Cephei/HBPreferences.h>

@interface TNTPreferencesManager : NSObject

@property (nonatomic, readonly) BOOL enabled;
@property (nonatomic, readonly) BOOL enableTails;
@property (nonatomic, readonly) BOOL imessageEnable;
@property (nonatomic, readonly) BOOL smsEnable;
@property (nonatomic, readonly) BOOL enablesmsTails;
@property (nonatomic, readonly) BOOL enableiMessageTails;

+ (instancetype)sharedInstance;
- (UIColor *)colorForPreference:(NSString *)string;
- (NSDictionary *)getPrefDictionary:(NSString *)section;
@end
