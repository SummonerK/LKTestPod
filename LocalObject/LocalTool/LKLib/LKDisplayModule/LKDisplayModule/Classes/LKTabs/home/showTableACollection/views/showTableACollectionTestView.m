//
//  showTableACollectionTestView.m
//  LKDisplayModule
//
//  Created by lofi on 2024/8/1.
//

#import "showTableACollectionTestView.h"
#import <LKUtils/LKMacroDefine.h>
#import <LKDisplayModule/UICollectionViewLeftAlignedLayout.h>
#import <LKUtils/UIScrollView+refresh.h>
#import <Masonry/Masonry.h>

@interface showTableACollectionTestView()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView *tableView;          //
@property (nonatomic, strong) UICollectionView *collectionView;          //
@property (nonatomic, strong) UICollectionViewLeftAlignedLayout *collectionViewFlowLayout;

@end

@implementation showTableACollectionTestView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self registRefresh];
    }
    return self;
}
///
///如果你想要处理 UICollectionView 中的触摸事件，最好是通过使用代理方法、在单元格中处理触摸事件、添加手势识别器或自定义布局来实现。直接重写 hitTest:withEvent: 方法通常是不必要的，并且可能会带来不必要的复杂性。
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self.collectionView) {
        return nil;
    }
    return view;
}

#pragma mark - setupUI

- (void)setupUI {
    [self addSubview:self.tableView];
    [self addSubview:self.collectionView];
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
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 检查是哪个 scrollView 在滚动
    if (scrollView == self.tableView) {
        self.collectionView.contentOffset = self.tableView.contentOffset;
    } else if (scrollView == self.collectionView) {
        self.tableView.contentOffset = self.collectionView.contentOffset;
    }
}

#pragma mark - dataSources

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
    cell.backgroundColor = [UIColor LKRandomColor:1.0];

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
        _tableView.allowsSelectionDuringEditing = NO;
        
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
