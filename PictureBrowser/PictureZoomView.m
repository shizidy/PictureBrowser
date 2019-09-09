//
//  PictureZoomView.m
//  PictureBrowser
//
//  Created by wdyzmx on 2019/9/8.
//  Copyright © 2019 wdyzmx. All rights reserved.
//

#import "PictureZoomView.h"
#import "Macro.h"

@interface PictureZoomView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation PictureZoomView

- (instancetype)initWithFrame:(CGRect)frame picture:(nonnull NSString *)picture {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.enlargeImage];
        self.enlargeImage.image = [UIImage imageNamed:picture];
    }
    return self;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.enlargeImage;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGRect frame = self.enlargeImage.frame;
    
    frame.origin.y = (self.scrollView.frame.size.height - self.enlargeImage.frame.size.height) > 0 ? (self.scrollView.frame.size.height - self.enlargeImage.frame.size.height) * 0.5 : 0;
    frame.origin.x = (self.scrollView.frame.size.width - self.enlargeImage.frame.size.width) > 0 ? (self.scrollView.frame.size.width - self.enlargeImage.frame.size.width) * 0.5 : 0;
    self.enlargeImage.frame = frame;
    
    self.scrollView.contentSize = CGSizeMake(self.enlargeImage.frame.size.width, self.enlargeImage.frame.size.height);
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.minimumZoomScale = 0.5;
        _scrollView.maximumZoomScale = 3;
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), 0);
    }
    return _scrollView;
}

- (UIImageView *)enlargeImage {
    if (!_enlargeImage) {
        _enlargeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.scrollView.frame) / 2 - CGRectGetWidth(self.frame) / 2, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame))];
    }
    return _enlargeImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
