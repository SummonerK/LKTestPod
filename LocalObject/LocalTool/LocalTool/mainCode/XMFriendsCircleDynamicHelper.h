//
//  XMFriendsCircleDynamicHelper.h
//  AFNetworking
//
//  Created by Frank on 2024/6/26.
//

#import <Foundation/Foundation.h>
#import <XMText/YYLabel.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMFriendsCircleDynamicHelper : NSObject
//视频
@property (nonatomic, assign) CGSize videoCalSize;      // 计算出来的视频的宽高
//图片
@property (nonatomic, assign) CGFloat picHeight;        //图片高度，0为没图片
@property (nonatomic, assign) CGSize picSize;           //图片大小
@property (nonatomic, assign) NSInteger imageCount;
@property (nonatomic, assign) NSInteger videoCount;
//内容
@property (nonatomic, strong) YYTextLayout *contentDetailTextLayout;
@property (nonatomic, assign) CGFloat contentDetailHeight;
@property (nonatomic, assign) CGFloat contentViewHeight;
@property (nonatomic, strong) NSAttributedString *contentDetailAttr;    //带表情的富文本
@property (nonatomic, copy) NSString* keyContent; ///原始文本

@property (nonatomic, assign) CGFloat cellWidth;        //容器宽度
@property (nonatomic, assign) CGFloat bodyViewWidth;    //内容视图宽度
@property (nonatomic, assign) CGFloat cellHeight;       //cell总高度

/// 初始化工具-计算朋友圈展示内容信息
/// - Parameters:
///   - imageCount: 图片个数
///   - videoCount: 视频个数
///   - content: 内容
///   - isImageLandscape: 「w > h」如果返回的图片是宽图 12:15.5 || 默认长图的 5:4
///   - isVideoLandscape: 第一个视频是否是横屏「w > h」
- (instancetype)initHelperWithImageValue:(NSInteger)imageCount
                   isFirstImageLandscape:(BOOL)isImageLandscape
                          withVideoValue:(NSInteger)videoCount
                   isFirstVideoLandscape:(BOOL)isVideoLandscape
                             withContent:(NSString*)content;

- (void)layout;


@end

NS_ASSUME_NONNULL_END
