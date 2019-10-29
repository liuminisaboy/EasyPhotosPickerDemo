//
//  PhotoPreview.m
//  EasyPhotosPickerDemo
//
//  Created by Sen on 2019/10/22.
//  Copyright © 2019 lm. All rights reserved.
//

#import "PhotoPreview.h"

@interface PhotoPreview ()

@property (nonatomic, assign) BOOL canAdd;

@end

@implementation PhotoPreview

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.myCollectionView];
        
        [self defaultInfo];
    }
    return self;
}

#pragma mark - default set
- (void)defaultInfo {
    
    self.canAdd = YES;
    
    self.listInfo = [NSMutableArray array];
}

#pragma mark - dataSource

- (void)setListInfo:(NSMutableArray *)listInfo {
    
        
    if (listInfo.count == 0) {
        _listInfo = listInfo;
    }else {
        [_listInfo addObjectsFromArray:listInfo];
    }
    
    [_listInfo removeObject:@"Add"];
    if (_listInfo.count < 9) {
        [_listInfo addObject:@"Add"];
    }
    
    [self.myCollectionView reloadData];
    
    self.canAdd = listInfo.count == 9 ? NO : YES;
}

#pragma mark - UICollectionViewDataSource UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listInfo.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    id tmp = self.listInfo[indexPath.row];
    if ([tmp isKindOfClass:[NSString class]]) {
        cell.photoView.image = [UIImage imageNamed:(NSString*)tmp];
    }else{
        cell.photoView.image = (UIImage*)tmp;
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id tmp = self.listInfo[indexPath.row];
    
    if ([tmp isKindOfClass:[NSString class]]) {
        //添加
        
        if ([self.delegate respondsToSelector:@selector(addPhotoPreview:)]) {
            [self.delegate addPhotoPreview:self];
        }
        
    }else {
        //预览图片
        
        
    }
    
}

#pragma mark - lazy

- (UICollectionView *)myCollectionView {
    if (!_myCollectionView) {
        
        CGFloat w = (self.bounds.size.width-8)/3;
        CGFloat h = w;
        
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 4;
        layout.minimumLineSpacing = 4;
        layout.itemSize = CGSizeMake(w, h);
        _myCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        _myCollectionView.dataSource = self;
        _myCollectionView.delegate = self;
        [_myCollectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"PhotoCell"];
        
    }
    return _myCollectionView;
}

@end




@implementation PhotoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.photoView];
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _photoView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (UIImageView *)photoView {
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        _photoView.clipsToBounds = YES;
        _photoView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _photoView;
}

@end







