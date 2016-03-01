
#import <rocketbootstrap/rocketbootstrap.h>

@interface CPDistributedMessagingCenter : NSObject
+(CPDistributedMessagingCenter*)centerNamed:(NSString*)serverName;
-(void)registerForMessageName:(NSString*)messageName target:(id)target selector:(SEL)selector;
-(void)runServerOnCurrentThread;
@end
@interface SBFWallpaperView : UIView
@end
 
@interface SBFStaticWallpaperView : SBFWallpaperView
{
	UIImage * _image;
}
- (UIImage *)wallpaperImage;
- (UIImage *)_displayedImage;
-(UIImage *) snapshotImage;
@end

@interface SBWallpaperController : NSObject
+ (id)sharedInstance;
- (SBFStaticWallpaperView *)_wallpaperViewForVariant:(NSInteger)variant;
@end


CPDistributedMessagingCenter *messagingCenter;
%hook SBWallpaperController

+ (id)sharedInstance{
	self = %orig;
	static dispatch_once_t once;
    dispatch_once(&once, ^{
		messagingCenter = [%c(CPDistributedMessagingCenter) centerNamed:@"com.dopeteam.tnt.server"];
		[messagingCenter runServerOnCurrentThread];
		[messagingCenter registerForMessageName:@"background" target:self selector:@selector(handleGetWallpaper:withUserInfo:)];
	});
	return self;
}

%new
- (NSDictionary *)handleGetWallpaper:(NSString *)name withUserInfo:(NSDictionary *)userInfo {
	int variant = [userInfo[@"variant"] intValue];
	SBFStaticWallpaperView *wallpaperView = [self _wallpaperViewForVariant:variant];
	//UIImage *img = [wallpaperView->_image copy];
	//UIImage *img = [wallpaperView._displayedImage copy];
	UIImage *img = [wallpaperView.snapshotImage copy];
	NSMutableDictionary* result = [[NSMutableDictionary alloc] init];
	NSData *imageData = UIImagePNGRepresentation ( img );
	[result setObject:imageData forKey:@"background"];
	return result;
}

%end
