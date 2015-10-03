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

    // Pallet town directions - Linear combination of {UP,DOWN,LEFT,RIGHT}
    NSArray* matrix = @[
                        @[@0, @0, @0, @0, @0, @0, @0, @0, @9, @12, @12, @12, @12, @12, @12, @12, @5, @0],
                        @[@0, @0, @0, @0, @0, @0, @0, @0, @3, @0, @0, @0, @0, @0, @0, @0, @3, @0],
                        @[@0, @0, @0, @0, @0, @0, @0, @0, @3, @0, @0, @0, @0, @0, @0, @0, @3, @0],
                        @[@0, @0, @0, @0, @0, @0, @0, @0, @3, @0, @0, @0, @0, @0, @0, @0, @3, @0],
                        @[@0, @9, @12, @12, @12, @12, @12, @12, @15, @12, @12, @12, @12, @12, @12, @12, @7, @0],
                        @[@0, @3, @0, @0, @0, @0, @0, @0, @3, @0, @0, @0, @0, @0, @0, @0, @3, @0],
                        @[@0, @3, @0, @0, @0, @0, @0, @0, @3, @0, @0, @0, @0, @0, @0, @0, @3, @0],
                        @[@0, @3, @0, @0, @0, @0, @0, @0, @3, @0, @0, @0, @0, @0, @0, @0, @3, @0],
                        @[@0, @3, @0, @0, @0, @0, @0, @0, @3, @0, @0, @0, @0, @0, @0, @0, @3, @0],
                        @[@0, @3, @0, @0, @0, @0, @0, @0, @3, @0, @0, @0, @0, @0, @0, @0, @3, @0],
                        @[@0, @11, @12, @12, @12, @12, @12, @12, @15, @12, @12, @12, @12, @12, @12, @12, @7, @0],
                        @[@0, @3, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @3, @0],
                        @[@0, @3, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @3, @0],
                        @[@0, @3, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @3, @0],
                        @[@0, @10, @12, @12, @12, @12, @12, @12, @14, @12, @12, @12, @12, @12, @12, @12, @6, @0],
                        ];

    NSBundle *saverBundle = [NSBundle bundleForClass:[self class]];

    PKSBackground* background = [[PKSBackground alloc] initWithImage:[[NSImage alloc] initWithContentsOfFile:[saverBundle pathForResource:@"pallet-town" ofType:@"png"]]
                                                    bounds:NSMakeRect(415.f, 60.f, 1090.f, 905.f)  // values from Pallet-town image
                                                    matrix:matrix];

    // main character, sprite image has 4 animations & 3 frames per animation
    PKSCharacter* mainCharacter = [[PKSCharacter alloc] initWithSprite:[[NSImage alloc] initWithContentsOfFile:[saverBundle pathForResource:@"red-sprite" ofType:@"png"]]
                                                   animations:4
                                                       frames:3];

    self.map = [[PKSMap alloc] initWithBackground:background
                                    maincharacter:mainCharacter
                                             size:[self bounds].size];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];

    [self.map draw];
}

- (void)animateOneFrame
{
    [self.map nextFrame];

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
