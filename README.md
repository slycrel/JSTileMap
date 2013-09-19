JSTileMap is a TMX Map viewer for SpriteKit
=========

Include 
	JSTileMap.m
	JSTileMap.h
In your project.

Loading a map
=========

	JSTileMap* tiledMap = [JSTileMap mapNamed:@"mapFileName.tmx"];
	if (tiledMap)
		[mySKNode addChild:tiledMap];

Browse the properties in JSTileMap and TMXLayer for most of what you'll use 
frequently.  Limited accessor methods are included for convenience.

The repository also contains an example project that will give you a 
general idea of how layers, tilesets, and objects work.

Note that Isometric maps are currently considered to be in beta as 
there are bugs with tile object positioning in isometric maps.