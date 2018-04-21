//
//  SXSiftView.m
//  SXSiftView
//
//  Created by Story5 on 2018/4/21.
//  Copyright © 2018年 Story5. All rights reserved.
//

#import "SXSiftView.h"
#import "SXSiftLayout.h"
#import "SXSiftCell.h"
#import "SXSiftSectionHeader.h"
#import "SXTool.h"

#define cellIdentifier @"cell"
#define headerIdentifier @"header"

@interface SXSiftView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SXSiftLayoutDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation SXSiftView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

#pragma mark - private
- (void)createUI
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
    [self.collectionView registerClass:[SXSiftCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self.collectionView registerClass:[SXSiftSectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
}

- (UICollectionView *)collectionView
{
    if(_collectionView == nil) {
        SXSiftLayout *layout = [[SXSiftLayout alloc] init];
        layout.delegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

#pragma mark - collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [self.dataArray objectAtIndex:section];
    NSArray *array = [sectionDic objectForKey:@"item"];
    
    return array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SXSiftCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary *sectionDic = [self.dataArray objectAtIndex:indexPath.section];
    NSArray *array = [sectionDic objectForKey:@"item"];
    NSDictionary *rowDic = [array objectAtIndex:indexPath.row];
    NSString *title = [rowDic objectForKey:@"spec_item_val"];
    
    cell.title = title;
    cell.font = [UIFont systemFontOfSize:16];
    cell.normalTitleColor = [UIColor grayColor];
    cell.selectedTitleColor = [UIColor colorWithRed:0.26 green:0.62 blue:0.49 alpha:1.00];
    cell.normalBorderColor = [UIColor lightGrayColor];
    cell.selectedBorderColor = [UIColor colorWithRed:0.26 green:0.62 blue:0.49 alpha:1.00];
    cell.borderWidth = 2;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sectionDic = [self.dataArray objectAtIndex:indexPath.section];
    NSString *headerTitle = [sectionDic objectForKey:@"spec"];
    
    if (kind == UICollectionElementKindSectionHeader) {
    
        SXSiftSectionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        headerView.title = [NSString stringWithFormat:@"%@:",headerTitle];
        headerView.font = [UIFont systemFontOfSize:16];
        return headerView;
    }
    
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout
/** 每个头标题大小 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(SXSiftLayout *)sxSiftLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [self.dataArray objectAtIndex:section];
    NSString *headerTitle = [sectionDic objectForKey:@"spec"];
    NSString *text = [NSString stringWithFormat:@"%@:",headerTitle];
    
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    CGSize size = [SXTool calTextSize:headerTitle attributes:attr];
    
    return CGSizeMake(size.width + 10, size.height + 10);
}

/** 每个cell的大小 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(SXSiftLayout *)sxSiftLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    NSDictionary *sectionDic = [self.dataArray objectAtIndex:indexPath.section];
    NSArray *array = [sectionDic objectForKey:@"item"];
    NSDictionary *rowDic = [array objectAtIndex:indexPath.row];
    NSString *title = [rowDic objectForKey:@"spec_item_val"];
    
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    CGSize size = [SXTool calTextSize:title attributes:attr];
    
    return CGSizeMake(size.width + 10,size.height + 10);
}

// 每个section间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(SXSiftLayout *)sxSiftLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat top = 10;
    CGFloat left = 0;
    CGFloat bottom = 10;
    CGFloat right = 0;
    return UIEdgeInsetsMake(top, left, bottom, right);
}

// 每个section内row的水平间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(SXSiftLayout *)sxSiftLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if(section == 0) {
        return 35;
    } else if (section == 1) {
        return 23;
    }
    return 0;
}

// 每个section内row的垂直间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(SXSiftLayout *)sxSiftLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.delegate && [self.delegate respondsToSelector:@selector(sxSiftView:didSelectItemAtIndexPath:itemDic:)]) {
        NSDictionary *sectionDic = [self.dataArray objectAtIndex:indexPath.section];
        NSArray *array = [sectionDic objectForKey:@"item"];
        NSDictionary *rowDic = [array objectAtIndex:indexPath.row];
        [self.delegate sxSiftView:self didSelectItemAtIndexPath:indexPath itemDic:rowDic];
    }
}

@end
