//
//  LKSVGPlayer.m
//  LKDisplayModule
//
//  Created by lofi on 2024/8/29.
//

#import "LKSVGPlayer.h"
#import <SVGAPlayer/SVGAPlayer.h>
#import <SVGAPlayer/SVGAParser.h>
#import <LKUtils/UIApplication+Ext.h>

static LKSVGPlayer *_shared;
@interface LKSVGPlayer()<SVGAPlayerDelegate>

@property(nonatomic, strong) SVGAParser *svgaParser;

@property(nonatomic, strong) SVGAPlayer *svgaPlayer;

@end

@implementation LKSVGPlayer

+ (void)showSvgPlayerWithView:(UIView*)targetView {
    LKSVGPlayer *shared = [[LKSVGPlayer alloc] init];
    [shared startSvgaAnimationWithView:targetView];
    _shared = shared;
}

- (void)startSvgaAnimationWithView:(UIView*)targetView {
    UIView *keywindow = [UIApplication sharedApplication].xm_keyWindow;
    [keywindow addSubview:self.svgaPlayer];
    CGFloat left = targetView.frame.origin.x;
    CGFloat top = targetView.frame.origin.y - 200;
    CGFloat width = 200;
    CGFloat height = 200;
    self.svgaPlayer.frame = CGRectMake(left, top, width, height);
    [keywindow bringSubviewToFront:self.svgaPlayer];
    
    [self showLocalSource];
}

- (void)showOnlineSource {
    NSURL *bundleURL = [NSURL URLWithString:@"https://github.com/yyued/SVGA-Samples/blob/master/posche.svga?raw=true"];
    
    [self.svgaParser parseWithURL:bundleURL completionBlock:^(SVGAVideoEntity * _Nullable videoItem) {
        self.svgaPlayer.videoItem = videoItem;
        [self.svgaPlayer startAnimation];
    } failureBlock:^(NSError * _Nullable error) {
        NSLog(@"error ========> %@", error);
    }];
}

- (void)showLocalSource {
    NSString *svgaName = @"like_big_fall_left";
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"LKDisplayBundle" withExtension:@"bundle"];
    if (!bundleURL) {
        return;
    }
    NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
    [self.svgaParser parseWithNamed:svgaName
                           inBundle:bundle
                    completionBlock:^(SVGAVideoEntity *_Nonnull videoItem) {
        self.svgaPlayer.videoItem = videoItem;
        [self.svgaPlayer startAnimation];
    }failureBlock:^(NSError *_Nonnull error) {
        NSLog(@"error ========> %@", error);
    }];
}

- (void)stopSvgaAnimation {
    [self.svgaPlayer removeFromSuperview];
    _shared = nil;
}

#pragma mark - SVGAPlayerDelegate

- (void)svgaPlayerDidFinishedAnimation:(SVGAPlayer *)player {
    [self stopSvgaAnimation];
}

- (SVGAParser *)svgaParser {
    if (!_svgaParser) {
        _svgaParser = [[SVGAParser alloc] init];
    }
    return _svgaParser;
}

- (SVGAPlayer *)svgaPlayer {
    if (!_svgaPlayer) {
        _svgaPlayer                 = [[SVGAPlayer alloc] init];
        _svgaPlayer.fillMode        = @"Forward";
        _svgaPlayer.contentMode     = UIViewContentModeScaleAspectFit;
        _svgaPlayer.loops           = 1;
        _svgaPlayer.clearsAfterStop = YES;
        _svgaPlayer.delegate        = self;
    }
    return _svgaPlayer;
}

@end
