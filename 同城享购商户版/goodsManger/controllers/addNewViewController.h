//
//  addNewViewController.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/28.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "baseViewController.h"
#import "goodsModel.h"

@interface addNewViewController : baseViewController
//title
@property (nonatomic,strong) NSString *vcTitle;
//single page
//商品分类
@property (nonatomic,strong) NSMutableArray *changeTypesArray;
//是否是编辑
@property BOOL isEdited;
//编辑状态下的 由上一级传过来的模型
@property (nonatomic,strong)goodsModel *goodModel;
//关键字 由上一级传下来的关键字
@property (nonatomic,strong) NSArray *pastKeyWordArray;


//由上一级传过来的分类ID
@property (nonatomic,strong) NSArray *typeIDArray;
@property (nonatomic,assign) NSInteger typeBeginIndex;

//editd page
//通知上一级界面更新
@property (nonatomic,strong) void(^goodsUpdate)(NSIndexPath *indexPath);

@property BOOL isAddGoodsInGoodsList;

@end
