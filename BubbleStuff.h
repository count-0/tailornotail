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