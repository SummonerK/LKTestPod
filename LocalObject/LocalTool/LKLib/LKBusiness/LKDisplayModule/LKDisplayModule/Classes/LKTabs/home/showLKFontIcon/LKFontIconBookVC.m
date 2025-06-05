//
//  LKFontIconBookVC.m
//  LKDisplayModule
//
//  Created by lofi on 2024/10/11.
//

#import "LKFontIconBookVC.h"

#import <Masonry/Masonry.h>
#import <LKUtils/LKMacroDefine.h>
#import <LKIconFontKit/LKFont.h>

#import "UICollectionViewLeftAlignedLayout.h"
#import "LKFontIconBookCCell.h"

@interface LKFontIconBookVC ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;          //
@property (nonatomic, strong) UICollectionViewLeftAlignedLayout *collectionViewFlowLayout;
@property(nonatomic, copy) NSArray *arrayIconKeys; //图标-key集合

@end

@implementation LKFontIconBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self featchAllLKFontKeys];
    
    [self addLongPressGesture];
}

#pragma mark - setupUI

- (void)setupUI {
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

/**
 *  长按-投诉
 */
- (void)addLongPressGesture {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongPressAtCell:)];
    longPress.delegate = self;
    [self.collectionView addGestureRecognizer:longPress];
}

/// 长按-cell区域
/// - Parameter longPress: 长按手势
- (void)didLongPressAtCell:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        CGPoint      point       = [longPress locationInView:self.collectionView];
        NSIndexPath *pathAtView  = [self.collectionView indexPathForItemAtPoint:point];
        NSString * iconKey = self.arrayIconKeys[pathAtView.row];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string        = iconKey;
        NSString *toastString    = [NSString stringWithFormat:@"复制成功"];
        [UIApplication makeToast:toastString];
    }
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.arrayIconKeys count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LKFontIconBookCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LKFontIconBookCCell class]) forIndexPath:indexPath];
    cell.iconKey = self.arrayIconKeys[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了CollectionViewCell");
}

#pragma mark - getter

- (CGSize)collectionItemSize {
    CGFloat w = ceil((KScreen_Width - 20 - 22)/3);
    CGFloat h = 120;
    return CGSizeMake(w, h);
}

- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    if (!_collectionViewFlowLayout) {
        _collectionViewFlowLayout = [[UICollectionViewLeftAlignedLayout alloc] init];
        [_collectionViewFlowLayout setMinimumLineSpacing:10];
        [_collectionViewFlowLayout setMinimumInteritemSpacing:10];
        [_collectionViewFlowLayout setItemSize:[self collectionItemSize]];
        [_collectionViewFlowLayout setHeaderReferenceSize:CGSizeMake(0, 0)];
        [_collectionViewFlowLayout setFooterReferenceSize:CGSizeMake(0, 0)];
        [_collectionViewFlowLayout setSectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
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
        [_collectionView registerClass:[LKFontIconBookCCell class] forCellWithReuseIdentifier:NSStringFromClass([LKFontIconBookCCell class])];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
    }
    return _collectionView;
}

#pragma mark - 组装数据

- (void)featchAllLKFontKeys {
    NSArray* normalKeys = [[[LKFont allIcons] allKeys] sortedArrayUsingSelector:@selector(compare:)];
    self.arrayIconKeys = normalKeys;
    [self.collectionView reloadData];
}

@end
