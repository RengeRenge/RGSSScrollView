//
//  ViewController.m
//  RGSSScrollViewTest
//
//  Created by renge on 2021/3/3.
//

#import "ViewController.h"
#import "BGScrollerView.h"
#import "JHProductCollectionViewCell.h"
#import "JHProductCategoryTableViewCell.h"
#import "XJLabelCollectionReusableView.h"

#import "UIScrollView+RGInset.h"

static NSString *RGCellIDValueDefault = @"RGCellIDValueDefault";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
>

@property (nonatomic, strong) BGScrollerView *container;

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BGCollectionView *collectionView;

@property (nonatomic, assign) BOOL bgCanScrol;
@property (nonatomic, assign) BOOL pdCanScrol;

@property (nonatomic, strong) NSDictionary <NSNumber*, NSMutableArray <NSDictionary *> *> *sortProducts;
@property (nonatomic, strong) NSArray <NSDictionary *> *categorys;

@end

NSString *bleImage = @"ble";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bgCanScrol = YES;
    self.pdCanScrol = NO;
    [self.view addSubview:self.container];
    
    [self.container addSubview:self.headView];
    [self.container addSubview:self.collectionView];
    [self.container addSubview:self.tableView];
    self.categorys = @[
        @{@"name": @"1", @"icon": bleImage, @"id": @0},
        @{@"name": @"2", @"icon": bleImage, @"id": @1},
        @{@"name": @"3", @"icon": bleImage, @"id": @2},
        @{@"name": @"4", @"icon": bleImage, @"id": @3},
        @{@"name": @"5", @"icon": bleImage, @"id": @4},
        @{@"name": @"6", @"icon": bleImage, @"id": @5},
    ];
    self.sortProducts = @{
        @0: @[
                @{@"name": @"1", @"list": @[@{@"name": @"RGB灯", @"icon": @"p1"}, @{@"name": @"RGB灯2", @"icon": @"p2"}]},
                @{@"name": @"2", @"list": @[@{@"name": @"RGB灯", @"icon": @"p3"}]},
                @{@"name": @"3", @"list": @[@{@"name": @"RGB灯", @"icon": @"p4"}]},
                @{@"name": @"4", @"list": @[@{@"name": @"RGB灯", @"icon": @"p1"}]},
                @{@"name": @"5", @"list": @[@{@"name": @"RGB灯", @"icon": @"p2"}]},
                @{@"name": @"6", @"list": @[@{@"name": @"RGB灯", @"icon": @"p3"}]},
                @{@"name": @"7", @"list": @[@{@"name": @"RGB灯", @"icon": @"p4"}]},
                @{@"name": @"8", @"list": @[@{@"name": @"RGB灯", @"icon": @"p1"}]},
        ],
        @1: @[
                @{@"name": @"1", @"list": @[@{@"name": @"RGB灯", @"icon": @"p4"}]},
                @{@"name": @"1", @"list": @[@{@"name": @"RGB灯", @"icon": @"p4"}]},
                @{@"name": @"1", @"list": @[@{@"name": @"RGB灯", @"icon": @"p4"}]},
        ],
        @2: @[
                @{@"name": @"1", @"list": @[@{@"name": @"RGB灯", @"icon": @"p4"}]},
                @{@"name": @"1", @"list": @[@{@"name": @"RGB灯", @"icon": @"p4"}]},
                @{@"name": @"1", @"list": @[@{@"name": @"RGB灯", @"icon": @"p4"}]},
        ],
    };
    
    [self.tableView performBatchUpdates:^{

    } completion:^(BOOL finished) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }];
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [UIView new];
        _headView.backgroundColor = [UIColor colorWithRed:185.f/255.f green:219.f/255.f blue:221.f/255.f alpha:1];
    }
    return _headView;
}

