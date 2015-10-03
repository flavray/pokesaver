//
//  PKSCharacter.h
//  pokesaver
//
//  Created by Flavien Raynaud on 02/10/15.
//  Copyright © 2015 Flavien Raynaud. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AppKit;

@interface PKSCharacter : NSObject

@property (nonatomic) NSImage* sprite;
@property (nonatomic) int animations, frames;  // number of animations & frames per animation in sprite
@property (nonatomic) NSPoint position;
@property (nonatomic, readonly) int currentAnimation, currentFrame;

- (instancetype)initWithSprite:(NSImage*)sprite animations:(int)animations frames:(int)frames;

- (void)setCurrentAnimation:(int)currentAnimation;
- (void)nextFrame;
- (NSRect)rect;
- (NSRect)bounds;

- (int)dxFrame:(int)totalWidth;
- (int)dyFrame:(int)totalHeight;

@end
