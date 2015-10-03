//
//  pokesaverView.h
//  pokesaver
//
//  Created by Flavien Raynaud on 01/10/15.
//  Copyright © 2015 Flavien Raynaud. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>
#import "PKSBackground.h"
#import "PKSCharacter.h"
#import "PKSMap.h"

@interface pokesaverView : ScreenSaverView

@property (nonatomic) PKSMap* map;

@end
