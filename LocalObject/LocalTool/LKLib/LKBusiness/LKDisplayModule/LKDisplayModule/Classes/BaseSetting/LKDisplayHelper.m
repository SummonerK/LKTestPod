//
//  LKDisplayHelper.m
//  LKDisplayModule
//
//  Created by lofi on 2024/10/29.
//

#import "LKDisplayHelper.h"

NSString *const DisplayResourcesBundleName = @"LKDisplayBundle";

@implementation LKDisplayHelper
 
+ (UIImage *)imageWithName:(NSString *)name {
    static NSBundle *resourceBundle = nil;
    if (!resourceBundle) {
        NSBundle *mainBundle = [NSBundle bundleForClass:self];
        NSString *resourcePath = [mainBundle pathForResource:DisplayResourcesBundleName ofType:@"bundle"];
        resourceBundle = [NSBundle bundleWithPath:resourcePath] ?: mainBundle;
    }
    UIImage *image = [UIImage imageNamed:name inBundle:resourceBundle compatibleWithTraitCollection:nil];
    return image;
}
 
@end
