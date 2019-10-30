//
//  EasyPhotoPickerController.m
//  EasyPhotosPickerDemo
//
//  Created by Sen on 2019/10/22.
//  Copyright © 2019 lm. All rights reserved.
//

#import "EasyPhotoPickerController.h"
#import "EasyAlbumsView.h"

@interface EasyPhotoPickerController ()
<UICollectionViewDataSource,UICollectionViewDelegate,EasyAlbumsViewDelegate,PHPhotoLibraryChangeObserver>

@property (nonatomic, strong) UICollectionView* myCollectionView;
@property (nonatomic, strong) EasyAlbumsView* albumsView;
@property (nonatomic, strong) UIVisualEffectView* bottomView;
@property (nonatomic, strong) UIButton* doneButton;

@property (nonatomic, strong) NSMutableDictionary* cacheImageInfoDic;

@property (nonatomic, strong) AlbumsModel * albumsModel;

@end

@implementation EasyPhotoPickerController

- (void)dealloc
{
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

- (void)loadView {
    [super loadView];
    
    [self.view addSubview:self.myCollectionView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.albumsView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Photos";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem* left = [[UIBarButtonItem alloc] initWithTitle:@"切换相簿" style:UIBarButtonItemStylePlain target:self action:@selector(btnOfSwitchLibrary)];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem* right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(btnOfCancel)];
    self.navigationItem.rightBarButtonItem = right;
    
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
    
    [self defaultInfo];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.myCollectionView.frame = self.view.bounds;
    self.albumsView.frame = self.view.bounds;
    self.bottomView.frame = CGRectMake(0, self.view.bounds.size.height-kAPPFrame.height_bottomBar, kAPPFrame.screen_width, kAPPFrame.height_bottomBar);
}

#pragma mark - action

- (void)btnOfCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)btnOfSwitchLibrary {
    
    if (self.albumsView.isShow)
    {
        [self.albumsView dismiss];
    }
    else
    {
        [self.albumsView show];
    }
}

- (void)btnOfDone:(UIButton*)sender {
    
    
    NSMutableArray* images = [NSMutableArray array];
    
    for (int i = 0; i<self.myCollectionView.indexPathsForSelectedItems.count; i++) {
        NSIndexPath* ip = self.myCollectionView.indexPathsForSelectedItems[i];
        PHAsset* asset = [self.albumsModel.assets objectAtIndex:ip.row];
        
        UIImage* img = [self.cacheImageInfoDic objectForKey:asset.localIdentifier];
        [images addObject:img];
    }
    
    self.selectImagesBlock(images);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - data
- (void)defaultInfo {
    
    //目录
    self.albumsView.listInfo = [EasyPhotoManager fetchAllAlbums];
    
    //当前
    self.albumsModel = [EasyPhotoManager fetchDefaultPhotos];
    self.title = self.albumsModel.title;
    [self.myCollectionView reloadData];
}

#pragma mark - block
- (void)showPhotoLibraryWithTarget:(UIViewController*)target success:(BlockSelectedImages)success {
    
    self.selectImagesBlock = success;
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:self];
    [target presentViewController:nav animated:YES completion:nil];
}

#pragma mark - PHPhotoLibraryChangeObserver
- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self defaultInfo];
    });
    
}

#pragma mark - EasyAlbumsViewDelegate
- (void)albumsView:(EasyAlbumsView *)albumsView didSelectAlbumsModel:(AlbumsModel *)albumsModel {
    
    self.albumsModel = albumsModel;
    self.title = albumsModel.title;
    [self.myCollectionView reloadData];
    self.doneButton.enabled = NO;
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.albumsModel.assets.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoPickerCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoPickerCell" forIndexPath:indexPath];
    
    PHAsset* asset = [self.albumsModel.assets objectAtIndex:indexPath.row];
        
    UIImage* cacheImage = [self.cacheImageInfoDic objectForKey:asset.localIdentifier];
    if (cacheImage)
    {
        cell.photoView.image = cacheImage;
    }
    else
    {
        [EasyPhotoManager requestImageForAsset:asset success:^(UIImage * _Nonnull image) {
            cell.photoView.image = image;
            [self.cacheImageInfoDic setObject:image forKey:asset.localIdentifier];
        }];
    }
    
    return cell;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.allowsMultipleSelection && collectionView.indexPathsForSelectedItems.count == self.maxCount) {
        return NO;
    }
    return YES;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self updateBottomView];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self updateBottomView];
}

- (void)updateBottomView {
    
    if (self.myCollectionView.indexPathsForSelectedItems.count == 0)
    {
        self.doneButton.enabled = NO;
    }
    else
    {
        self.doneButton.enabled = YES;
        [self.doneButton setTitle:[NSString stringWithFormat:@"完成 %zd",self.myCollectionView.indexPathsForSelectedItems.count] forState:UIControlStateNormal];
    }
}

#pragma mark - lazy
- (EasyAlbumsView *)albumsView {
    if (!_albumsView) {
        _albumsView = [EasyAlbumsView albumView];
        _albumsView.delegate = self;
    }
    return _albumsView;
}

- (UICollectionView *)myCollectionView {
    if (!_myCollectionView) {
        
        CGFloat w = (self.view.bounds.size.width-6)/4;
        CGFloat h = w;
        
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 2;
        layout.minimumLineSpacing = 2;
        layout.itemSize = CGSizeMake(w, h);
        
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        _myCollectionView.dataSource = self;
        _myCollectionView.delegate = self;
        _myCollectionView.alwaysBounceVertical = YES;
        _myCollectionView.allowsMultipleSelection = self.allowsMultipleSelection;
        
        [_myCollectionView registerClass:[PhotoPickerCell class] forCellWithReuseIdentifier:@"PhotoPickerCell"];
        
        _myCollectionView.contentInset = UIEdgeInsetsMake(0, 0, kAPPFrame.height_bottomBar, 0);
        
    }
    return _myCollectionView;
}
- (UIVisualEffectView *)bottomView {
    if (!_bottomView) {
        
        UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _bottomView = [[UIVisualEffectView alloc] initWithEffect:effect];
        _bottomView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.618];
        
        _doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _doneButton.enabled = NO;
        _doneButton.frame = CGRectMake(0, 10, kAPPFrame.screen_width, 40);
        [_doneButton setTitle:@"完成" forState:UIControlStateDisabled];
        [_doneButton addTarget:self action:@selector(btnOfDone:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.contentView addSubview:_doneButton];
    }
    return _bottomView;
}


- (NSMutableDictionary *)cacheImageInfoDic {
    if (!_cacheImageInfoDic) {
        _cacheImageInfoDic = [NSMutableDictionary dictionary];
    }
    return _cacheImageInfoDic;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end



@implementation PhotoPickerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.photoView];
        [self.contentView addSubview:self.chooseIcon];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _photoView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _chooseIcon.frame = CGRectMake(self.frame.size.width-20-5, 5, 20, 20);
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    self.chooseIcon.selected = selected;

}
- (void)setEnabled:(BOOL)enabled {
    if (enabled) {
        self.photoView.alpha = 1;
    }else {
        self.photoView.alpha = 0.5;
    }
}

- (UIImageView *)photoView {
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        _photoView.clipsToBounds = YES;
        _photoView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _photoView;
}

- (UIButton *)chooseIcon {
    if (!_chooseIcon) {
        _chooseIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        _chooseIcon.userInteractionEnabled = NO;
        [_chooseIcon setImage:[UIImage imageNamed:@"Unchecked"] forState:UIControlStateNormal];
        [_chooseIcon setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
    }
    return _chooseIcon;
}

@end
