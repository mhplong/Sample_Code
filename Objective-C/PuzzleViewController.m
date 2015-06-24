//
//  _5_PuzzleViewController.m
//  15 Puzzle
//
//  Created by Mark Long on 6/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PuzzleViewController.h"
#import "GameScene.h"

@implementation PuzzleViewController


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (floor(NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_6_1)){
        [self.view addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Tile01.png"]]];
    } else {
        SKView *skView = [[SKView alloc] initWithFrame:self.view.frame];
        self.view = skView;
        self.GameView = skView;
        
        GameScene *scene = [[GameScene alloc] initWithSize:_GameView.frame.size];
        //_GameView.showsNodeCount = true;
        //_GameView.showsPhysics = true;
        //_GameView.showsFPS = true;
        [_GameView presentScene:scene];
    }
}

- (BOOL)isRunningIOS7 {
    return !floor(NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_6_1);
}

#pragma  mark Delegate methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        return NO;
    } else {
        return YES;
    }
}

@end
