//
//  PKSBackground.h
//  pokesaver
//
//  Created by Flavien Raynaud on 03/10/15.
//  Copyright © 2015 Flavien Raynaud. All rights reserved.
//

#import <Foundation/Foundation.h>

// directions available in directions matrix
#define UP 1
#define DOWN 2
#define LEFT 4
#define RIGHT 8

@interface PKSBackground : NSObject

@property (nonatomic) NSImage* image;
@property (nonatomic) NSRect bounds;  // drawable bounds (e.g: to draw a character)
@property (nonatomic) NSUInteger lines, columns;
@property (nonatomic) NSArray* matrix;  // directions matrix

- (instancetype)initWithImage:(NSImage*)image bounds:(NSRect)bounds matrix:(NSArray*)matrix;

- (NSMutableArray*)directionsWithLine:(int)line column:(int)column;  // directions available from a position

- (NSPoint)randomValidPosition;

+ (NSUInteger)oppositeDirection:(NSUInteger)direction;

@end
