//
//  Deck.h
//  Matchismo
//
//  Created by Ryan on 2015/1/22.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
