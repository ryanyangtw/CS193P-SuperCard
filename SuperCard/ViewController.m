//
//  ViewController.m
//  SuperCard
//
//  Created by Ryan on 2015/1/27.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;
@property (strong, nonatomic) Deck *deck;

@end

@implementation ViewController


- (Deck *)deck
{
    if (!_deck)_deck = [[PlayingCardDeck alloc] init];
    return _deck;
}


- (void)drawRandomPlayingCard
{
    Card *card = [self.deck drawRandomCard]; //return PlayingCard Obj
    //Card *fuck = (Card *)card;
    //if ([fuck isMemberOfClass:[PlayingCard class]]) { NSLog(@"Fuck!!!!!"); }
    //NSLog(@"card class is : %@", [card class]);
    
    if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *playingCard = (PlayingCard *)card;
        self.playingCardView.rank = playingCard.rank;
        self.playingCardView.suit = playingCard.suit;
    }
}


- (IBAction)swipe:(id)sender {
    if (!self.playingCardView.faceUp) [self drawRandomPlayingCard];
    self.playingCardView.faceUp = !self.playingCardView.faceUp;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.playingCardView.faceUp = YES;
    //self.playingCardView.suit = @"♥";
    //self.playingCardView.rank = 13;
    
    [self.playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.playingCardView action:@selector(pinch:)]];
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
