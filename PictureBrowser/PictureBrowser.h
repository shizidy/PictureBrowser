//
//  PictureBrowser.h
//  PictureBrowser
//
//  Created by wdyzmx on 2019/6/5.
//  Copyright © 2019 wdyzmx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PictureBrowser : UIView
@property (nonatomic, copy) void(^tapAction)(UIScrollView *scrollView, NSMutableArray *imageViewFrameArray);
- (instancetype)initWithFrame:(CGRect)frame picsArray:(NSArray *)picsArray indexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
