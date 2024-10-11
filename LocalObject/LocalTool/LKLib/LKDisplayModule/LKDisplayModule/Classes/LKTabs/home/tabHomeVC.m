//
//  tabHomeVC.m
//  LKDisplayModule
//
//  Created by lofi on 2024/7/23.
//

#import "tabHomeVC.h"
#import <Masonry/Masonry.h>
#import <LKUtils/UIColor+LKExt.h>
#import <LKUtils/XMTokenBucketLogManager.h>

#import "PageListModel.h"
#import "videoCacheVC.h"
#import "showTableACollectionVC.h"
#import "showTableACollectionTestViewVC.h"
#import "showSvgVC.h"
#import "LKFontViewController.h"
#import "LKFontIconBookVC.h"

@interface tabHomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<Section *> *sections;
@end

@implementation tabHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor LKColorWithHex:@"#f5f5f5"];
    [self setupUI];
    [self createDemoData];
    
    CLLogWithFile(@"🔴🟡🟢");
    CLLogWithFile(@"【XMLaunch】didFinishLaunchingWithOptions");
    // Do any additional setup after loading the view.
}


- (void)setupUI {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

- (void)createDemoData {
    NSMutableArray<Section *> *m = [NSMutableArray new];
    
    [m addObject:[[Section alloc] initWithTitle:@"DY" items:[self mockPlayerDemoItems]]];
    
    self.sections = [m copy];
    
    [self.tableView reloadData];
}

- (NSArray<Item *> *)mockPlayerDemoItems {
    return @[
        [Item.alloc initWithTitle:@"SJMediaCacheServer"
                         subTitle:@"AVPlayer&SJMediaCacheServer"
                               vc:[videoCacheVC new]],
        [Item.alloc initWithTitle:@"showTableACollection"
                         subTitle:@"showTableACollection combinView"
                               vc:[showTableACollectionVC new]],
        [Item.alloc initWithTitle:@"showTableACollection 测试穿透"
                         subTitle:@"showTableACollection"
                               vc:[showTableACollectionTestViewVC new]],
        [Item.alloc initWithTitle:@"测试 SVG play"
                         subTitle:@"animation SVG"
                               vc:[showSvgVC new]],
        [Item.alloc initWithTitle:@"测试 iconFontShow"
                         subTitle:@"show iconFont "
                               vc:[LKFontViewController new]],
        [Item.alloc initWithTitle:@"iconFontBook"
                         subTitle:@"show iconFont Book"
                               vc:[LKFontIconBookVC new]]
    ];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell description]];
        _tableView.rowHeight = 44;
    }
    
    return _tableView;
}

#pragma mark - dataSources

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Section * sectionData = [self.sections objectAtIndex:section];
    return sectionData.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell description] forIndexPath:indexPath];
    Section * sectionData = [self.sections objectAtIndex:indexPath.section];
    Item * item = [sectionData.items objectAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.subTitle;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    Section * sectionData = [self.sections objectAtIndex:indexPath.section];
    Item * item = [sectionData.items objectAtIndex:indexPath.row];
    UIViewController * toVC = item.vc;
    [self.navigationController pushViewController:toVC animated:YES];
}

#pragma mark - delegates

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
@end
