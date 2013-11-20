//
//  Card.h
//  AssigmentOne
//
//  Created by Christian Cocking on 10/28/13.
//  Copyright (c) 2013 Christian Cocking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString * contents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;

- (int) match:(NSArray *) otherCards;

@end
