//
//  SXSiftLayout.h
//  SXSiftView
//
//  Created by Story5 on 2018/4/21.
//  Copyright © 2018年 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SXSiftLayout;
@protocol SXSiftLayoutDelegate <NSObject>

@optional
//  每个section的边界
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(SXSiftLayout*)sxSiftLayout insetForSectionAtIndex:(NSInteger)section;
//  每个cell的水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(SXSiftLayout*)sxSiftLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
//  每个cell的垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(SXSiftLayout*)sxSiftLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
//  每个cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(SXSiftLayout*)sxSiftLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
//  每个header大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(SXSiftLayout*)sxSiftLayout referenceSizeForHeaderInSection:(NSInteger)section;
//  每个footer大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(SXSiftLayout*)sxSiftLayout referenceSizeForFooterInSection:(NSInteger)section;

@optional
// 计算 item frame 方法
- (CGRect)collectionView:(UICollectionView *)collectionView layout:(SXSiftLayout *)sxSiftLayout frameForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark - sxSiftLayout
@interface SXSiftLayout : UICollectionViewLayout

@property (nonatomic,weak) id<SXSiftLayoutDelegate> delegate;

@property (nonatomic) CGFloat minimumSectionSpacing;    // 每个section间距

@property (nonatomic) CGFloat minimumInteritemSpacing;  // 每个cell的水平间距
@property (nonatomic) CGFloat minimumLineSpacing;       // 每个cell的垂直间距
@property (nonatomic) CGSize itemSize;                  // 每个cell的大小
//@property (nonatomic) CGSize estimatedItemSize;         // defaults to CGSizeZero - setting a non-zero size enables cells that self-size via -preferredLayoutAttributesFittingAttributes:
@property (nonatomic) CGSize headerReferenceSize;       // 每个header大小
//@property (nonatomic) CGSize footerReferenceSize;       // 每个footer大小


//@property (nonatomic) UICollectionViewScrollDirection scrollDirection; // default is UICollectionViewScrollDirectionVertical
//@property (nonatomic) UIEdgeInsets sectionInset;
// Set these properties to YES to get headers that pin to the top of the screen and footers that pin to the bottom while scrolling (similar to UITableView).
//@property (nonatomic) BOOL sectionHeadersPinToVisibleBounds NS_AVAILABLE_IOS(9_0);
//@property (nonatomic) BOOL sectionFootersPinToVisibleBounds NS_AVAILABLE_IOS(9_0);

@end
