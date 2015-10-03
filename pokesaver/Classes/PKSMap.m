//
//  PKSMap.m
//  pokesaver
//
//  Created by Flavien Raynaud on 03/10/15.
//  Copyright © 2015 Flavien Raynaud. All rights reserved.
//

#import "PKSMap.h"

@interface PKSMap ()

@property (nonatomic) int line, column;  // position of the character on the map (matrix)
@property (nonatomic) NSUInteger direction;  // current direction of the character
@property (nonatomic) int tileWidth, tileHeight;

@property (nonatomic) NSRect backgroundRect;

@property (nonatomic) CGFloat xRatio, yRatio;

@end

@implementation PKSMap

#pragma mark - Constructor

- (instancetype)initWithBackground:(PKSBackground*)background maincharacter:(PKSCharacter*)mainCharacter size:(NSSize)size
{
    self = [super init];

    if (self) {
        _background = background;
        _mainCharacter = mainCharacter;

        NSPoint initialPosition = [self.background randomValidPosition];
        _line = initialPosition.y;
        _column = initialPosition.x;

        NSMutableArray* initialDirections = [self.background directionsWithLine:self.line column:self.column];
        _direction = [initialDirections[arc4random_uniform((u_int32_t)[initialDirections count])] unsignedIntegerValue];

        _tileWidth = _background.bounds.size.width / _background.columns;
        _tileHeight = _background.bounds.size.height / _background.lines;

        _mainCharacter.position = NSMakePoint(_background.bounds.origin.x + _column * _tileWidth, _background.bounds.origin.y + (_line-1) * _tileHeight);

        _backgroundRect.origin = NSZeroPoint;
        _backgroundRect.size = size;

        // adapt to screen size
        _xRatio = size.width / [self.background.image size].width;
        _yRatio = size.height / [self.background.image size].height;
    }

    return self;
}

#pragma mark - Helper methods

- (void)nextFrame
{
    int dx = 0;
    int dy = 0;

    [self.mainCharacter nextFrame];

    if ([self.mainCharacter currentFrame] == 0) {
        [self updatePosition];
        self.direction = [self getNewDirection];
        self.mainCharacter.currentAnimation = [self updateAnimation];
    }

    switch (self.direction) {
        case UP:
            dy = [self.mainCharacter dyFrame:self.tileHeight];
            break;
        case DOWN:
            dy = -[self.mainCharacter dyFrame:self.tileHeight];
            break;
        case LEFT:
            dx = -[self.mainCharacter dxFrame:self.tileWidth];
            break;
        case RIGHT:
            dx = [self.mainCharacter dxFrame:self.tileWidth];
            break;
    }

    self.mainCharacter.position = NSMakePoint(self.mainCharacter.position.x + dx, self.mainCharacter.position.y + dy);
}

- (void)updatePosition
{
    switch (self.direction) {
        case UP:
            self.line++;
            break;
        case DOWN:
            self.line--;
            break;
        case LEFT:
            self.column--;
            break;
        case RIGHT:
            self.column++;
            break;
    }

    NSPoint position = self.background.bounds.origin;
    position.x += self.column * self.tileWidth;
    position.y += self.line * self.tileHeight;
    self.mainCharacter.position = position;
}

- (NSUInteger)getNewDirection
{
    NSMutableArray* availableDirections = [self.background directionsWithLine:self.line column:self.column];

    if ([availableDirections count] == 1)
        return [availableDirections[0] unsignedIntegerValue];

    // straight line, keep going
    if (([availableDirections indexOfObject:@(self.direction)] != NSNotFound) && ([availableDirections count] <= 2))
        return self.direction;

    // do not go backwards
    [availableDirections removeObject:@([PKSBackground oppositeDirection:self.direction])];

    // choose a direction at random
    return [availableDirections[arc4random_uniform((u_int32_t)availableDirections.count)] integerValue];
}

- (int)updateAnimation
{
    switch (self.direction) {
        case UP:
            return 0;
        case DOWN:
            return 3;
        case LEFT:
            return 2;
        case RIGHT:
            return 1;
    }

    // unknown direction?
    return -1;
}

# pragma mark - Drawing methods

- (void)draw
{
    NSRect characterBounds;
    characterBounds.origin = self.mainCharacter.position;
    characterBounds.origin.x *= self.xRatio;  // adapt to screen size
    characterBounds.origin.y *= self.yRatio;  // adapt to screen size

    characterBounds.size = NSMakeSize(self.tileWidth * self.xRatio, self.tileHeight * self.yRatio);

    [self.background.image drawInRect:self.backgroundRect];
    [self.mainCharacter.sprite drawInRect:characterBounds fromRect:self.mainCharacter.rect operation:NSCompositeSourceOver fraction:1.f];
}

@end
