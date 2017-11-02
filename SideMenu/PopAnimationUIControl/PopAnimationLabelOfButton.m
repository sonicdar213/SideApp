//
//  PopAnimationLabelOfButton.m
//  ahamove
//
//  Created by Mac on 7/9/15.
//  Copyright (c) 2015 ahamove. All rights reserved.
//

#import "PopAnimationLabelOfButton.h"
#import <pop/Pop.h>
@implementation PopAnimationLabelOfButton
{
    BOOL isCustomHighlight;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (self.highlighted) {
        if (!isCustomHighlight) {
            POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
            scaleAnimation.duration = 0.1;
            scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.9, 0.9)];
//            scaleAnimation.autoreverses = TRUE;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            [self.titleLabel pop_addAnimation:scaleAnimation forKey:@"scalingDown"];
        }
        
    } else {
        
        if (isCustomHighlight) {
//            POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
//            sprintAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
//            sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
//            sprintAnimation.springBounciness = 0.f;
//            [self.titleLabel pop_removeAllAnimations];
//            [self.titleLabel pop_addAnimation:sprintAnimation forKey:@"springAnimationPopAnimationLabelOfButton"];
            
            POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
            scaleAnimation.duration = 0.1;
            scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
            //            scaleAnimation.autoreverses = TRUE;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            [self.titleLabel pop_addAnimation:scaleAnimation forKey:@"scalingUp"];
        }
        
    }
    isCustomHighlight = highlighted;
}


@end
