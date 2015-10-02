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
@property (nonatomic) int currentAnimation, currentFrame;

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

- (void)setCurrentAnimation:(int)currentAnimation
{
    if ((currentAnimation > 0) && (currentAnimation < self.animations))
        _currentAnimation = currentAnimation;
}

- (void)nextFrame
{
    self.currentFrame = (self.currentFrame + 1) % self.frames;
}

- (NSRect)rect
{
    NSRect result;

    result.origin.x = self.currentFrame * self.frameSize.width;
    result.origin.y = self.currentAnimation * self.frameSize.height;
    result.size = self.frameSize;

    return result;
}

@end
