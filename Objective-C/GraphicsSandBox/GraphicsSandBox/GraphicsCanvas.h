//
//  GraphicsCanvas.h
//  GraphicsSandBox
//
//  Created by Mark Long on 1/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NUMBER_SQUARE_FACTOR 16

@interface GraphicsCanvas : UIView
{
    UIBezierPath *oddBackgroundBoxes;
    UIBezierPath *evenBackgroundBoxes;
    UIImage *backgroundImage;
    CGPoint shipPosition;
}

-(void)renderShip:(CGContextRef)currContext inRect:(CGRect)rect;

@end
