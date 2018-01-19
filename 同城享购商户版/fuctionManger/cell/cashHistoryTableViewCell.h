//
//  cashHistoryTableViewCell.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/11.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cashModel.h"

@interface cashHistoryTableViewCell : UITableViewCell

@property (nonatomic,strong) cashModel *model;

@property (nonatomic,assign) NSInteger count;

@end

@interface orderListView: UIView


@property (nonatomic,strong) NSArray *orderListArray;

@end
