//
//  UICollectionViewLeftAlignedLayout.m
//  LKDisplayModule
//
//  Created by lofi on 2024/8/1.
//

#import "UICollectionViewLeftAlignedLayout.h"

@interface UICollectionViewLayoutAttributes (LeftAligned)

- (void)leftAlignFrameWithSectionInset:(UIEdgeInsets)sectionInset;

@end

@implementation UICollectionViewLayoutAttributes (LeftAligned)

/** 每行第一个item左对齐 **/
- (void)leftAlignFrameWithSectionInset:(UIEdgeInsets)sectionInset {
    CGRect frame = self.frame;
    frame.origin.x = sectionInset.left;
    self.frame = frame;
}

@end

@implementation UICollectionViewLeftAlignedLayout

#pragma mark - UICollectionViewLayout
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray* attributesToReturn = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes* attributes in attributesToReturn) {
        if (nil == attributes.representedElementKind) {
            NSIndexPath* indexPath = attributes.indexPath;
            attributes.frame = [self layoutAttributesForItemAtIndexPath:indexPath].frame;
        }
    }
    return attributesToReturn;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //现在item的UICollectionViewLayoutAttributes
    UICollectionViewLayoutAttributes* currentItemAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    //现在section的sectionInset
    UIEdgeInsets sectionInset = [self evaluatedSectionInsetForItemAtIndex:indexPath.section];
    
    //是否是section的第一个item
    BOOL isFirstItemInSection = indexPath.item == 0;
    //出去section偏移量的宽度
    CGFloat layoutWidth = CGRectGetWidth(self.collectionView.frame) - sectionInset.left - sectionInset.right;
    
    //是section的第一个item
    if (isFirstItemInSection) {
        //每行第一个item左对齐
        [currentItemAttributes leftAlignFrameWithSectionInset:sectionInset];
        return currentItemAttributes;
    }
    
    //前一个item的NSIndexPath
    NSIndexPath* previousIndexPath = [NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section];
    //前一个item的frame
    CGRect previousFrame = [self layoutAttributesForItemAtIndexPath:previousIndexPath].frame;
    //为现在item计算新的left
    CGFloat previousFrameRightPoint = previousFrame.origin.x + previousFrame.size.width;
    //现在item的frame
    CGRect currentFrame = currentItemAttributes.frame;
    //现在item所在一行的frame
    CGRect strecthedCurrentFrame = CGRectMake(sectionInset.left,
                                              currentFrame.origin.y,
                                              layoutWidth,
                                              currentFrame.size.height);
    //previousFrame和strecthedCurrentFrame是否有交集，没有，说明这个item和前一个item在同一行，item是这行的第一个item
    BOOL isFirstItemInRow = !CGRectIntersectsRect(previousFrame, strecthedCurrentFrame);
    
    //item是这行的第一个item
    if (isFirstItemInRow) {
        //每行第一个item左对齐
        [currentItemAttributes leftAlignFrameWithSectionInset:sectionInset];
        return currentItemAttributes;
    }
    
    //不是每行的第一个item
    CGRect frame = currentItemAttributes.frame;
    //为item计算新的left = previousFrameRightPoint + item之间的间距
    frame.origin.x = previousFrameRightPoint + [self evaluatedMinimumInteritemSpacingForItemAtIndex:indexPath.row];
    //为item的frame赋新值
    currentItemAttributes.frame = frame;
    return currentItemAttributes;
}

/** item行间距 **/
- (CGFloat)evaluatedMinimumInteritemSpacingForItemAtIndex:(NSInteger)index {
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        id<UICollectionViewDelegateLeftAlignedLayout> delegate = (id<UICollectionViewDelegateLeftAlignedLayout>)self.collectionView.delegate;
        
        return [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:index];
    } else {
        return self.minimumInteritemSpacing;
    }
}

/** section的偏移量 **/
- (UIEdgeInsets)evaluatedSectionInsetForItemAtIndex:(NSInteger)index {
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        id<UICollectionViewDelegateLeftAlignedLayout> delegate = (id<UICollectionViewDelegateLeftAlignedLayout>)self.collectionView.delegate;
        
        return [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:index];
    } else {
        return self.sectionInset;
    }
}

@end

