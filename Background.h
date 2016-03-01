#import <rocketbootstrap/rocketbootstrap.h>

@interface CPDistributedMessagingCenter : NSObject
+(CPDistributedMessagingCenter*)centerNamed:(NSString*)serverName;
-(NSDictionary*)sendMessageAndReceiveReplyName:(NSString*)name userInfo:(NSDictionary*)info;
-(void)runServerOnCurrentThread;
@end
