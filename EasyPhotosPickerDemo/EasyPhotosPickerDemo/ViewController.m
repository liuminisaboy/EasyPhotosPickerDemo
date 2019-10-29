//
//  ViewController.m
//  EasyPhotosPickerDemo
//
//  Created by Sen on 2019/10/21.
//  Copyright © 2019 lm. All rights reserved.
//

#import "ViewController.h"
#import "PhotoPreview.h"
#import "EasyPhotoPickerController.h"

@interface ViewController ()
<PhotoPreviewDelegate>

@property (nonatomic, strong) UIScrollView* rootView;

@property (nonatomic, strong) UIButton* headerIconView;

@property (nonatomic, strong) PhotoPreview* photoPreview;


@end

@implementation ViewController


- (void)loadView {
    [super loadView];
    
    [self setupUI];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

#pragma mark - action
- (void)btnOfSelectHeader:(UIButton*)sender {
        
    EasyPhotoPickerController* vc = [[EasyPhotoPickerController alloc] init];
    [vc showPhotoLibraryWithTarget:self success:^(NSArray * _Nonnull images) {
        [self.headerIconView setImage:images.firstObject forState:UIControlStateNormal];
    }];
}

#pragma mark - PhotoPreviewDelegate
- (void)addPhotoPreview:(PhotoPreview *)preview {
    
    EasyPhotoPickerController* vc = [[EasyPhotoPickerController alloc] init];
    vc.allowsMultipleSelection = YES;
    vc.maxCount = 9-self.photoPreview.listInfo.count+1;
    [vc showPhotoLibraryWithTarget:self success:^(NSArray * _Nonnull images) {
        self.photoPreview.listInfo = [images mutableCopy];
    }];
    
}

#pragma mark - setup UI
- (void)setupUI{
    
    [self.view addSubview:self.rootView];
    
    UILabel* markLb = [[UILabel alloc] initWithFrame:CGRectMake(16, 44, 100, 20)];
    markLb.text = @"选择单个";
    [self.rootView addSubview:markLb];
    
    [self.rootView addSubview:self.headerIconView];
    
    markLb = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(self.headerIconView.frame)+30, 100, 20)];
    markLb.text = @"选择多个";
    [self.rootView addSubview:markLb];
    
    [self.rootView addSubview:self.photoPreview];
}

#pragma mark - lazy
- (UIScrollView *)rootView {
    if (!_rootView) {
        _rootView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _rootView.backgroundColor = [UIColor whiteColor];
        _rootView.alwaysBounceVertical = YES;
        
    }
    return _rootView;
}

- (UIButton *)headerIconView {
    if (!_headerIconView) {
        _headerIconView = [UIButton buttonWithType:UIButtonTypeCustom];
        _headerIconView.frame = CGRectMake(16, 84, 100, 100);
        [_headerIconView setImage:[UIImage imageNamed:@"Add"] forState:UIControlStateNormal];
        _headerIconView.clipsToBounds = YES;
        _headerIconView.layer.cornerRadius = 5;
        _headerIconView.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_headerIconView addTarget:self action:@selector(btnOfSelectHeader:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _headerIconView;
}

- (PhotoPreview *)photoPreview {
    if (!_photoPreview) {
        _photoPreview = [[PhotoPreview alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(self.headerIconView.frame)+70, self.rootView.bounds.size.width-32, self.rootView.bounds.size.width-32)];
        _photoPreview.delegate = self;
    }
    return _photoPreview;
}

@end
