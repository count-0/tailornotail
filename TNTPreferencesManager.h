#import <Cephei/HBPreferences.h>

@interface TNTPreferencesManager : NSObject

@property (nonatomic, readonly) BOOL enabled;
@property (nonatomic, readonly) BOOL enableTails;
@property (nonatomic, readonly) NSString *botColor;
@property (nonatomic, readonly) NSString *topColor;

+ (instancetype)sharedInstance;
- (UIColor *)colorForPreference:(NSString *)string;

@end
