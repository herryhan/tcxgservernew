//
//  iconCollectionViewCell.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2018/1/17.
//  Copyright © 2018年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iconCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;

@property (nonatomic,strong) void(^delBtnPress)(NSInteger tag);

- (UIView *)snapshotView;
@end
