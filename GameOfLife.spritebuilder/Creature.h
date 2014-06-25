//
//  Creature.h
//  GameOfLife
//
//  Created by Tushig Ochirhkuyag on 6/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Creature : CCSprite

//stores the current state of the creature
@property (nonatomic, assign) BOOL isAlive; //auto creates iVar _isAlive

//stores the amount of living neighbors
@property (nonatomic, assign) NSInteger livingNeighbors; //auto creates iVar _livingNeighbors


-(id)initCreature;

@end
