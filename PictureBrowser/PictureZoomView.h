//
//  PictureZoomView.h
//  PictureBrowser
//
//  Created by wdyzmx on 2019/9/8.
//  Copyright © 2019 wdyzmx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PictureZoomView : UIView
@property (nonatomic, strong) UIImageView *enlargeImage;
- (instancetype)initWithFrame:(CGRect)frame picture:(NSString *)picture;
@end

NS_ASSUME_NONNULL_END
