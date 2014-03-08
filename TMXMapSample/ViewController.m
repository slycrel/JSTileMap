//
//  ViewController.m
//  TMXMapSample
//
//  Created by Jeremy on 6/11/13.
//  Copyright (c) 2013 Jeremy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) MyScene* scene;

@end


@implementation ViewController

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.showsDrawCount = YES;

    // Create and configure the scene.
    self.scene = [MyScene sceneWithSize:skView.bounds.size];
    self.scene.scaleMode = SKSceneScaleModeResizeFill;
    
    // Present the scene.
    [skView presentScene:self.scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Gestures

- (IBAction)runTapGesture:(id)sender
{
	[self.scene swapToNextMap];
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)sender
{
  CGPoint trans = [sender translationInView:self.view];
  CGPoint curPos = self.scene.worldNode.position;
  self.scene.worldNode.position = CGPointMake(curPos.x + trans.x, curPos.y - trans.y);
  [sender setTranslation:CGPointZero inView:self.view];
}

- (IBAction)handleZoom:(UIPinchGestureRecognizer *)sender
{
  static CGFloat startScale = 1;
  if (sender.state == UIGestureRecognizerStateBegan)
  {
    startScale = self.scene.worldNode.xScale;
  }
  CGFloat newScale = startScale * sender.scale;
  self.scene.worldNode.xScale = MIN(2.0, MAX(newScale, .05));
  self.scene.worldNode.yScale = self.scene.worldNode.xScale;
}


@end
