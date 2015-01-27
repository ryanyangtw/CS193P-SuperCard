//
//  Card.m
//  Matchismo
//
//  Created by Ryan on 2015/1/22.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

#import "Card.h"


@interface Card()
@end

@implementation Card



- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards){
        if ([card.contents isEqualToString:self.contents]){
            score = 1;
        }
    }
    
    return score;
}

@end
