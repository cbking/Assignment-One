//
//  AS1ViewController.m
//  AssigmentOne
//
//  Created by Christian Cocking on 10/26/13.
//  Copyright (c) 2013 Christian Cocking. All rights reserved.
//

#import "AS1ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface AS1ViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
- (IBAction)shuffleCards:(id)sender;
- (IBAction)gameMode:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeControl;

@end

@implementation AS1ViewController

- (IBAction)gameMode:(id)sender {
    
    if ([sender selectedSegmentIndex] == 0) self.game.isThreeCardGame = NO;
    if ([sender selectedSegmentIndex] == 1) self.game.isThreeCardGame = YES;
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}


- (IBAction)shuffleCards:(id)sender
{
    
    // Is this really the safe way to go about doing this?
    //    for (UIButton *cardButton in self.cardButtons) {
    //        int index = [self.cardButtons indexOfObject:cardButton];
    //        Card *card = [self.game cardAtIndex:index];
    //        if (card.faceUp) card.FaceUp = NO;
    //        if (card.unplayable)card.Unplayable = NO;
    //    }
    
    self.gameModeControl.enabled = YES;
    _game = nil;
    [self updateUI];

}


- (Deck*) createDeck
{
    return [[PlayingCardDeck alloc] init];
}


- (IBAction)flipCard:(UIButton *)sender
{
    self.gameModeControl.enabled = NO;
    int chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    [self updateUI];
}


- (void) updateUI
{
    for (UIButton *cardBUtton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardBUtton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardBUtton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardBUtton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardBUtton.enabled =!card.isUnplayable;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
    
}

- (NSString *) titleForCard: (Card *) card
{
    return card.isFaceUp ? card.contents : @"";
}

- (UIImage *) backgroundImageForCard: (Card *) card
{
    return [UIImage imageNamed:card.isFaceUp ? @"cardfront" : @"cardback1"];
}


@end
