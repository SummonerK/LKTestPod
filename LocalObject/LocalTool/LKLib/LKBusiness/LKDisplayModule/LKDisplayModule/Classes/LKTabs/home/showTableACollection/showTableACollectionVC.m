//
//  showTableACollectionVC.m
//  LKDisplayModule
//
//  Created by lofi on 2024/8/1.
//

///实现双ScrollView伴随滑动且互不影响点击，，公用一个刷新的'效果'

#import "showTableACollectionVC.h"
#import <LKUtils/LKMacroDefine.h>
#import <LKDisplayModule/UICollectionViewLeftAlignedLayout.h>
#import <LKUtils/UIScrollView+refresh.h>
#import <Masonry/Masonry.h>

@interface showTableACollectionVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView *tableView;          //
@property (nonatomic, strong) UICollectionView *collectionView;          //
@property (nonatomic, strong) UICollectionViewLeftAlignedLayout *collectionViewFlowLayout;

@end

@implementation showTableACollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setupUI];
    [self registRefresh];
}

#pragma mark - setupUI

- (void)setupUI {
//只把TableView视图图层后移，也可以达到共同滑动，公用一个刷新'效果'，
//但点击无法穿透，tableView点击只能借助手势，获取point，进一步确定点击tableView的位置和Cell
//对头部点击会无感，或者统一定义protrol，识别为遵循相应协议的View相应点击
//    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.tableView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
}

- (void)registRefresh {
    weakObj(self)
    [self.collectionView xm_footerRefreshWithActionBlock:^{
        strongObj(self)
        weakObj(self)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            strongObj(self)
            NSLog(@"加载了更多了！！！");
            [self.collectionView endFooterRefreshing];
        });
    }];
    
    [self.tableView xm_footerRefreshNoneWithActionBlock:^{
        [self.collectionView beginFooterRefreshing];
        [self.tableView endFooterRefreshing];
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 检查是哪个 scrollView 在滚动
    if (scrollView == self.tableView) {
        self.collectionView.contentOffset = self.tableView.contentOffset;
    } else if (scrollView == self.collectionView) {
        self.tableView.contentOffset = self.collectionView.contentOffset;
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell description] forIndexPath:indexPath];
    
    cell.backgroundColor = kColorRandom;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了TableViewCell");
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor LKRandomColor:1.0];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了CollectionViewCell");
}

#pragma mark - getter

- (CGSize)collectionItemSize {
    CGFloat w = ceil((KScreen_Width - 100 - 20 - 30)/3);
    CGFloat h = 100;
    return CGSizeMake(w, h);
}

- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    if (!_collectionViewFlowLayout) {
        _collectionViewFlowLayout = [[UICollectionViewLeftAlignedLayout alloc] init];
        [_collectionViewFlowLayout setMinimumLineSpacing:0];
        [_collectionViewFlowLayout setMinimumInteritemSpacing:10];
        [_collectionViewFlowLayout setItemSize:[self collectionItemSize]];
        [_collectionViewFlowLayout setHeaderReferenceSize:CGSizeMake(0, 0)];
        [_collectionViewFlowLayout setFooterReferenceSize:CGSizeMake(0, 0)];
        [_collectionViewFlowLayout setSectionInset:UIEdgeInsetsMake(0, 110, 0, 0)];
        [_collectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView.userInteractionEnabled = NO;
    }
    return _collectionViewFlowLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewFlowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
    }
    return _collectionView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.allowsSelectionDuringEditing = YES;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell description]];
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}


@end
