//
//  Creature.m
//  GameOfLife
//
//  Created by Tushig Ochirhkuyag on 6/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature

-(instancetype)initCreature
{
    //since we made Creature inherit from CCSprite, 'super' refers to CCSprite
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];
    
    if(self) {
        self.isAlive = NO; //initializes the creatures to be not Alive
    }
    return self;
}
//this method is auto called when you access its corresponding property isAlive
-(void)setIsAlive:(BOOL)newState// private void setIsAlive(BOOL newState)
{
    _isAlive = newState;
    
    //'visible is a property of any class that inherits from CCNode. CCSprite is a subclass of CCNode
    self.visible = _isAlive;
}

@end
