//
//  PictureBrowser.m
//  PictureBrowser
//
//  Created by wdyzmx on 2019/6/5.
//  Copyright © 2019 wdyzmx. All rights reserved.
//

#import "PictureBrowser.h"

@interface PictureBrowser () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray<NSString *> *imageViewFrameArray;
@end

@implementation PictureBrowser

- (instancetype)initWithFrame:(CGRect)frame picsArray:(nonnull NSArray *)picsArray indexPath:(nonnull NSIndexPath *)indexPath {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tapGesture];
        self.userInteractionEnabled = YES;
        [self addSubview:self.scrollView];
        self.scrollView.contentOffset = CGPointMake(indexPath.item*frame.size.width, 0);
        self.scrollView.contentSize = CGSizeMake(frame.size.width*picsArray.count, 0);
        for (int i = 0; i < picsArray.count; i++) {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * frame.size.width, frame.size.height/2 - frame.size.width/2, frame.size.width, frame.size.width)];
            [self.scrollView addSubview:imgView];
            [self.imageViewFrameArray addObject:NSStringFromCGRect(imgView.frame)];
            imgView.image = [UIImage imageNamed:picsArray[i]];
        }
    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)tap {
    self.tapAction(self.scrollView, self.imageViewFrameArray);
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
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
