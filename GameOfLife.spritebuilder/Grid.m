//
//  Grid.m
//  GameOfLife
//
//  Created by Tushig Ochirhkuyag on 6/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"

//these are variables that cannot be changed
static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid {

    NSMutableArray *_gridArray; //2D array that will store all the creatures in our grid
    float _cellWidth;
    float _cellHeight;
}
- (void)onEnter {
        [super onEnter];
        
        [self setupGrid];
        
        // accept touches on the grid
        self.userInteractionEnabled = YES;
}

-(void)setupGrid {
        //divide the grid's size by the number of columns/rows to figure out the right height and width of each cell
        _cellWidth = self.contentSize.width / GRID_COLUMNS;
        _cellHeight = self.contentSize.height  / GRID_ROWS;
        
        //used for the position coordinates of the creature object
        float x = 0;
        float y = 0;
        
        //initialize the array as a blank NSMutableArray
        _gridArray = [NSMutableArray array];
        
        //initialize creatures
        for(int i=0; i < GRID_ROWS; i++) {
            _gridArray[i] = [NSMutableArray array];
            x=0;
            for(int j=0; j < GRID_COLUMNS; j++) {
                Creature *creature =[[Creature alloc] initCreature];
                creature.anchorPoint = ccp(0,0);
                creature.position = ccp(x, y);
                [self addChild:creature]; //creature is a child of grid node
                
                //this is shorthand to access an array inside an array
                _gridArray[i][j] = creature;
                
                //make creatures visible to test this method,
                creature.isAlive = YES;
                
                x+=_cellWidth;//update the x-coord for the next creature
            }
                y+=_cellHeight;
        }
    }




@end
