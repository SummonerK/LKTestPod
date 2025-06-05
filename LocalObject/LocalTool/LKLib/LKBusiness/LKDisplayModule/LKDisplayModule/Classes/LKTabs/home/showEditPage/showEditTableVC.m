//
//  showEditTableVC.m
//  LKDisplayModule
//
//  Created by lofi on 2024/11/6.
//

#import "showEditTableVC.h"

#import <Masonry/Masonry.h>
#import <LKUtils/LKMacroDefine.h>

#import "showEditTCell.h"

@interface showEditTableVC () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property(nonatomic, strong) UITableView *tableView_edit;  // 动态详情
@property(nonatomic, strong) showEditTCell *managerEditCell;  // 长按编辑showCell
@property(nonatomic, strong) NSIndexPath *managerIndexPath;

@end

@implementation showEditTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.tableView_edit];
    [self.tableView_edit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(KNavBar_Height + 50);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    
    [self.tableView_edit addSubview:self.managerEditCell];
    [self addLongPressGesture];
}

/**
 *  长按-编辑
 */
- (void)addLongPressGesture {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongPressAtCell:)];
    [self.tableView_edit addGestureRecognizer:longPress];
}

- (void)didLongPressAtCell:(UILongPressGestureRecognizer *)longPress {
    CGPoint      point       = [longPress locationInView:self.tableView_edit];
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            [self editCellBegin:point];
            break;
        case UIGestureRecognizerStateChanged:
            [self editCellChanged:point];
            break;
        case UIGestureRecognizerStateEnded:
            [self editCellEnded:point];
            break;
        case UIGestureRecognizerStateCancelled:
            [self editCellEnded:point];
            break;
        default:
            break;
    }
}

- (void)editCellBegin:(CGPoint)point {
    NSIndexPath *pathAtView  = [self.tableView_edit indexPathForRowAtPoint:point];
    if (!pathAtView) {
        return;
    }
    self.managerIndexPath = pathAtView;
    showEditTCell *currentEditCell = [self.tableView_edit cellForRowAtIndexPath:pathAtView];
    currentEditCell.hidden = YES;
    self.managerEditCell.frame = currentEditCell.frame;
    self.managerEditCell.hidden = NO;
    self.managerEditCell.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [self.tableView_edit bringSubviewToFront:self.managerEditCell];
}

- (void)editCellChanged:(CGPoint)point {
    self.managerEditCell.center = CGPointMake(KScreen_Width/2, point.y);
    NSIndexPath *pathAtView  = [self.tableView_edit indexPathForRowAtPoint:point];
    if (!pathAtView) {
        return;
    }
    if (!self.managerIndexPath || self.managerIndexPath == pathAtView) {
        return;
    }
    [self.tableView_edit moveRowAtIndexPath:self.managerIndexPath toIndexPath:pathAtView];
    self.managerIndexPath = pathAtView;
}

- (void)editCellEnded:(CGPoint)point {
    NSIndexPath *pathAtView  = [self.tableView_edit indexPathForRowAtPoint:point];
    if (!pathAtView) {
        return;
    }
    showEditTCell *endCell = [self.tableView_edit cellForRowAtIndexPath:pathAtView];
    [UIView animateWithDuration:0.25 animations:^{
        self.managerEditCell.transform = CGAffineTransformIdentity;
        self.managerEditCell.center = endCell.center;
    } completion:^(BOOL finished) {
        endCell.hidden = NO;
        self.managerEditCell.hidden = YES;
        self.managerIndexPath = nil;
    }];
}

#pragma mark - dataSources

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    showEditTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"showEditTCell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - delegates

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 16.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

#pragma mark - Getter

- (UITableView *)tableView_edit {
    if (!_tableView_edit) {
        _tableView_edit                              = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView_edit.backgroundColor              = kColorWithLightAndDarkHexStr(@"#ffffff", @"#191919");
        _tableView_edit.separatorStyle               = UITableViewCellSeparatorStyleNone;
        _tableView_edit.dataSource                   = self;
        _tableView_edit.delegate                     = self;
        _tableView_edit.showsVerticalScrollIndicator = NO;

        [_tableView_edit registerClass:[showEditTCell class] forCellReuseIdentifier:@"showEditTCell"];

        if (@available(iOS 15.0, *)) {
            _tableView_edit.sectionHeaderTopPadding = 0;
        }
        _tableView_edit.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _tableView_edit;
}

- (showEditTCell *)managerEditCell {
    if (!_managerEditCell) {
//        _managerEditCell = [[showEditTCell alloc] initWithFrame:CGRectMake(0, 0, KScreen_Width, 60) reuseIdentifier:@"showEditTCell"];
//        _managerEditCell = [[showEditTCell alloc] initWithFrame:CGRectMake(0, 0, KScreen_Width, 60)];
        _managerEditCell = [[showEditTCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _managerEditCell.frame = CGRectMake(0, 0, KScreen_Width, 60);
        [_managerEditCell layoutIfNeeded];
        _managerEditCell.hidden = YES;
        _managerEditCell.backgroundColor = kColorRandom;
    }
    return _managerEditCell;
}

@end
