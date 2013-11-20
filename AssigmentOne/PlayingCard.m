//
//  PlayingCard.m
//  AssigmentOne
//
//  Created by Christian Cocking on 10/28/13.
//  Copyright (c) 2013 Christian Cocking. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *) contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        NSLog(@"Should get hit three times due to my recursion");

        // Grabs the first object in the NSArray and wont crash on arrayIndexOutOfBounds
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]){
            score = 1;
        }
    }
    
    // Two card match

    if ([otherCards count] == 2) {
        NSLog(@"Two card Match Scenario ");

        // Should check if these objects are all PlayingCards for completeness
        score += [self match:@[[otherCards firstObject]]];
        score += [self match: @[[otherCards lastObject]]];
        score += [[otherCards firstObject] match:@[[otherCards lastObject]]];
    }
    return score;
}



@synthesize suit = _suit; //When implementing both the setter and getter need to synthesize

+ (NSArray *) validSuits
{
    static NSArray *validSuits = nil;
    if (!validSuits) validSuits = @[@"♠️",@"♦️",@"♣️",@"♥️"];
    return validSuits;
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *) rankStrings
{
    static NSArray *rankStrings = nil;
    if (!rankStrings) rankStrings =@[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    return rankStrings;
}

+ (NSUInteger)maxRank {return [self rankStrings].count-1;}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end