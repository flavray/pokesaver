//
//  pokesaverView.h
//  pokesaver
//
//  Created by Flavien Raynaud on 01/10/15.
//  Copyright © 2015 Flavien Raynaud. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>
#import "PKSCharacter.h"

@interface pokesaverView : ScreenSaverView

@property (nonatomic) NSImage* background;
@property (nonatomic) PKSCharacter* mainCharacter;
@property (nonatomic) int loop;

@end
