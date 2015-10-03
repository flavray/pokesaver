//
//  PKSBackground.m
//  pokesaver
//
//  Created by Flavien Raynaud on 03/10/15.
//  Copyright © 2015 Flavien Raynaud. All rights reserved.
//

#import "PKSBackground.h"

@implementation PKSBackground

#pragma mark - Constructor

- (instancetype)initWithImage:(NSImage*)image bounds:(NSRect)bounds matrix:(NSArray*)matrix
{
    self = [super init];

    if (self) {
        _image = image;
        _bounds = bounds;
        _matrix = matrix;

        _lines = [_matrix count];
        _columns = [[_matrix objectAtIndex:0] count];
    }

    return self;
}

#pragma mark - Direction methods

- (NSMutableArray*)directionsWithLine:(int)line column:(int)column
{
    NSMutableArray* directions = [[NSMutableArray alloc] init];

    for (id direction in @[ @UP, @DOWN, @LEFT, @RIGHT ])
        if ([self.matrix[line][column] unsignedIntegerValue] & [direction unsignedIntegerValue])
            [directions addObject:direction];

    return directions;
}

#pragma mark - Position methods

- (NSPoint)randomValidPosition
{
    NSArray* positions = [self validPositions];

    return [positions[arc4random_uniform((u_int32_t)[positions count])] pointValue];
}

- (NSArray*)validPositions
{
    NSMutableArray* positions = [[NSMutableArray alloc] init];

    for (int i = 0; i < self.lines; i++)
        for (int j = 0; j < self.columns; j++)
            if ([self.matrix[i][j] unsignedIntegerValue] > 0)
                [positions addObject:[NSValue valueWithPoint:NSMakePoint(j, i)]];

    return [NSArray arrayWithArray:positions];
}

+ (NSUInteger)oppositeDirection:(NSUInteger)direction
{
    switch (direction) {
        case UP:
            return DOWN;
        case DOWN:
            return UP;
        case LEFT:
            return RIGHT;
        case RIGHT:
            return LEFT;
    }

    // unknown direction?
    return -1;
}

@end
