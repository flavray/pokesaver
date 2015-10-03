//
//  PKSMap.h
//  pokesaver
//
//  Created by Flavien Raynaud on 03/10/15.
//  Copyright © 2015 Flavien Raynaud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKSBackground.h"
#import "PKSCharacter.h"

@interface PKSMap : NSObject

@property (nonatomic) PKSBackground* background;
@property (nonatomic) PKSCharacter* mainCharacter;

- (instancetype)initWithBackground:(PKSBackground*)background maincharacter:(PKSCharacter*)mainCharacter size:(NSSize)size;

- (void)nextFrame;

- (void)draw;

@end
