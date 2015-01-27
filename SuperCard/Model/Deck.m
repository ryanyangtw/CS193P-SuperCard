//
//  Deck.m
//  Matchismo
//
//  Created by Ryan on 2015/1/22.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

#import "Deck.h"

@interface Deck()
    @property (strong, nonatomic) NSMutableArray *cards;
@end


@implementation Deck

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}


- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if(atTop){
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }

}

- (void)addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard
{
    Card *randomCard = nil;

    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
        
        /*
        NSLog(@"index: %u", index);
        NSLog(@"%@" , self.cards[index]);
        NSLog(@"%@", randomCard.contents);
        Card *car = self.cards[index];
        NSLog(@"test: %@", car.contents);
        */
    }

    return randomCard;
    
}

@end
