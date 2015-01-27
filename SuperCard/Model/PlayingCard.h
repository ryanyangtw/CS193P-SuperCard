//
//  PlayingCard.h
//  Matchismo
//
//  Created by Ryan on 2015/1/22.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//


#import "card.h"

@interface PlayingCard : Card


@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
