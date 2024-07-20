//
//  ViewController.m
//  LocalTool
//
//  Created by lofi on 2024/7/2.
//

#import "ViewController.h"
#import <LKUtils/LKGenesis.h>
#import <LKUtils/SearchTransitionAnimator.h>
#import "testSearchVC.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (IBAction)showSomePopMenu:(id)sender {
    [LKGenesis LKGenesisSay];
}

- (IBAction)gotoSearchTrans:(id)sender {
    testSearchVC * vc = [[testSearchVC alloc] initWithNibName:@"testSearchVC" bundle:nil];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    SearchTransitionAnimator *transitionAnimator = [SearchTransitionAnimator new];
    transitionAnimator.isFromeSearch = NO;
    return transitionAnimator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    SearchTransitionAnimator *transitionAnimator = [SearchTransitionAnimator new];
    transitionAnimator.isFromeSearch = YES;
    return transitionAnimator;
}

@end
