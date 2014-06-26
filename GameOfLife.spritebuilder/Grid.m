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
    //invoked when the Grid class gets loaded
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
                
                x+=_cellWidth;//update the x-coord for the next creature
            }
                y+=_cellHeight;
        }
    }
//called auto when the user touches the screen because this class inherits CCNode
-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event //NEEEEEEEEEEEEEEEEED TO LOOK OVER AGAIN!
{
    //get the x, y coordinates of the touch
    CGPoint touchLocation = [touch locationInNode:self];
    
    //get the creature at that location
    Creature *creature = [self creatureForTouchPosition:&touchLocation];
    
    //invert it's state. Kill it if it's alive, or revive if it's dead
    creature.isAlive = !creature.isAlive;
}

-(Creature *)creatureForTouchPosition:(CGPoint *)touchPosition
{
    //get the row and column that was touched
    int column = touchPosition->x / _cellWidth;
    int row = touchPosition->y / _cellHeight;
    return _gridArray[row][column];
}
-(void)evolveStep
{
    [self countNeighbors]; //update each creature's neighbor count
    [self updateCreatures];//update each creature's state
    _generation++;//update generation
}
-(void)countNeighbors
{
    for(int i=0; i < [_gridArray count]; i++) //iterates through the rows
    {
        for( int j=0; j< [_gridArray[i] count]; j++) //iterates through the columns for a given row
        {
            Creature *currentCreature = _gridArray[i][j]; //obtains the creature in the current cell
            currentCreature.livingNeighbors = 0;
            
            for(int x = (i-1); x <=(i+1); x++)
            {
                for(int y = (j-1); y <= (j+1); y++)
                {
                    if([self isIndexValid:x andY:y] || ((x == i) && (y == j)))
                    {
                        Creature *neighborCreature = _gridArray[x][y];
                        if(neighborCreature.isAlive)
                        {
                            currentCreature.livingNeighbors+=1;
                        }
                    }
                    
                    
                }
            }
        }
    }
}
-(BOOL)isIndexValid:(int)x andY:(int)y
{
    BOOL isIndexValid = YES;
    if(x < GRID_COLUMNS || x > GRID_COLUMNS || y < GRID_ROWS || y > GRID_ROWS)
    {
        isIndexValid = NO;
    }
    return isIndexValid;
}
-(void)updateCreatures
{
    //int numAlive = 0;
    for(int i = 0; i < [_gridArray count]; i++)
    {
        for(int j=0; j < [_gridArray[i] count]; j++)
        {
            Creature *currentCreature = _gridArray[i][j];
            if((currentCreature.livingNeighbors <= 1) || (currentCreature.livingNeighbors >=4)) //the creature dies
            {
                currentCreature.isAlive = FALSE;
                
            }
            else if((currentCreature.livingNeighbors == 3) && (!currentCreature.isAlive)) // the creature revives
            {
                currentCreature.isAlive = TRUE;
                
            }
           /* if(currentCreature.isAlive)
            {
                numAlive++;
            }*/
        }
    }
   // _totalAlive = numAlive;
}

@end
