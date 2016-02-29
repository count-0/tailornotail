#import "TNTPreferencesManager.h"
@interface IMItem : NSObject

@property (nonatomic) long long type;
@property (nonatomic) long long messageID;
@property (nonatomic, retain) NSString *unformattedID;
@property (nonatomic, retain) NSString *service;

@property (nonatomic, retain) NSString *account;
@property (nonatomic, retain) NSString *accountID;
@property (nonatomic, retain) NSString *handle;
@property (nonatomic, retain) NSString *countryCode;
@property (nonatomic, retain) NSString *guid;

@property (nonatomic, retain) NSString *roomName;
@property (nonatomic, retain) NSString *sender;
@property (nonatomic, retain) NSDictionary *senderInfo;

@property (nonatomic, readonly) BOOL isFromMe;
@property (nonatomic, retain) id context;
@property (nonatomic, retain) NSDate *time;

@end

@interface NSConcreteAttributedString : NSAttributedString
- (id)attributesAtIndex:(unsigned int)arg1 effectiveRange:(NSRange *)arg2;
- (id)string;
@end

@interface IMChatItem : NSObject
-(IMItem *)_item;
@end

@interface IMTranscriptChatItem : IMChatItem
@end

@interface CKTranscriptCollectionView : UIView
-(void)setBackgroundView:(UIView *)arg1;
@end

@interface CKChatItem : NSObject
@property (nonatomic, retain) IMTranscriptChatItem *IMChatItem;
@end

@import Photos;

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

%hook CKTranscriptCollectionView

-(id) initWithFrame:(CGRect) arg1 collectionViewLayout:(id) arg2
{
	//self.backgroundColor = [UIColor blueColor];
	self = %orig;
	PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
	fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
	PHFetchResult *fetchResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:fetchOptions];
	PHAsset *lastAsset = [fetchResult lastObject];
	[[PHImageManager defaultManager] requestImageForAsset:lastAsset
                                          targetSize:PHImageManagerMaximumSize
                                         contentMode:PHImageContentModeDefault
                                             options:0
                                       resultHandler:^(UIImage *result, NSDictionary *info) {

                                           dispatch_async(dispatch_get_main_queue(), ^{
                                            UIImageView *test = [[UIImageView alloc] initWithImage:result];
                                            test.contentMode = UIViewContentModeScaleAspectFill;
              								[self setBackgroundView:test];


                                           });
                                       }];
	return self;
}

/*
-(void)setBackgroundColor:(UIColor *)color
{
	color = [UIColor redColor];
	%orig;
}
*/


%end