//
//  AnimateButton.m
//  SideMenu
//
//  Created by Truong Son Nguyen on 10/4/17.
//  Copyright © 2017 Truong Son Nguyen. All rights reserved.
//

#import "AnimateButton.h"
#import "pop/POP.h"
@implementation AnimateButton

- (void) awakeFromNib {
    // Not usable with UIControls
    [super awakeFromNib];
    _contraint = 125.0/255.0;
    self.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.layer.shadowColor = [UIColor colorWithRed:_contraint green:_contraint blue:_contraint alpha:1.0].CGColor;
    self.layer.shadowOpacity = 0.8 ;
    self.layer.cornerRadius = 5.0;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit ;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = self.frame.size.width/2;
}
- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (self.highlighted) {
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.duration = 0.1;
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.9, 0.9)];
        [self pop_removeAllAnimations];
        [self pop_addAnimation:scaleAnimation forKey:@"scalingUpPopAnimationButton"];
        
    } else {
        
        POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        sprintAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
        sprintAnimation.springBounciness = 20.f;
        [self pop_removeAllAnimations];
        [self pop_addAnimation:sprintAnimation forKey:@"springAnimationPopAnimationButton"];
        
    }
}

@end
