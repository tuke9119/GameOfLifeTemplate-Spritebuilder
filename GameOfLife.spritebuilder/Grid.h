//
//  Grid.h
//  GameOfLife
//
//  Created by Tushig Ochirhkuyag on 6/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Grid : CCSprite

//will be used to store current game stats that will be displayed in the game
@property (nonatomic, assign) int totalAlive;
@property (nonatomic, assign) int generation;
-(void)onEnter;
@end
