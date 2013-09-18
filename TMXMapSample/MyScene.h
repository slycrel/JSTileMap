//
//  MyScene.h
//  TMXMapSample
//

//  Copyright (c) 2013 Jeremy. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class JSTileMap;

@interface MyScene : SKScene

@property (strong, nonatomic) JSTileMap* tiledMap;

/* 
 * Top level node added to MyScene. Everything that needs to pan
 * or zoom should be added to this node
 */
@property (weak, nonatomic) SKNode* worldNode;

- (void) swapToNextMap;

@end
