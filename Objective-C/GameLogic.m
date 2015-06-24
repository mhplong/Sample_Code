//
//  GameLogic.m
//  15 Puzzle
//
//  Created by Mark Long on 6/8/14.
//
//

#import "GameLogic.h"

@implementation GameLogic

@synthesize puzzleFrame;
@synthesize puzzleMemory;

+(GameLogic *)sharedLogic {
    static GameLogic *sharedInstance = nil;
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

-(id)init {
    if (self = [super init]) {
        puzzleMemory = [NSMutableDictionary dictionary];
    }
    return self;
}

-(enum MoveDirection)checkForBlankTile:(int)tileNumber {
    NSNumber *blankTile = [self findTile:0];
    NSNumber *curTile = [self findTile:tileNumber];
    
    NSNumber *leftTile = [NSNumber numberWithInt:curTile.intValue - 1];
    NSNumber *rightTile = [NSNumber numberWithInt:curTile.intValue + 1];
    NSNumber *upTile = [NSNumber numberWithInt:curTile.intValue - 4];
    NSNumber *downTile = [NSNumber numberWithInt:curTile.intValue + 4];
    
    if ([leftTile isEqualToNumber:blankTile]) {
        return MoveLeft;
    } else if ([rightTile isEqualToNumber:blankTile]) {
        return MoveRight;
    } else if ([upTile isEqualToNumber:blankTile]) {
        return MoveUp;
    } else if ([downTile isEqualToNumber:blankTile]) {
        return MoveDown;
    }
    return NoMove;
}

-(void)updateGameMemory:(NSNumber *)number {
    NSNumber *blankTile = [self findTile:0];
    NSNumber *curTile = [self findTile:[number intValue]];
    
    [self.puzzleMemory setObject:number forKey:blankTile];
    [self.puzzleMemory setObject:[NSNumber numberWithInt:0] forKey:curTile];
    
    blankTile = [self findTile:0];
    curTile = [self findTile:[number intValue]];
}

-(NSNumber *)findTile:(int)number {
    for (NSNumber *key in self.puzzleMemory) {
        if ([(NSNumber *)[self.puzzleMemory objectForKey:key] intValue] == number)
            return key;
    }
    return [NSNumber numberWithInt:-1];
}


@end
