//
//  PlayingCardView.m
//  SuperCard
//
//  Created by Ryan on 2015/1/27.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

#import "PlayingCardView.h"

@interface PlayingCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;

@end



@implementation PlayingCardView

#pragma mark - Propreties

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

- (CGFloat)faceCardScaleFactor
{
    if (!_faceCardScaleFactor) _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
{
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}


- (void) setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}

- (void) setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}


- (void) setFaceUp:(bool)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

- (NSString *)rankAsString
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}


#pragma mark - Gesture Handling

- (void)pinch: (UIPinchGestureRecognizer *)gesture
{
    //NSLog(@"Pinch");
    if ((gesture.state == UIGestureRecognizerStateChanged) || gesture.state == UIGestureRecognizerStateEnded) {
        
        //NSLog(@"UIGestureRecognizerStateChanged");
        //NSLog(@"gesture.scale: %f",gesture.scale);
        
        self.faceCardScaleFactor *= gesture.scale;
        gesture.scale = 1.0;
    }

}



#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // Drawing code
    NSLog(@"in drawRect");
    UIBezierPath *roundedReck = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius] ];
    
    [roundedReck addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    //[roundedReck fill];   it's equal to above method
    
    [[UIColor blackColor] setStroke];
    [roundedReck stroke];
    
    //[self drawCorners];
    
    
    
    if (self.faceUp) {
        UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit]];
        //NSLog([NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit]);
        
        if (faceImage) {
            CGRect imageRect = CGRectInset(self.bounds, self.bounds.size.width * (1.0 - self.faceCardScaleFactor) , self.bounds.size.height * (1.0 - self.faceCardScaleFactor));
            
            //NSLog(@"faceCardScaleFactor: %f", self.faceCardScaleFactor);
            
            [faceImage drawInRect:imageRect];
        } else {
                    NSLog(@"draw pips");
            [self drawPips];
        }
        
        [self drawCorners];
    
    } else {
        [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds ];
    
    }
    
}


- (void)pushContextAndRotateUpsideDown
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    
}

- (void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

#pragma mark - Corners



- (void) drawCorners
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *cornerFont = [ UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];

    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit] attributes: @{NSFontAttributeName : cornerFont, NSParagraphStyleAttributeName: paragraphStyle}];
    
    CGRect textBounds;
    textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
    textBounds.size = [cornerText size];
    // draw the left up corner
    [cornerText drawInRect:textBounds];
    

    [self pushContextAndRotateUpsideDown];
    // draw the right down corner
    [cornerText drawInRect:textBounds];
    [self popContext];
    
}





#pragma mark - Pips

#define PIP_HOFFSET_PERCENTAGE 0.165
#define PIP_VOFFSET1_PERCENTAGE 0.090
#define PIP_VOFFSET2_PERCENTAGE 0.175
#define PIP_VOFFSET3_PERCENTAGE 0.270

- (void)drawPips
{
    if ((self.rank == 1) || (self.rank == 5) || (self.rank == 9) || (self.rank == 3)) {
        [self drawPipsWithHorizontalOffset:0
                            verticalOffset:0
                        mirroredVertically:NO];
    }
    if ((self.rank == 6) || (self.rank == 7) || (self.rank == 8)) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:0
                        mirroredVertically:NO];
    }
    if ((self.rank == 2) || (self.rank == 3) || (self.rank == 7) || (self.rank == 8) || (self.rank == 10)) {
        [self drawPipsWithHorizontalOffset:0
                            verticalOffset:PIP_VOFFSET2_PERCENTAGE
                        mirroredVertically:(self.rank != 7)];
    }
    if ((self.rank == 4) || (self.rank == 5) || (self.rank == 6) || (self.rank == 7) || (self.rank == 8) || (self.rank == 9) || (self.rank == 10)) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:PIP_VOFFSET3_PERCENTAGE
                        mirroredVertically:YES];
    }
    if ((self.rank == 9) || (self.rank == 10)) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:PIP_VOFFSET1_PERCENTAGE
                        mirroredVertically:YES];
    }
}

#define PIP_FONT_SCALE_FACTOR 0.012

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                          upsideDown:(BOOL)upsideDown
{
    if (upsideDown) [self pushContextAndRotateUpsideDown];
    CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    UIFont *pipFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    pipFont = [pipFont fontWithSize:[pipFont pointSize] * self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
    NSAttributedString *attributedSuit = [[NSAttributedString alloc] initWithString:self.suit attributes:@{ NSFontAttributeName : pipFont }];
    CGSize pipSize = [attributedSuit size];
    CGPoint pipOrigin = CGPointMake(
                                    middle.x-pipSize.width/2.0-hoffset*self.bounds.size.width,
                                    middle.y-pipSize.height/2.0-voffset*self.bounds.size.height
                                    );
    [attributedSuit drawAtPoint:pipOrigin];
    if (hoffset) {
        pipOrigin.x += hoffset*2.0*self.bounds.size.width;
        [attributedSuit drawAtPoint:pipOrigin];
    }
    if (upsideDown) [self popContext];
}

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                  mirroredVertically:(BOOL)mirroredVertically
{
    [self drawPipsWithHorizontalOffset:hoffset
                        verticalOffset:voffset
                            upsideDown:NO];
    if (mirroredVertically) {
        [self drawPipsWithHorizontalOffset:hoffset
                            verticalOffset:voffset
                                upsideDown:YES];
    }
}




#pragma mark - Inirialization

- (void)setup
{
    NSLog(@"in setup");
    self.backgroundColor = nil; //[UIColor clearColor]
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;

}

- (void)awakeFromNib
{
    NSLog(@"in awakeFromNib");
    [self setup];

}

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"in initWithFrame");
        [self setup];
    return self;
}



@end
