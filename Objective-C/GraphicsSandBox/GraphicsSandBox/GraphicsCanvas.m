//
//  GraphicsCanvas.m
//  GraphicsSandBox
//
//  Created by Mark Long on 1/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphicsCanvas.h"

@interface GraphicsCanvas ()
{
    float angle;
    UIImage *shipImage;
}

- (void)makeBackground;
- (void)update;

@end

@implementation GraphicsCanvas

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib {
    oddBackgroundBoxes = [UIBezierPath bezierPath];
    evenBackgroundBoxes = [UIBezierPath bezierPath];
    
    [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(update) userInfo:NULL repeats:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resetBackgroundImage)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

-(void)update {
    angle += 0.1;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();

    BOOL landscapeMode = UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]);
    double squareSize = [self bounds].size.width / NUMBER_SQUARE_FACTOR;
    if (landscapeMode)  //landscape mode
        squareSize = [self bounds].size.height / NUMBER_SQUARE_FACTOR;
    
    [[UIColor grayColor] set];
    CGContextFillRect(currentContext, rect);
        
    CGRect imageRect = CGRectMake(0, 0, (NUMBER_SQUARE_FACTOR + 10)*squareSize, (NUMBER_SQUARE_FACTOR + 10)*squareSize);
    if (landscapeMode)
        imageRect = CGRectMake(0, 0,
                               (NUMBER_SQUARE_FACTOR+10)*squareSize, (NUMBER_SQUARE_FACTOR + 10)*squareSize);
    
    if (backgroundImage == nil) {
        [self makeBackground];
        
        [[UIColor blackColor] setFill];
        [oddBackgroundBoxes fill];
        
        [[UIColor whiteColor] setFill];
        [evenBackgroundBoxes fill];
        
        CGContextRef cntx = UIGraphicsGetCurrentContext();
        CGImageRef imageRef = CGBitmapContextCreateImage(cntx);
        backgroundImage = [UIImage imageWithCGImage:imageRef];
    } else {
        [backgroundImage drawAtPoint:CGPointMake(0, 0)];
    }
    
    [self renderShip:currentContext inRect:imageRect];
}

- (void)resetBackgroundImage{
    backgroundImage = nil;
}

- (void)makeBackground {

    [evenBackgroundBoxes removeAllPoints];
    [oddBackgroundBoxes removeAllPoints];
    BOOL landscapeMode = UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]); //landscape mode
    double squareSize = [self bounds].size.width / NUMBER_SQUARE_FACTOR;
    if (landscapeMode)  //landscape mode
        squareSize = [self bounds].size.height / NUMBER_SQUARE_FACTOR;
    
    for (int i = 0; i < NUMBER_SQUARE_FACTOR + 10; i++) {
        for (int j = 0; j < NUMBER_SQUARE_FACTOR + 10; j++) {
            CGRect currRect = CGRectMake(i * squareSize, j * squareSize, squareSize, squareSize);

            if ((i + j + 1) % 2) {
                [evenBackgroundBoxes appendPath:[UIBezierPath bezierPathWithRect:currRect]];
            }
            else {
                [oddBackgroundBoxes appendPath:[UIBezierPath bezierPathWithRect:currRect]];
            }
        }
    }
        
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *tap = [touches anyObject];
    if (tap)
    {
        shipPosition = [tap locationInView:self];
        [self setNeedsDisplay];
    }

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *tap = [touches anyObject];
    if (tap)
    {
        shipPosition = [tap locationInView:self];
        [self setNeedsDisplay];
        
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *tap = [touches anyObject];
    if (tap)
    {
        shipPosition = [tap locationInView:self];
        [self setNeedsDisplay];
        
    }
}

-(void)renderShip:(CGContextRef)currContext inRect:(CGRect)rect {
    double squareSize = [self bounds].size.width / NUMBER_SQUARE_FACTOR;
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]))  //landscape mode
        squareSize = [self bounds].size.height / NUMBER_SQUARE_FACTOR;
    
    UIBezierPath *shipPath = [UIBezierPath bezierPath];       
    [shipPath appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(-(squareSize/2), -(squareSize/2), squareSize, squareSize)]];
    
    [shipPath applyTransform:CGAffineTransformMakeRotation(angle)];
    
    if (shipPosition.x < 5 || shipPosition.y < 0)
        [shipPath applyTransform:CGAffineTransformMakeTranslation(shipPosition.x + squareSize/2, shipPosition.y + squareSize/2)];
    else 
        [shipPath applyTransform:CGAffineTransformMakeTranslation(shipPosition.x, shipPosition.y)];
    
    [[UIColor redColor] setStroke];
    [[UIColor blueColor] setFill];
    
    [shipPath fill];
    [shipPath stroke];
}

@end
