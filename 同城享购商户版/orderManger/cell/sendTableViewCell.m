//
//  sendTableViewCell.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/5.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "sendTableViewCell.h"
#import <YYLabel.h>
#import <Masonry.h>
#import <UIButton+YYWebImage.h>
#import <UIImageView+YYWebImage.h>
#import <UIImage+YYAdd.h>
#import <Masonry.h>
#import "productView.h"
#import "orderInfoUpView.h"
#import "orderInfoDownView.h"
#import "sportManView.h"

@interface  sendTableViewCell ()

@property (nonatomic,strong) orderProductView *product;
@property (nonatomic,strong) orderInfoUpView *upView;
@property (nonatomic,strong) orderInfoDownView *downView;
@property (nonatomic,strong) sportManView *driveView;


@end

@implementation sendTableViewCell

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
    
    [self.contentView addSubview:self.upView];
    
    [self.contentView addSubview:self.product];
    
    [self.contentView addSubview:self.driveView];
    
    [self.contentView addSubview:self.downView];
    
    [self.upView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).with.offset(0);
        make.left.mas_equalTo(self.contentView).with.offset(0);
        make.height.mas_equalTo(@170);
        make.width.mas_equalTo(@SCREEN_WIDTH);
    }];
   
    [self.product mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.upView.mas_bottom).with.offset(0);
        make.left.mas_equalTo(self.contentView).with.offset(0);
        make.width.mas_equalTo(@SCREEN_WIDTH);
        make.height.mas_equalTo(@0).priorityLow();
    }];
    [self.driveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.product.mas_bottom).with.offset(0);
        make.left.mas_equalTo(self.contentView).with.offset(0);
        make.width.mas_equalTo(@SCREEN_WIDTH);
        make.height.mas_equalTo(@0).priorityLow();
        
    }];
    [self.downView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.driveView.mas_bottom).with.offset(0);
        make.left.mas_equalTo(self.contentView).with.offset(0);
        make.width.mas_equalTo(@SCREEN_WIDTH);
        make.height.mas_equalTo(@148);
        make.bottom.mas_equalTo(self.contentView).with.offset(-10);
    }];
//
}
- (void)setIndex:(NSInteger)index{
    _index = index;
    self.downView.currentIndex = index;
    
}
- (void)setModel:(orderModel *)model{
//
    _model = model;
    self.upView.model = model;
    self.product.productsArray=[NSMutableArray arrayWithArray:model.products];
    if ([model.showDriver boolValue]) {
        [self.driveView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(64).priorityMedium();
        }];
    }else{
        [self.driveView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0).priorityMedium();
        }];
    }
    self.driveView.model = model;
    
    self.downView.model = model;

}

- (orderProductView *)product{
    if (!_product) {
        _product = [[orderProductView alloc]init];
    }
    return _product;
}

- (orderInfoUpView *)upView{
    if (!_upView) {
        _upView = [[orderInfoUpView alloc]init];
    }
    return _upView;
}

- (sportManView *)driveView{
    if (!_driveView) {
        _driveView = [[sportManView alloc]init];
    }
    return _driveView;
}

- (orderInfoDownView *)downView{

    if (!_downView) {
        _downView = [[orderInfoDownView alloc]init];
        
        [_downView setConnectBuyer:^(NSString *buyerTel) {
            NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",buyerTel];
        
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }];
        [_downView setConnectDriver:^(NSString *driverTel) {
            
    
            NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",driverTel];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }];
        
        _downView.tag = 501;
        
    }
    return _downView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

@interface orderProductView ()

@property (nonatomic,strong) NSMutableArray *ordersArray;


@end

@implementation orderProductView

- (NSMutableArray *)ordersArray{
    if (!_ordersArray) {
        _ordersArray = [[NSMutableArray alloc]init];
    }
    return _ordersArray;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self uiconfig];
    }
    return self;
}
- (void)uiconfig{
    for (int i= 0; i<20; i++) {
        productView *proView = [[productView alloc]initWithFrame:CGRectMake(0, 80*i, SCREEN_WIDTH, 80)];
        proView.hidden = YES;
        [self.ordersArray addObject:proView];
        [self addSubview:proView];
    }
}
- (void)setProductsArray:(NSMutableArray *)productsArray{
    
    _productsArray = productsArray;
    
    [self.ordersArray enumerateObjectsUsingBlock:^(productView* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx<productsArray.count) {
            [obj setValueWithDic:productsArray[idx]];
            obj.hidden = NO;
            
        }else{
            obj.hidden = YES;
        }
    }];
    if (productsArray.count == 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0).priorityMedium();
        }];
    }else{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(80*productsArray.count).priorityMedium();
        }];
    }
}

@end

