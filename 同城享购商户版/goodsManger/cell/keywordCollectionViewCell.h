//
//  keywordCollectionViewCell.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/1.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface keywordCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *keywordsName;

@property (weak, nonatomic) IBOutlet UIButton *subBtn;

@property (nonatomic,strong) void (^subPress)(BOOL isSub);

@end
