//
//  EasyAlbumsView.m
//  EasyPhotosPickerDemo
//
//  Created by Sen on 2019/10/22.
//  Copyright © 2019 lm. All rights reserved.
//

#import "EasyAlbumsView.h"


@interface EasyAlbumsView ()
<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView* myTableView;


@end

@implementation EasyAlbumsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)albumView {
    
    UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    return [[EasyAlbumsView alloc] initWithEffect:effect];
}

- (instancetype)initWithEffect:(UIVisualEffect *)effect{
    self = [super initWithEffect:effect];
    if (self) {
        
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.618];
        self.alpha = 0;
        
        [self setupUI];
        
    }
    return self;
}


- (void)setListInfo:(NSArray *)listInfo {
    _listInfo = listInfo;
    [self.myTableView reloadData];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listInfo.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    AlbumsModel* model = self.listInfo[indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%zd", model.assets.count];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AlbumsModel* model = self.listInfo[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(albumsView:didSelectAlbumsModel:)]) {
        [self.delegate albumsView:self didSelectAlbumsModel:model];
    }
    
    [self dismiss];
}

#pragma mark - show & dismiss
- (void)show {
    
    [UIView animateWithDuration:0.382 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.myTableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        self.isShow = YES;
        
    }];
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.382 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.myTableView.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        self.isShow = NO;
    }];
}

#pragma mark - setupUI
- (void)setupUI {
        
    [self.contentView addSubview:self.myTableView];
}

#pragma mark - lazy

- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.rowHeight = 70;
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.tableFooterView = [[UIView alloc] init];
        
        if (@available(iOS 11.0, *)) {
            //
        } else {
            _myTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kAPPFrame.screen_width, kAPPFrame.height_navBar)];
        }
        
    }
    return _myTableView;
}

@end
