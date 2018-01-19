//
//  DUX_UploadUserIcon.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/29.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <Foundation/Foundation.h>

/*  ============================================================  */
// ** 宏定义单例模式方便外界调用
#define UPLOAD_IMAGE [DUX_UploadUserIcon shareUploadImage]

// ** 代理方法
@protocol DUX_UploadUserIconDelegate <NSObject>

@optional
// ** 处理图片的方法
- (void)uploadImageToServerWithImage:(UIImage *)image;
- (void)uploadFromLibrary:(UIImage *)image;

// ** 进入图库
// 删除图片
- (void)deleteImage:(NSInteger)imageTag;

@end

/*  ============================================================  */
@interface DUX_UploadUserIcon : NSObject <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) id <DUX_UploadUserIconDelegate> uploadImageDelegate;
@property (nonatomic,strong) UIViewController * fatherViewController;
@property (nonatomic,assign) BOOL isShowDel;
@property (nonatomic,assign) NSInteger tag;
@property (nonatomic,strong) NSString *searchTitle;

// ** 单例方法
+ (DUX_UploadUserIcon *)shareUploadImage;

// ** 弹出选项窗口的方法
- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC WithShowDel:(BOOL)isShow AndtagIndex:(NSInteger)imageTag WithTitle:(NSString *)title delegate:(id<DUX_UploadUserIconDelegate>)aDelegate;

@end

