//
//  CardMatchingGame.m
//  AssigmentOne
//
//  Created by Christian Cocking on 11/10/13.
//  Copyright (c) 2013 Christian Cocking. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger roundScore;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray *faceUpCards;
@property (nonatomic,strong, readwrite) NSMutableArray * statusCards;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *) statusCards
{
    if (!_statusCards) _statusCards = [[NSMutableArray alloc] init];
    return _statusCards;
}


- (NSMutableArray *)faceUpCards
{
    if (!_faceUpCards) _faceUpCards = [[NSMutableArray alloc] init];
    return _faceUpCards;
}



- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [[self cards] addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index <= self.cards.count) ? [self.cards objectAtIndex:index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    // Need mode to be read as the property that the switch defines
    if (!self.isThreeCardGame) {
    if (!card.isUnplayable) {
        if (card.isFaceUp) {
            card.FaceUp = NO;
        } else {
            // match against other chosen cards
        for (Card *otherCard in self.cards) {
            if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                int matchscore = [card match:@[otherCard]];
                [self.statusCards insertObject:card atIndex:0];
                [self.statusCards insertObject:otherCard atIndex:1];
                if (matchscore) {
                    self.score += matchscore * MATCH_BONUS;
                    self.roundScore = matchscore * MATCH_BONUS;
                    otherCard.unplayable = YES;
                    card.unplayable = YES;
                } else {
                    self.score -= MISMATCH_PENALTY;
                    self.roundScore = -1 * MISMATCH_PENALTY;
                    otherCard.faceUp = NO;
                }
                break; //you can other choose two cards for now;
            }
        }
        self.score -= COST_TO_CHOOSE;
        card.faceUp = YES;

            }
        }
    }
    
    if (self.isThreeCardGame)  [self choseCardAtIndexThreeCard:index];
}

//Three card choose card at index
- (void) choseCardAtIndexThreeCard:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (card.isFaceUp ) {
            card.FaceUp = NO;
        } else {
            //You are touching a card that is currently face-down add it to our face up cards array
            // match against other chosen cards
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [self.faceUpCards addObject:otherCard];
                }
            }
        }
    }
    NSLog(@"Breaks Before Checking count");
    if (self.faceUpCards.count == 2) {
        NSLog(@"Breaks After Checking count");
        int matchscore = [card match:self.faceUpCards];
        NSLog(@"Breaks After Match call");
        if (matchscore) {
            self.score += matchscore * MATCH_BONUS;
            for (Card *faceUpCard in self.faceUpCards) {
                faceUpCard.unplayable = YES;
            }
            card.unplayable = YES;
        } else {
            self.score -= MISMATCH_PENALTY * 2;
            for (Card *faceUpCard in self.faceUpCards) {
                faceUpCard.faceUp = NO;
            }
        }
    }
    card.faceUp = YES;
    [self.faceUpCards removeAllObjects];
    
}








@end
