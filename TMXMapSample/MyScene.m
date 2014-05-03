//
//  MyScene.m
//  TMXMapSample
//
//  Created by Jeremy on 6/11/13.
//  Copyright (c) 2013 Jeremy. All rights reserved.
//

#import "MyScene.h"
#import "JSTileMap.h"

@interface MyScene ()
@property (nonatomic,weak) SKLabelNode* mapNameLabel;
@end

@implementation MyScene

-(id)initWithSize:(CGSize)size
{
	if (self = [super initWithSize:size])
	{
		// put anchor point in center of scene
		self.anchorPoint = CGPointMake(0.5,0.5);

		// create a world Node to allow for easy panning & zooming
		SKNode* worldNode = [[SKNode alloc] init];
		[self addChild:worldNode];
		self.worldNode = worldNode;

		// load initial map
		[self swapToNextMap];

		// instructions
		SKLabelNode* label = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
		label.fontSize = 18;

#if TARGET_OSX
		label.text = @"click to change maps.";
		label.fontColor = [NSColor yellowColor];
#else
		label.text = @"Double-tap to change maps.";
		label.fontColor = [UIColor yellowColor];
#endif
		label.alpha = 0;
		[self addChild:label];
		id seq = [SKAction sequence:@[[SKAction waitForDuration:1.0],
									  [SKAction fadeInWithDuration:1.0],
									  [SKAction waitForDuration:3.0],
									  [SKAction fadeOutWithDuration:1.0],
									  [SKAction runBlock:^{
											[label removeFromParent];
										} queue:dispatch_get_main_queue()]
									  ]];
		[label runAction:seq];
	}
	return self;
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}


#if TARGET_OSX

-(void)mouseDown:(NSEvent *)theEvent {
	/* Called when a mouse click occurs */
    
	[self swapToNextMap];
}

#endif



- (void) loadTileMap:(NSString*)tileMap
{
#ifdef DEBUG
	NSLog(@"loading map named %@", tileMap);
#endif
	
	self.tiledMap = [JSTileMap mapNamed:tileMap];
	if (self.tiledMap)
	{
		// center map on scene's anchor point
		CGRect mapBounds = [self.tiledMap calculateAccumulatedFrame];
		self.tiledMap.position = CGPointMake(-mapBounds.size.width/2.0, -mapBounds.size.height/2.0);
		[self.worldNode addChild:self.tiledMap];
		
		// display name of map for testing
		if(!self.mapNameLabel)
		{
			SKLabelNode* mapLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
			mapLabel.xScale = .5;
			mapLabel.yScale = .5;
			mapLabel.text = tileMap;
			mapLabel.zPosition = -100;
			[self addChild:mapLabel];
			self.mapNameLabel = mapLabel;
		}
		else
			self.mapNameLabel.text = tileMap;
		self.mapNameLabel.position = CGPointMake(0, -self.size.height/2.0 + 30);
		
		// test spade for zOrdering.  Some test maps will make this more useful (as a test) than others.
		SKSpriteNode* spade = [SKSpriteNode spriteNodeWithImageNamed:@"black-spade-md.png"];
		spade.position = CGPointMake(spade.frame.size.width/2.5, spade.frame.size.height/2.5);
		spade.zPosition = self.tiledMap.minZPositioning / 2.0;
#ifdef DEBUG
		NSLog(@"SPADE has zPosition %f", spade.zPosition);
#endif
		[self.tiledMap addChild:spade];
	}
	else
	{
		NSLog(@"Uh Oh....");
	}
}

- (void) swapToNextMap
{
	static NSMutableArray* fileArray = nil;
	static int arrayIndex = 0;
	
	if (!fileArray)
	{
		fileArray = [NSMutableArray array];
		
		NSError* error = nil;
		NSArray* files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[NSBundle mainBundle] resourcePath] error:&error];
		for (NSString* filename in files)
		{
			if ([[[filename pathExtension] lowercaseString] rangeOfString:@"tmx"].location != NSNotFound)
			{
				//				[fileArray addObject:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:filename]];
				[fileArray addObject:filename];
			}
		}
	}
	
	if (fileArray.count)
	{
		if (arrayIndex >= fileArray.count)		// wrap bounds
			arrayIndex = 0;
		
		[self.tiledMap removeFromParent];
		
		// reset the world's position and scale each time we change maps
		self.worldNode.position = CGPointZero;
		self.worldNode.xScale = 1.0;
		self.worldNode.yScale = 1.0;
		
		[self loadTileMap:fileArray[arrayIndex]];
		arrayIndex++;
	}
}

// update map label to always be near bottom of scene view
-(void)didChangeSize:(CGSize)oldSize
{
	self.mapNameLabel.position = CGPointMake(0, -self.size.height/2.0 + 30);
}

@end
