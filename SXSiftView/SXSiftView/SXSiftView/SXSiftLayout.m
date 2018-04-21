//
//  SXSiftLayout.m
//  SXSiftView
//
//  Created by Story5 on 2018/4/21.
//  Copyright © 2018年 Story5. All rights reserved.
//

#import "SXSiftLayout.h"

@interface SXSiftLayout()

@property (nonatomic, strong) NSMutableArray *itemAttributesArray;
@property (nonatomic, strong) NSMutableArray *headerAttributesArray;
@property (nonatomic, strong) NSMutableArray *footerAttributesArray;

@property (nonatomic) CGFloat sectionMinY;
@property (nonatomic) CGFloat sectionMaxY;

@end

@implementation SXSiftLayout

#pragma mark- 布局相关方法
// 1.第一步执行
- (void)prepareLayout {
    [super prepareLayout];
    NSLog(@"%s",__func__);
    
    [self.headerAttributesArray removeAllObjects];
    [self.footerAttributesArray removeAllObjects];
    [self.itemAttributesArray removeAllObjects];
    
    
    
    NSInteger sectionCount = self.collectionView.numberOfSections;
    for (int i = 0; i < sectionCount; i++) {
        NSIndexPath *sectionIndexPath = [NSIndexPath indexPathForRow:0 inSection:i];
        
        //  headerAttributesArray
        UICollectionViewLayoutAttributes *headerAttribute = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:sectionIndexPath];
        [self.headerAttributesArray addObject:headerAttribute];
        //  footerAttributesArray
        //        UICollectionViewLayoutAttributes *footerAttribute = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:sectionIndexPath];
        //        [self.footerAttributesArray addObject:footerAttribute];
        
        //  itemAttributesArray
        NSInteger rowCount = [self.collectionView numberOfItemsInSection:i];
        for (int j = 0; j < rowCount; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            UICollectionViewLayoutAttributes *itemAttribute = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.itemAttributesArray addObject:itemAttribute];
        }
    }
}

// 2.第二步执行
- (CGSize)collectionViewContentSize {
    NSLog(@"%s",__func__);
    
    CGSize contentSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), self.sectionMaxY);
    contentSize.height = contentSize.height + 75;
    NSLog(@"contentSize = %@",NSStringFromCGSize(contentSize));
    
    return contentSize;
    //    return CGSizeMake(375, 652 + 75);
}

// 3.第三步执行
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSLog(@"%s",__func__);
    NSMutableArray *attributesArray = [[NSMutableArray alloc] initWithArray:self.itemAttributesArray];
    [attributesArray addObjectsFromArray:self.headerAttributesArray];
    [attributesArray addObjectsFromArray:self.footerAttributesArray];
    
    return attributesArray;
}

//  每个header/footer属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__func__);
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    CGSize size = CGSizeZero;
    // 每个section间距
    if (elementKind == UICollectionElementKindSectionHeader) {
        size = [self getHeaderReferenceSizeWithSection:indexPath.section];
    }
    
    self.sectionMinY = self.minimumSectionSpacing + (self.minimumSectionSpacing + size.height) * indexPath.section;
    self.sectionMaxY = self.sectionMinY + size.height;
    attributes.frame = CGRectMake(0, self.sectionMinY, size.width, size.height);
    
    return attributes;
}

//  每个cell的属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s",__func__);
    //根据indexPath获取item的attributes
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // 每个cell的frame
    CGRect itemFrame = CGRectZero;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:frameForItemAtIndexPath:)]) {
        
        itemFrame = [self.delegate collectionView:self.collectionView layout:self frameForItemAtIndexPath:indexPath];
        
    } else if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        
        itemFrame = [self getItemFrameWithIndexPath:indexPath];
    }
    
    
    //设置attributes的frame
    attributes.frame = itemFrame;
    return attributes;
}

#pragma mark - private methods
- (CGRect)getItemFrameWithIndexPath:(NSIndexPath *)indexPath
{
    CGRect frame = CGRectZero;
    
    CGFloat minimumInteritemSpacing = [self getMinimumInteritemSpacingWithIndexPath:indexPath];
    CGFloat minimumLineSpacing = [self getMinimumLineSpacingWithIndexPath:indexPath];
    CGSize itemSize = [self getItemSizeWithIndexPath:indexPath];
    CGSize headerSize = [self getHeaderReferenceSizeWithSection:indexPath.section];
    
    
    float collectionWidth = self.collectionView.frame.size.width;
    
    self.sectionMinY = self.minimumSectionSpacing + (self.minimumSectionSpacing + headerSize.height) * indexPath.section;
    self.sectionMaxY = self.sectionMinY + headerSize.height;
    
    NSLog(@"\nindexPath = %@,minY = %f,maxY = %f",indexPath,_sectionMinY,_sectionMaxY);
    
    /** 2017.01.12  by Story5
     *  备注一下
     *  这里暂时写死，以2和3作判断，来实现不同的布局，因为没有找到更好的实现灵活布局方式
     */
    CGPoint origin = CGPointZero;
    
    //  上1 下1
    origin.x = headerSize.width + (itemSize.width + minimumInteritemSpacing) * indexPath.row;
    origin.y = self.sectionMinY;
    
    NSLog(@"headerWidth:%f",headerSize.width);
    NSLog(@"itemSize:%f,%f",itemSize.width,itemSize.height);
    NSLog(@"space:%f,%f",minimumInteritemSpacing,minimumLineSpacing);
    NSLog(@"origin:%f,%f",origin.x,origin.y);
    
    frame = CGRectMake(origin.x, origin.y, itemSize.width, itemSize.height);
    
    return frame;
}

// 每个cell的水平间距
- (CGFloat)getMinimumInteritemSpacingWithIndexPath:(NSIndexPath *)indexPath
{
    CGFloat minimumInteritemSpacing = 0;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        
        minimumInteritemSpacing = [self.delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:indexPath.section];
        self.minimumInteritemSpacing = minimumInteritemSpacing;
        
    } else {
        minimumInteritemSpacing = self.minimumInteritemSpacing;
    }
    return minimumInteritemSpacing;
}

// 每个cell的垂直间距
- (CGFloat)getMinimumLineSpacingWithIndexPath:(NSIndexPath *)indexPath
{
    CGFloat minimumLineSpacing = 0;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        
        minimumLineSpacing = [self.delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:indexPath.section];
        self.minimumLineSpacing = minimumLineSpacing;
        
    } else {
        minimumLineSpacing = self.minimumLineSpacing;
    }
    return minimumLineSpacing;
}

// 每个cell的大小
- (CGSize)getItemSizeWithIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize = CGSizeZero;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        
        itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
        self.itemSize = itemSize;
        
    } else {
        itemSize = self.itemSize;
    }
    return itemSize;
}

//  每个header的大小
- (CGSize)getHeaderReferenceSizeWithSection:(NSInteger)section
{
    CGSize headSize = CGSizeZero;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
        headSize = [self.delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:section];
        self.headerReferenceSize = headSize;
    } else {
        headSize = self.headerReferenceSize;
    }
    return headSize;
}

#pragma mark - getter
- (NSMutableArray *)itemAttributesArray
{
    if (_itemAttributesArray == nil) {
        _itemAttributesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _itemAttributesArray;
}

- (NSMutableArray *)headerAttributesArray
{
    if (_headerAttributesArray == nil) {
        _headerAttributesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _headerAttributesArray;
}

- (NSMutableArray *)footerAttributesArray
{
    if (_footerAttributesArray == nil) {
        _footerAttributesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _footerAttributesArray;
}

@end
