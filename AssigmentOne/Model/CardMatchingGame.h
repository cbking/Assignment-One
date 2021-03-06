//
//  CardMatchingGame.h
//  AssigmentOne
//
//  Created by Christian Cocking on 11/10/13.
//  Copyright (c) 2013 Christian Cocking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *) deck;

- (void) chooseCardAtIndex:(NSUInteger)index;
- (Card*) cardAtIndex:(NSUInteger)index;


@property (nonatomic, strong, readonly) NSMutableArray *statusCards;
@property (nonatomic, readonly) NSInteger roundScore;
@property (nonatomic, readonly) NSInteger score;
@property BOOL isThreeCardGame;

@end
