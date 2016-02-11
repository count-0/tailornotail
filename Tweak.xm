%hook CKBalloonView
-(BOOL)hasTail
{
	return false;
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

%hook CKColoredBalloonView

-(BOOL) color {
	return true;
}

%end

%hook CKGradientView

-(id)colors
{
	NSMutableArray *arrays = [NSMutableArray array];
	[arrays addObject:[UIColor orangeColor]];
	[arrays addObject:[UIColor purpleColor]];
	/*
	id colors = %orig;
	HBLogDebug(@"%@", colors)
	*/
	return arrays;
}

%end