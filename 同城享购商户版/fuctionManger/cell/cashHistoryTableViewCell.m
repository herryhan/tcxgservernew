//
//  cashHistoryTableViewCell.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/11.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "cashHistoryTableViewCell.h"
#import "cashOrderView.h"
#import "cashHistroyView.h"
#import <Masonry.h>

@interface  cashHistoryTableViewCell ()

@property (nonatomic,strong) cashHistroyView *cashUpView;
@property (nonatomic,strong) orderListView *listView;



@end

@implementation cashHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
       [self SetUpUI];
        
    }
    return self;
}
- (void)SetUpUI{
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.cashUpView];
    [self.contentView addSubview:self.listView];
    [self.cashUpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).with.offset(0);
        make.left.mas_equalTo(self.contentView).with.offset(0);
        make.width.mas_equalTo(@SCREEN_WIDTH);
        make.height.mas_equalTo(@484);
    }];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cashUpView.mas_bottom).with.offset(0);
        make.left.mas_equalTo(self.contentView).with.offset(0);
        make.width.mas_equalTo(@SCREEN_WIDTH);
        make.height.mas_equalTo(@0).priorityLow();
        make.bottom.mas_equalTo(self.contentView).with.offset(-5);
    }];
}
- (void)setCount:(NSInteger)count{
    
    
}
- (void)setModel:(cashModel *)model{
    _model = model;
    self.cashUpView.model = model;
    self.listView.orderListArray = model.orderList;
}
- (cashHistroyView *)cashUpView{
    if (!_cashUpView) {
        _cashUpView = [[cashHistroyView alloc]init];
    }
    return _cashUpView;
}
- (orderListView *)listView{
    if (!_listView) {
        _listView = [[orderListView alloc]init];
    }
    return _listView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


@interface orderListView ()

@property (nonatomic,strong) NSMutableArray *orderListViewsArray;

@end

@implementation orderListView

- (NSMutableArray *)orderListViewsArray{
    if (!_orderListViewsArray) {
        _orderListViewsArray = [[NSMutableArray alloc]init];
    }
    return _orderListViewsArray;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self config:20];
    }
    return self;
}
- (void)config:(NSInteger)count{
    for (int i=0; i<count; i++) {
        cashOrderView *orderview = [[cashOrderView alloc]initWithFrame:CGRectMake(0, 40*i, SCREEN_WIDTH, 40)];
        orderview.hidden = YES;
        [self.orderListViewsArray addObject:orderview];
        [self addSubview:orderview];
    }
}
- (void)setOrderListArray:(NSArray *)orderListArray{
    _orderListArray = orderListArray;
   // [self config:orderListArray.count];
    [self.orderListViewsArray enumerateObjectsUsingBlock:^(cashOrderView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx<orderListArray.count) {
            [obj setValueWithDic:orderListArray[idx]];
            obj.hidden = NO;
        }else{
            obj.hidden = YES;
        }
    }];
    if (orderListArray.count == 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0).priorityMedium();
        }];
    }else{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40*orderListArray.count).priorityMedium();
        }];
    }
}

@end












