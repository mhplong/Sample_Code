//
//  BlockSprite.m
//  15 Puzzle
//
//  Created by Mark Long on 6/4/14.
//
//

#import "BlockSprite.h"
#import "GameLogic.h"

@implementation BlockSprite

-(id)initWithSize:(CGSize)size withNumber:(int)number{
    if (self = [super initWithColor:[SKColor redColor] size:size]) {
        
        self.texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"Tile%02i", number]];
        self.anchorPoint = CGPointMake(0.0, 0.0);
        self.tileNumber = [NSNumber numberWithInt:number];
        self.name = [NSString stringWithFormat:@"%02i", number];
        
        NSMutableDictionary *dict = [[GameLogic sharedLogic] puzzleMemory];
        [dict setObject:[NSNumber numberWithInt:number]
                 forKey:[NSNumber numberWithInt:number]];
    }
    
    return self;
}

-(BOOL)makeMove {
    BOOL returnVal;
    
    CGVector moveVector;
    
    enum MoveDirection direction = [[GameLogic sharedLogic] checkForBlankTile:self.tileNumber.intValue];
    switch (direction) {
        case MoveUp:
            moveVector = CGVectorMake(0, 60);
            break;
        case MoveDown:
            moveVector = CGVectorMake(0, -60);
            break;
        case MoveLeft:
            moveVector = CGVectorMake(-60, 0);
            break;
        case MoveRight:
            moveVector = CGVectorMake(60, 0);
            break;
        default:
            break;
    }
    
    returnVal = direction != NoMove;
    if (returnVal) {
        [self runAction:[SKAction moveBy:moveVector duration:0.25]];
        [[GameLogic sharedLogic] updateGameMemory:self.tileNumber];
    }
    return returnVal;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self makeMove];
}

@end