- (BGScrollerView *)container {
    if (!_container) {
        _container = [BGScrollerView new];
        _container.bounces = YES;
        _container.delegate = self;
        _container.alwaysBounceVertical = YES;
    }
    return _container;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = UIView.new;
        _tableView.rowHeight = 84;
        _tableView.backgroundColor = [UIColor secondarySystemBackgroundColor];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass(JHProductCategoryTableViewCell.class) bundle:nil] forCellReuseIdentifier:RGCellIDValueDefault];
    }
    return _tableView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView = [[BGCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.clearColor;
        _collectionView.bounces = YES;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerClass:XJLabelCollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:XJLabelCollectionReusableViewId];
        UINib *nib = [UINib nibWithNibName:NSStringFromClass(JHProductCollectionViewCell.class) bundle:nil];
        [_collectionView registerNib:nib forCellWithReuseIdentifier:RGCellIDValueDefault];
    }
    return _collectionView;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    
    self.container.frame = bounds;
    
    CGFloat bleHeight = 130;
    CGFloat layoutY = self.view.safeAreaInsets.top;
    
    self.headView.frame = CGRectMake(0, 0, bounds.size.width, bleHeight);
    CGFloat top = CGRectGetMaxY(self.headView.frame);
    
    self.tableView.frame = CGRectMake(0, top, CGRectGetWidth(bounds)*0.28, bounds.size.height - layoutY);
    self.collectionView.frame = CGRectMake(CGRectGetMaxX(self.tableView.frame), top, CGRectGetWidth(bounds)*0.72, bounds.size.height - layoutY);
    self.container.contentSize = CGSizeMake(bounds.size.width, CGRectGetMaxY(self.collectionView.frame));
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.collectionView) {
        NSLog(@"111");
    } else if (scrollView == self.container) {
        NSLog(@"222");
    } else if (scrollView == self.tableView) {
        NSLog(@"333");
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat maxOffSet = self.collectionView.frame.origin.y - self.view.safeAreaInsets.top;
    if (maxOffSet <= 0) {
        return;
    }
    if (scrollView == self.collectionView || scrollView == self.tableView) {
        if (!self.pdCanScrol) {
            scrollView.contentOffset = CGPointMake(0, 0);
            NSLog(@"1");
        } else if (scrollView.contentOffset.y <= 0) {
            self.bgCanScrol = YES;
            self.pdCanScrol = NO;
            NSLog(@"2");
        } else {
            if (self.container.contentOffset.y > 0 && self.container.contentOffset.y < maxOffSet) {
                self.pdCanScrol = NO;
                NSLog(@"3");
            }
        }
    } else if (scrollView == self.container) {
        if (!self.bgCanScrol) {
            BOOL notFullPage = self.collectionView.rg_isReachTop && self.collectionView.rg_isReachBottom;
//            BOOL tb_notFullPage = self.tableView.rg_isReachTop && self.tableView.rg_isReachBottom;
//            if ((!notFullPage && !tb_notFullPage) || self.container.contentOffset.y > maxOffSet) {
//                self.container.contentOffset = CGPointMake(0, maxOffSet);
//            }
            if (!notFullPage || self.container.contentOffset.y > maxOffSet) {
                self.container.contentOffset = CGPointMake(0, maxOffSet);
            }
            self.pdCanScrol = YES;
            NSLog(@"4");
        } else if (self.container.contentOffset.y >= maxOffSet) {
            self.container.contentOffset = CGPointMake(0, maxOffSet);
            self.bgCanScrol = NO;
            self.pdCanScrol = YES;
            NSLog(@"5");
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categorys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JHProductCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RGCellIDValueDefault forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *product = self.categorys[indexPath.row];
    cell.icon.image = [[UIImage imageNamed:product[@"icon"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cell.cateName.text = product[@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.collectionView reloadData];
}

#pragma mark - UICollectionDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView == self.collectionView) {
        NSInteger row = self.tableView.indexPathForSelectedRow.row;
        NSDictionary *cate = self.categorys[row];
        NSArray *sections = self.sortProducts[cate[@"id"]];
        return sections.count;
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.collectionView) {
        NSInteger row = self.tableView.indexPathForSelectedRow.row;
        NSDictionary *cate = self.categorys[row];
        NSArray *sections = self.sortProducts[cate[@"id"]];
        return [sections[section][@"list"] count];
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (collectionView == self.collectionView) {
        return CGSizeMake(collectionView.frame.size.width, 35);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewFlowLayout *layouts = (UICollectionViewFlowLayout *)collectionViewLayout;
    CGFloat height = collectionView.frame.size.height;
    if (@available(iOS 11.0, *)) {
        height -= (collectionView.safeAreaInsets.top + collectionView.safeAreaInsets.bottom);
    }
    height = MAX(120, (height / 5));
    
    CGFloat count = 3.f;
    if (collectionView.bounds.size.height <  collectionView.bounds.size.width) {
        count = 4.f;
    }
    CGFloat width = (collectionView.frame.size.width - layouts.minimumInteritemSpacing * (count - 1) - layouts.sectionInset.left - layouts.sectionInset.right) / count;
    return CGSizeMake(width, height);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    XJLabelCollectionReusableView *header =
    [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:XJLabelCollectionReusableViewId forIndexPath:indexPath];
    
    NSInteger row = self.tableView.indexPathForSelectedRow.row;
    NSDictionary *cate = self.categorys[row];
    NSArray *sections = self.sortProducts[cate[@"id"]];
    NSDictionary *cate2 = sections[indexPath.section];
    
    header.label.text = cate2[@"name"];
    header.label.textColor = UIColor.grayColor;
    header.label.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    header.hideBlackView = YES;
    header.labelMarginLeft = 10;
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JHProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RGCellIDValueDefault forIndexPath:indexPath];
    if (collectionView == self.collectionView) {
        NSInteger row = self.tableView.indexPathForSelectedRow.row;
        
        NSDictionary *cate = self.categorys[row];
        NSArray *sections = self.sortProducts[cate[@"id"]];
        NSDictionary *cate2 = sections[indexPath.section];
        NSDictionary *product = cate2[@"list"][indexPath.row];
        
        cell.titleLabel.text = product[@"name"];
        cell.imageView.image = [UIImage imageNamed:product[@"icon"]];
    }
    return cell;
}

@end
