//
//  XMFriendsCircleDynamicHelper.m
//  AFNetworking
//
//  Created by Frank on 2024/6/26.
//

#import "XMFriendsCircleDynamicHelper.h"
#import <XMText/NSAttributedString+YYText.h>
#import <XMText/YYText.h>
#import <XMText/YYTextUtilities.h>
#import <XMUIKit/XMMacroDefine.h>
#import <XMTUICore/NSString+emoji.h>

#define kCellPaddingPic 4 ///图片间距

@interface XMFriendsCircleDynamicHelper()

@property (nonatomic, assign) BOOL isImageLandscape;
@property (nonatomic, assign) BOOL isVideoLandscape;
@property (nonatomic, strong) NSString* content;
@property (nonatomic, assign) CGFloat bodyImageViewWidth;    //内容视图宽度
@property (nonatomic, assign) CGFloat bodyVideoViewWidth;    //内容视图宽度

@end

@implementation XMFriendsCircleDynamicHelper

- (instancetype)initHelperWithImageValue:(NSInteger)imageCount
                   isFirstImageLandscape:(BOOL)isImageLandscape
                          withVideoValue:(NSInteger)videoCount
                   isFirstVideoLandscape:(BOOL)isVideoLandscape
                             withContent:(NSString*)content{
    if (self = [super init]) {
        self.cellWidth          = kScreenWidth;
        self.bodyViewWidth      = self.cellWidth - 62 - 12;
        self.bodyImageViewWidth      = self.cellWidth - 62 - 72;
        self.bodyVideoViewWidth      = self.cellWidth - 62 - 85;
        self.imageCount = imageCount;
        self.videoCount = videoCount;
        self.content = content;
        self.isVideoLandscape = isVideoLandscape;
        self.isImageLandscape = isImageLandscape;
        self.keyContent = content;
        
        [self layoutVideo];
        [self layoutPics];
    }
    return self;
}

- (void)layoutVideo {
    _videoCalSize = CGSizeZero;
    if (self.videoCount == 0) {
        return;
    }
    // 采用竖屏展示
    CGFloat videoH = YYTextCGFloatPixelRound(224 * self.cellWidth / 375);
    CGFloat videoW = YYTextCGFloatPixelRound(videoH * 3 / 4);
    self.videoCalSize = CGSizeMake(videoW, videoH);
    
    if (self.isVideoLandscape) {
        // 默认横屏
        CGFloat videoHeight = YYTextCGFloatPixelRound(self.bodyVideoViewWidth * 3 / 4);
        self.videoCalSize = CGSizeMake(self.bodyVideoViewWidth, videoHeight);
    }
}

- (void)layoutPics {
    _picSize = CGSizeZero;
    _picHeight = 0;
    if (self.imageCount == 0) return;
    
    CGSize picSize = CGSizeZero;
    CGFloat picHeight = 0;
    
    CGFloat len1_3 = (self.bodyImageViewWidth - kCellPaddingPic * 2) / 3;
    len1_3 = YYTextCGFloatPixelRound(len1_3);
    switch (self.imageCount) {
        case 1: {//单图
            /// 待优化 
//            id<XMMomentsPhotoModel> model = images.firstObject;
//            if (model.imageWidth == model.imageHeight) {
//                height = 168;
//            } else if (model.imageWidth > model.imageHeight) {
//                height = 130;
//            } else {
//                height = 210;
//            }
//            height = ceil(height * kScale);
            //默认长图的 5:4
            picSize.width = YYTextCGFloatPixelRound(228 * self.cellWidth / 375);
            picSize.height = YYTextCGFloatPixelRound(picSize.width * 5 / 4);
            //如果返回的图片是宽图 12:15.5
            if (self.isImageLandscape) {
                picSize.height = YYTextCGFloatPixelRound(picSize.width * 12 / 15.5);
            }
            picHeight = picSize.height;
        } break;
        case 2: case 3: {
            picSize = CGSizeMake(len1_3, len1_3);
            picHeight = len1_3;
        } break;
        case 4: case 5: case 6: {
            picSize = CGSizeMake(len1_3, len1_3);
            picHeight = len1_3 * 2 + kCellPaddingPic;
        } break;
        default: { // 7, 8, 9
            picSize = CGSizeMake(len1_3, len1_3);
            picHeight = len1_3 * 3 + kCellPaddingPic * 2;
        } break;
    }
    
    self.picSize = picSize;
    self.picHeight = picHeight;
}

- (void)layoutContentDetail {
    _contentDetailTextLayout = nil;
    _contentDetailHeight = 0;
    
    if (self.content.length == 0) return;
    self.contentDetailAttr = [self.content getAdvancedFormatEmojiStringWithFont:[UIFont fontWithName:@"PingFangSC-Light" size:17] textColor:[UIColor colorNamed:@"XMLevel1Color"] emojiLocations:nil];
    CGFloat maxHeightLimit = 400;
    CGRect contentRect = [self.contentDetailAttr boundingRectWithSize:CGSizeMake(self.bodyViewWidth, maxHeightLimit) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    self.contentDetailHeight = contentRect.size.height;
        
}

// 布局
- (void)layout {
    CGFloat tHeight = 38;
    
    //内容
    if (self.content.length > 0){
        [self layoutContentDetail];
        tHeight += 10 + self.contentDetailHeight;
    }
    
    // 视频 或 图片
    CGFloat videoY = 10;
    if (self.videoCount > 0) {
        [self layoutVideo];
        tHeight += videoY + self.videoCalSize.height;
    } else if(self.imageCount > 0) {
        [self layoutPics];
        tHeight += videoY + self.picHeight;
    }
    
    self.cellHeight = tHeight;
}

@end
