//
//  showTableACollectionTestViewVC.m
//  LKDisplayModule
//
//  Created by lofi on 2024/8/1.
//

#import "showTableACollectionTestViewVC.h"
#import <Masonry/Masonry.h>
#import <LKDisplayModule/showTableACollectionTestView.h>

@interface showTableACollectionTestViewVC ()

@end

@implementation showTableACollectionTestViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    showTableACollectionTestView * View = [[showTableACollectionTestView alloc] init];
    [self.view addSubview:View];
    [View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}


@end
