//
//  Deck.h
//  AssigmentOne
//
//  Created by Christian Cocking on 10/28/13.
//  Copyright (c) 2013 Christian Cocking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void) addCard:(Card *)card atTOP:(BOOL) atTop;
- (void)addCard:(Card *)card;
- (Card *) drawRandomCard;


@end
