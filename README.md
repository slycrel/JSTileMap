JSTileMap is a TMX Map viewer for SpriteKit
=========

Include

	JSTileMap.m
	JSTileMap.h
	LFCGzipUtility.h
	LFCGzipUtility.m

In your project.  You will also need to add libz.dylib to the "linked
frameworks and libraries" section of your project itself.

Loading a map
=========

	...
	
	JSTileMap* tiledMap = [JSTileMap mapNamed:@"mapFileName.tmx"];
	if (tiledMap)
		[mySKNode addChild:tiledMap];
		
	...

Browse the properties in JSTileMap and TMXLayer for most of what you'll use 
frequently.  Limited accessor methods are included for convenience.

Tile atlases are expected to be in the same directory as the TMX file when loaded.  
At the moment this is only trying to load files from the app bundle itself.

The repository also contains an example project, containing the above files, that 
will give you a general idea of how layers, tilesets, and objects work, and a 
few examples of what does (and does not) currently work.

** NOTE:  The TMX map format is in pixels, not points like apple's format.  As 
such, you should -NOT- use the @2x format for your sprite atlas images or the 
map won't load properly.

** NOTE 2:  Isometric maps are currently considered to be in beta as 
there are bugs with tile object positioning in isometric maps.  If you do not 
use tile objects you should be able to use isometric maps.

Mac support works but there are points / pixels issues with the atlas images.  Should
be considered beta.
