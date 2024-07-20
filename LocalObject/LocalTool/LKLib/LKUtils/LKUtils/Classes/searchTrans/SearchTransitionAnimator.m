//
//  SearchTransitionAnimator.m
//
//
//  Created by lofi on 2024/7/10.
//

#import "SearchTransitionAnimator.h"

@implementation SearchTransitionAnimator

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext { 
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    
    UIView *fromView;
    UIView *toView;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
    
    if(_isFromeSearch) {
        fromView.alpha = 1.0f;
        toView.alpha = 0.0f;
        fromView.frame = fromFrame;
        NSLog(@"%.2lf,%.2lf,%.2lf,%.2lf",fromFrame.origin.x,fromFrame.origin.y,fromFrame.size.width,fromFrame.size.height);
        toView.frame = CGRectOffset(toFrame, 0, -64);
    }else {
        fromView.alpha = 1.0f;
        toView.alpha = 0.0f;
        fromView.frame = fromFrame;
        NSLog(@"%.2lf,%.2lf,%.2lf,%.2lf",fromFrame.origin.x,fromFrame.origin.y,fromFrame.size.width,fromFrame.size.height);
        toView.frame = CGRectOffset(toFrame, 0, 44);
    }
    [containerView addSubview:toView];
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:transitionDuration animations:^{
        
        if(self.isFromeSearch){
            fromView.alpha = 1.0f;
            toView.alpha = 1.0;
            fromView.frame = CGRectOffset(fromFrame, 0, 44);
        } else {
            fromView.alpha = 0.0f;
            toView.alpha = 1.0;
            fromView.frame = CGRectOffset(fromFrame, 0, -64);
        }
        toView.frame = toFrame;
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.2;
}

@end
