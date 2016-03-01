#import "TNTPreferencesManager.h"
#import "Background.h"

@import Photos;
CPDistributedMessagingCenter *messageCenter;

%hook CKTranscriptCollectionView

-(id) initWithFrame:(CGRect) arg1 collectionViewLayout:(id) arg2
{
	//
	self = %orig;
	TNTPreferencesManager *pref = [TNTPreferencesManager sharedInstance];
	if (pref.enabled)
	{
		
		if(pref.enableWB)
		{
			NSMutableDictionary *settings = [NSMutableDictionary dictionary];
			settings[@"variant"] = (id)pref.variant;
			NSDictionary *userInfo = [messageCenter sendMessageAndReceiveReplyName:@"background" userInfo:settings];
			UIImage *img = [UIImage imageWithData:userInfo[@"background"]];
			UIImageView *test = [[UIImageView alloc] initWithImage:img];
    		test.contentMode = UIViewContentModeScaleAspectFill;
    		[self setBackgroundView:test];
		}
		else if (pref.enableLB)
		{
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
                                           	});}];
		}
		
	}
	return self;
}



-(void)setBackgroundColor:(UIColor *)color
{
	if([TNTPreferencesManager sharedInstance].enableCB){	
		color = [[TNTPreferencesManager sharedInstance] colorForPreference:@"background-Color" fallback:@"#FFFFFF"];
	}
	%orig;
}



%end

%ctor {
    messageCenter = [%c(CPDistributedMessagingCenter) centerNamed:@"com.dopeteam.tnt.server"];
}