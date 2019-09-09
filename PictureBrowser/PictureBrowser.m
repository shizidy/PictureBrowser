//
//  PictureBrowser.m
//  PictureBrowser
//
//  Created by wdyzmx on 2019/6/5.
//  Copyright © 2019 wdyzmx. All rights reserved.
//

#import "PictureBrowser.h"
#import "Macro.h"

@interface PictureBrowser () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray<NSString *> *imageViewFrameArray;
@property (nonatomic, strong) UIImageView *enlargeImage;
@end

@implementation PictureBrowser

- (instancetype)initWithFrame:(CGRect)frame picsArray:(nonnull NSArray *)picsArray indexPath:(nonnull NSIndexPath *)indexPath {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tapGesture];
        self.userInteractionEnabled = YES;
        [self addSubview:self.scrollView];
        self.scrollView.contentOffset = CGPointMake(indexPath.item * frame.size.width, 0);
        self.scrollView.contentSize = CGSizeMake(frame.size.width * picsArray.count, 0);
        for (int i = 0; i < picsArray.count; i++) {
            PictureZoomView *zoomView = [[PictureZoomView alloc] initWithFrame:CGRectMake(i * frame.size.width, 0, frame.size.width, frame.size.height) picture:picsArray[i]];
            [self.scrollView addSubview:zoomView];
            zoomView.tag = i + 1;
//            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * frame.size.width, frame.size.height/2 - frame.size.width/2, frame.size.width, frame.size.width)];
//            [self.imageViewFrameArray addObject:NSStringFromCGRect(imgView.frame)];
//            imgView.image = [UIImage imageNamed:picsArray[i]];
//            if (i == 0) {
//                self.enlargeImage = imgView;
//            }
        }
    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)tap {
    NSInteger page = (NSInteger)self.scrollView.contentOffset.x/kScreenWidth;
    PictureZoomView *zoomView = (PictureZoomView *)[self viewWithTag:page + 1];
    self.tapAction(self.scrollView, zoomView, zoomView.enlargeImage);
}

//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
//    return self.enlargeImage;
//}
//
//- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
//    NSLog(@"%@", NSStringFromCGRect(self.enlargeImage.frame));
//    CGRect frame = self.enlargeImage.frame;
//
//    frame.origin.y = (self.scrollView.frame.size.height - self.enlargeImage.frame.size.height) > 0 ? (self.scrollView.frame.size.height - self.enlargeImage.frame.size.height) * 0.5 : 0;
//    frame.origin.x = (self.scrollView.frame.size.width - self.enlargeImage.frame.size.width) > 0 ? (self.scrollView.frame.size.width - self.enlargeImage.frame.size.width) * 0.5 : 0;
//    self.enlargeImage.frame = frame;
//
//    self.scrollView.contentSize = CGSizeMake(self.enlargeImage.frame.size.width, self.enlargeImage.frame.size.height);
//    //
//
//}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.minimumZoomScale = 0.5;
        _scrollView.maximumZoomScale = 3;
    }
    return _scrollView;
}

- (NSMutableArray<NSString *> *)imageViewFrameArray {
    if (!_imageViewFrameArray) {
        _imageViewFrameArray = [NSMutableArray array];
    }
    return _imageViewFrameArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
