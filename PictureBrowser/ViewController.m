//
//  ViewController.m
//  PictureBrowser
//
//  Created by wdyzmx on 2019/6/5.
//  Copyright © 2019 wdyzmx. All rights reserved.
//

#import "ViewController.h"
#import "Macro.h"
#import "PictureBrowser.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *picsArray;
@property (nonatomic, strong) NSMutableArray<NSString *> *imgViewFrameArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark ========== UICollectionViewDataSource ==========
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.picsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.contentView.frame), CGRectGetHeight(cell.contentView.frame))];
    [cell.contentView addSubview:imgView];
    imgView.image = [UIImage imageNamed:self.picsArray[indexPath.item]];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    CGRect rect = [cell.contentView convertRect:imgView.frame toView:self.view];
    rect.origin.y += 64;
    [self.imgViewFrameArray addObject:NSStringFromCGRect(rect)];
    return cell;
}

#pragma mark ========== UICollectionViewDataSource ==========
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //获取转化后rect
    CGRect selectRect = CGRectFromString(self.imgViewFrameArray[indexPath.item]);
    //新建tempImgView
    UIImageView *tempImgView = [[UIImageView alloc] initWithFrame:selectRect];
    [self.view addSubview:tempImgView];
    tempImgView.image = [UIImage imageNamed:self.picsArray[indexPath.item]];
    tempImgView.contentMode = UIViewContentModeScaleAspectFit;
    CGRect targetRect = CGRectMake(0, kScreenHeight/2 - kScreenWidth/2, kScreenWidth, kScreenWidth);
    //执行动画
    [UIView animateWithDuration:0.3 animations:^{
        tempImgView.frame = targetRect;
    } completion:^(BOOL finished) {
        [tempImgView removeFromSuperview];
        
        PictureBrowser *pictureBrowser = [[PictureBrowser alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) picsArray:self.picsArray indexPath:indexPath];
        [[UIApplication sharedApplication].keyWindow addSubview:pictureBrowser];
        
        __weak typeof(PictureBrowser *)weakBrowser = pictureBrowser;
        __weak typeof(self)weakSelf = self;
        pictureBrowser.tapAction = ^(UIScrollView * _Nonnull scrollView, PictureZoomView * _Nonnull zoomView, UIImageView * _Nonnull enlargeImage) {            
            [weakBrowser removeFromSuperview];
            NSInteger page = (NSInteger)scrollView.contentOffset.x/kScreenWidth;
            CGRect rect = [zoomView convertRect:enlargeImage.frame toView:self.view];
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
            [weakSelf.view addSubview:imgView];
            imgView.image = [UIImage imageNamed:weakSelf.picsArray[page]];
            CGRect tempRect = CGRectFromString(self.imgViewFrameArray[page]);
            [UIView animateWithDuration:0.3 animations:^{
                imgView.frame = tempRect;
            } completion:^(BOOL finished) {
                [imgView removeFromSuperview];
            }];
        };
    }];
}

#pragma mark ========== 懒加载 ==========
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(kScreenWidth/3, kScreenWidth/3);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    }
    return _collectionView;
}

- (NSArray *)picsArray {
    if (!_picsArray) {
        _picsArray = [NSArray arrayWithObjects:@"logo_1.jpg", @"logo_2.jpg", @"logo_3.jpg", nil];
    }
    return _picsArray;
}

- (NSMutableArray<NSString *> *)imgViewFrameArray {
    if (!_imgViewFrameArray) {
        _imgViewFrameArray = [NSMutableArray array];
    }
    return _imgViewFrameArray;
}

@end
