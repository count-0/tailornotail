#import "TNTPreferencesManager.h"
#import "BubbleStuff.h"

static bool isSMS;
static bool fromMoi;
static NSString *const kTNTTopColor = @"TopColor";
static NSString *const kTNTBotColor = @"BotColor";
static NSString *const kTNTSender = @"sender";
static NSString *const kTNTReceived = @"received";

%hook CKBalloonView
-(BOOL)hasTail
{
	if([TNTPreferencesManager sharedInstance].enabled){
		if ([TNTPreferencesManager sharedInstance].imessageEnable && !isSMS)
			return [TNTPreferencesManager sharedInstance].enableiMessageTails;
		else if ([TNTPreferencesManager sharedInstance].smsEnable && isSMS)
			return [TNTPreferencesManager sharedInstance].enablesmsTails;
		else
			return [TNTPreferencesManager sharedInstance].enableTails;
	}
	else
		return %orig;
}
-(BOOL) canUseOpaqueMask
{
	return FALSE;
}

-(unsigned int) balloonCorners
{
	return %orig;
}

%end


%hook CKTranscriptCell

-(void)configureForChatItem:(id)arg1
{
	CKChatItem *chatItem = arg1;
	//HBLogDebug(@"Item: %@, %d", [[[chatItem IMChatItem] _item] service], (int)[[[chatItem IMChatItem] _item] isFromMe])
	if([[[[chatItem IMChatItem] _item] service] isEqualToString:@"SMS"])
		isSMS = true;
	else
		isSMS = false;
	fromMoi = [[[chatItem IMChatItem] _item] isFromMe];
	%orig;
}

%end


%hook CKTextBalloonView

-(NSConcreteAttributedString *)attributedText
{
	TNTPreferencesManager *pref = [TNTPreferencesManager sharedInstance];
	if(pref.enabled){
		NSConcreteAttributedString *originalText = %orig;
		NSMutableDictionary *mDict = [[originalText attributesAtIndex:0 effectiveRange:nil] mutableCopy];
		NSDictionary *fontColorDict;
		if(pref.imessageEnable && !isSMS)
			fontColorDict = [pref getFontDictionary:@"imessage"];
		else if(pref.smsEnable && isSMS)
			fontColorDict = [pref getFontDictionary:@"sms"];
		else
			fontColorDict = [pref getFontDictionary:@"default"];
		if(fromMoi)
			mDict[@"NSColor"] = fontColorDict[@"sender"];
		else
			mDict[@"NSColor"] = fontColorDict[@"received"];

		NSConcreteAttributedString *newText = [[NSConcreteAttributedString alloc] initWithString:[originalText string] attributes:mDict];
		return newText;
	}
	else
		return %orig;
	
}

%end

%hook CKColoredBalloonView

-(BOOL) color {
	//HBLogDebug(@"Called Color, %d", (int) isSMS)
	if([TNTPreferencesManager sharedInstance].enabled)
		return true;
	else
		return %orig;
}

%end

%hook CKGradientView

-(id)colors
{
	TNTPreferencesManager *pref = [TNTPreferencesManager sharedInstance];
	//HBLogDebug(@"Called Colors, %d", (int) isSMS)
	NSDictionary *dictionary;
	if(pref.enabled){
		if(pref.imessageEnable && !isSMS)
			dictionary = [pref getColorDictionary:@"imessage"];
		else if(pref.smsEnable && isSMS)
			dictionary = [pref getColorDictionary:@"sms"];
		else
			dictionary = [pref getColorDictionary:@"default"];
		
		NSMutableArray *arrays = [NSMutableArray array];
		if(fromMoi)
		{
			[arrays addObject:dictionary[[NSString stringWithFormat:@"%@-%@", kTNTSender, kTNTBotColor]]];
			[arrays addObject:dictionary[[NSString stringWithFormat:@"%@-%@", kTNTSender, kTNTTopColor]]];
		}
		else
		{
			[arrays addObject:dictionary[[NSString stringWithFormat:@"%@-%@", kTNTReceived, kTNTBotColor]]];
			[arrays addObject:dictionary[[NSString stringWithFormat:@"%@-%@", kTNTReceived, kTNTTopColor]]];
		}
		return arrays;
	}
	else
		return %orig;
}

%end