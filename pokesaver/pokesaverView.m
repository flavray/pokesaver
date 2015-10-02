//
//  pokesaverView.m
//  pokesaver
//
//  Created by Flavien Raynaud on 01/10/15.
//  Copyright © 2015 Flavien Raynaud. All rights reserved.
//

#import "pokesaverView.h"

@implementation pokesaverView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];

    if (self) {
        [self setAnimationTimeInterval:1.f/30.f];
    }

    return self;
}

- (void)startAnimation
{
    [super startAnimation];

    NSBundle *saverBundle = [NSBundle bundleForClass:[self class]];

    self.background = [[NSImage alloc] initWithContentsOfFile:[saverBundle pathForResource:@"pallet-town" ofType:@"png"]];

    // main character, sprite image has 4 animations & 3 frames per animation
    self.mainCharacter = [[PKSCharacter alloc] initWithSprite:[[NSImage alloc] initWithContentsOfFile:[saverBundle pathForResource:@"red-sprite" ofType:@"png"]]
                                                   animations:4
                                                       frames:3];

    self.loop = 0;
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];

    NSRect bounds = [self bounds];
    [self.background setSize:bounds.size];

    NSRect imageRect;
    imageRect.origin = NSZeroPoint;
    imageRect.size = [self.background size];

    [self.background drawInRect:bounds];
}

- (void)animateOneFrame
{
    self.loop++;

    [self setNeedsDisplay: YES];
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
