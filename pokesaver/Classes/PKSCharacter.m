//
//  PKSCharacter.m
//  pokesaver
//
//  Created by Flavien Raynaud on 02/10/15.
//  Copyright © 2015 Flavien Raynaud. All rights reserved.
//

#import "PKSCharacter.h"

@interface PKSCharacter ()

@property (nonatomic) NSSize frameSize;

@end

@implementation PKSCharacter

#pragma mark - Constructors

- (instancetype)initWithSprite:(NSImage*)sprite animations:(int)animations frames:(int)frames
{
    self = [super init];

    if (self) {
        _position = NSMakePoint(0.f, 0.f);

        _sprite = sprite;
        _animations = animations;
        _frames = frames;

        NSSize spriteSize = [self.sprite size];

        _frameSize.width = spriteSize.width / _frames;
        _frameSize.height = spriteSize.height / _animations;

        _currentAnimation = _currentFrame = 0;
    }

    return self;
}

#pragma mark - Animation methods

- (void)setCurrentAnimation:(int)currentAnimation
{
    if ((currentAnimation >= 0) && (currentAnimation < self.animations))
        _currentAnimation = currentAnimation;
}

- (void)nextFrame
{
    _currentFrame = (self.currentFrame + 1) % self.frames;
}

#pragma mark - Position methods

- (NSRect)rect
{
    NSRect result;

    result.origin.x = self.currentFrame * self.frameSize.width;
    result.origin.y = self.currentAnimation * self.frameSize.height;
    result.size = self.frameSize;

    return result;
}

- (NSRect)bounds
{
    NSRect result;

    result.origin = self.position;
    result.size = NSMakeSize(15, 15);

    return result;
}

- (int)dxFrame:(int)totalWidth
{
    return totalWidth / self.frames;
}


- (int)dyFrame:(int)totalHeight
{
    return totalHeight / self.frames;
}

@end
