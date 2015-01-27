//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Ryan on 2015/1/27.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) bool faceUp;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;


@end
