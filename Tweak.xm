#import "TNTPreferencesManager.h"

@interface NSConcreteAttributedString : NSAttributedString
- (id)attributesAtIndex:(unsigned int)arg1 effectiveRange:(NSRange *)arg2;
- (id)string;
@end

%hook CKBalloonView
-(BOOL)hasTail
{
	if([TNTPreferencesManager sharedInstance].enabled)
		return [TNTPreferencesManager sharedInstance].enableTails;
	else
		return %orig;
}
-(unsigned int) balloonCorners
{
	return %orig;
}

%end

/*
%hook CKTranscriptCell

-(void)configureForChatItem:(id)arg1
{
	%log;
	%orig;
}

%end
*/


%hook CKTextBalloonView

-(NSConcreteAttributedString *)attributedText
{
	NSConcreteAttributedString *test = %orig;
	//NSMutableArray *array = [test attributesAtIndex:0 effectiveRange:nil];
	//HBLogDebug(@"Test: %@", );
	NSMutableDictionary *m = [[test attributesAtIndex:0 effectiveRange:nil] mutableCopy];
	m[@"NSColor"] = [UIColor whiteColor];

	NSConcreteAttributedString *test2 = [[NSConcreteAttributedString alloc] initWithString:[test string] attributes:m];
	return test2;
}

%end

%hook CKColoredBalloonView

-(BOOL) color {
	if([TNTPreferencesManager sharedInstance].enabled)
		return true;
	else
		return %orig;
}

%end

%hook CKGradientView

-(id)colors
{
	if([TNTPreferencesManager sharedInstance].enabled){
		NSMutableArray *arrays = [NSMutableArray array];
		[arrays addObject:[[TNTPreferencesManager sharedInstance] colorForPreference:@"BotColor"]];
		[arrays addObject:[[TNTPreferencesManager sharedInstance] colorForPreference:@"TopColor"]];
		return arrays;
	}
	else
		return %orig;
}

%end