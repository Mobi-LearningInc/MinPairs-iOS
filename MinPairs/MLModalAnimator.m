//
//  MLModalAnimator.m
//  MinPairs
//
//  Created by Brandon on 2014-05-09.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLModalAnimator.h"

@interface MLModalAnimator()
@property (nonatomic, strong) NSArray* constraints;
@property (nonatomic, strong) UIView* view;
@end

@implementation MLModalAnimator
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView* containerView = [transitionContext containerView];
    if (self.present)
    {
        UIView* viewToShow = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        
        if (!_view)
        {
            _view = [[UIView alloc] initWithFrame: containerView.frame];
            _view.backgroundColor = [UIColor colorWithWhite: 0.0f alpha: 0.6f];
            _view.alpha = 0.0f;
        }
        else
        {
            _view.frame = containerView.frame;
        }
        
        viewToShow.translatesAutoresizingMaskIntoConstraints = false;
        [containerView addSubview: [self view]];
        [containerView addSubview: viewToShow];
        
        
        NSDictionary* views = NSDictionaryOfVariableBindings(containerView, viewToShow);
        NSString* hConstraint = [NSString stringWithFormat:@"H:|-%f-[viewToShow]-%f-|", [self padding], [self padding]];
        NSString* vConstraint = [NSString stringWithFormat:@"V:|-%f-[viewToShow]-%f-|", [self padding], [self padding]];
        
        _constraints = [[NSLayoutConstraint constraintsWithVisualFormat: hConstraint options: 0 metrics: nil views: views] arrayByAddingObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat: vConstraint options: 0 metrics: nil views: views]];
        
        [containerView addConstraints: [self constraints]];
        
        CGRect rect = viewToShow.frame;
        viewToShow.frame = CGRectMake(rect.origin.x, containerView.frame.size.height, rect.size.width, rect.size.height);
        [containerView bringSubviewToFront: viewToShow];

        [UIView animateWithDuration: [self transitionDuration: transitionContext] delay: 0.0f usingSpringWithDamping: 0.8f initialSpringVelocity: 1.0f options: 0 animations: ^{
                viewToShow.frame = rect;
                self.view.alpha = 1.0f;
            } completion: ^(BOOL finished) {
                [transitionContext completeTransition: true];
            }
         ];
    }
    else
    {
        [[self view] removeFromSuperview];
        [containerView removeConstraints: [self constraints]];
        [transitionContext completeTransition: true];
    }
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}
@end
