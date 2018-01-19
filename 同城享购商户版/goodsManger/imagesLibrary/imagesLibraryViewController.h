//
//  imagesLibraryViewController.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/14.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "baseViewController.h"

// ** 代理方法

@interface imagesLibraryViewController : baseViewController

@property (nonatomic,strong) void(^selectedPic)(UIImage *image);
@property (nonatomic,strong) void(^selectedPics)(NSArray<UIImage *> *selectedImageArray);

@property (nonatomic,strong) NSString *searchName;

@property (nonatomic,assign) NSInteger maxSelectedCount;

@end
