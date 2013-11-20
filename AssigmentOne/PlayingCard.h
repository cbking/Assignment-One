//
//  PlayingCard.h
//  AssigmentOne
//
//  Created by Christian Cocking on 10/28/13.
//  Copyright (c) 2013 Christian Cocking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *) validSuits;
+(NSUInteger) maxRank;

@end
