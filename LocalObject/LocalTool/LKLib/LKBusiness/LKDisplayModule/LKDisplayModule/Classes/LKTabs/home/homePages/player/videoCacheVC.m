//
//  videoCacheVC.m
//  LKDisplayModule
//
//  Created by lofi on 2024/7/23.
//

#import "videoCacheVC.h"
#import <LKUtils/UIColor+LKExt.h>
//#import <SJMediaCacheServer/SJMediaCacheServer.h>

@import AVFoundation;
@import AVKit;
@interface videoCacheVC ()
@property (nonatomic, strong) AVPlayer *player;
@end

@implementation videoCacheVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor LKRandomColor:1.0];
}

- (void)setupUI {
//    [self.view addSubview:self.player];
}

@end
