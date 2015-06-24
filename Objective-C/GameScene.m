//
//  GameSceneController.m
//  15 Puzzle
//
//  Created by Mark Long on 6/4/14.
//
//

#import "GameScene.h"

@implementation GameScene

-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        int padding = 10;
        CGPoint tile1bottomLeft = CGPointMake(43, 450);
        
        CGRect puzzleRect = CGRectMake(tile1bottomLeft.x, tile1bottomLeft.y - 180, 230, 230);
        [[GameLogic sharedLogic] setPuzzleFrame:puzzleRect];
        
        for (int row = 0; row < 4; row++) {
            for(int col = 0; col < 4; col++) {
                int number = (row+1)+4*col;

                NSMutableDictionary *dict = [[GameLogic sharedLogic] puzzleMemory];
                if (col == 3 && row == 3) {
                    [dict setObject:[NSNumber numberWithInt:0]
                             forKey:[NSNumber numberWithInt:number]];
                    continue;
                }
                
                BlockSprite *block = [[BlockSprite alloc] initWithSize:CGSizeMake(50, 50)
                                                            withNumber:number];
                
                block.position = CGPointMake((block.size.width+padding)*row + tile1bottomLeft.x,
                                            -(block.size.height+padding)*col + tile1bottomLeft.y);
                [self addChild:block];
            }
        }
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKNode *touchedNode = [self nodeAtPoint:location];
        if (touchedNode != nil && [touchedNode isMemberOfClass:[BlockSprite class]])
        {
            [touchedNode touchesBegan:touches withEvent:event];
        }
        return;
    }
}

@end
