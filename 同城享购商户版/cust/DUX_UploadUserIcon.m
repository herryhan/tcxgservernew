//
//  DUX_UploadUserIcon.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/29.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "DUX_UploadUserIcon.h"
#import "imagesLibraryViewController.h"

static DUX_UploadUserIcon *uploadUserIcon = nil;

@implementation DUX_UploadUserIcon

/*  ============================================================  */
#pragma mark - 单例方法
+ (DUX_UploadUserIcon *)shareUploadImage {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uploadUserIcon = [[DUX_UploadUserIcon alloc] init];
    });
    return uploadUserIcon;
}

/*  ============================================================  */
#pragma mark - 显示ActionSheet方法
- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC WithShowDel:(BOOL)isShow AndtagIndex:(NSInteger)imageTag WithTitle:(NSString *)title delegate:(id<DUX_UploadUserIconDelegate>)aDelegate {
    
    uploadUserIcon.uploadImageDelegate = aDelegate;
    self.fatherViewController = fatherVC;
    self.isShowDel = isShow;
    self.tag = imageTag;
    self.searchTitle = title;
    UIActionSheet *sheet;
    if (self.isShowDel) {
        sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:@"相册", @"拍照",@"在线图库",nil];
    }else{
        sheet = [[UIActionSheet alloc] initWithTitle:nil
                                            delegate:self
                                   cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                                   otherButtonTitles:@"相册", @"拍照",@"在线图库",@"删除图片",nil];
    }
    
    [sheet showInView:fatherVC.view];
}

#pragma mark - UIActionSheetDelegate
    - (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
        if (buttonIndex == 0) {
            [self fromPhotos];
        }else if (buttonIndex == 1) {
            [self createPhotoView];
        }else if (buttonIndex == 2){
            [self showImageLibrary];
        }else if(buttonIndex == 3){
            [self delImage];
        }
}
    
    /*  ============================================================  */
#pragma mark - 头像图片(从相机中选择得到)
- (void)createPhotoView {
        // ** 设置相机模式
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
            imagePC.sourceType  = UIImagePickerControllerSourceTypeCamera;
            imagePC.delegate = self;
            imagePC.allowsEditing = YES;
            [_fatherViewController presentViewController:imagePC animated:YES completion:nil];
        } else {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                             message:@"该设备没有照相机"
                                                            delegate:nil
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:nil];
            [alert show];
        }
}
    
    /*  ============================================================  */
#pragma mark - 图片库方法(从手机的图片库中查找图片)

- (void)fromPhotos {
    
        UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
        imagePC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePC.delegate = self;
        imagePC.allowsEditing = YES;
        [_fatherViewController presentViewController:imagePC animated:YES completion:nil];
    
}

- (void)showImageLibrary{

    imagesLibraryViewController *imageVC = [[imagesLibraryViewController alloc]init];
    imageVC.searchName = self.searchTitle;
    [imageVC setSelectedPic:^(UIImage *image) {
        if (self.uploadImageDelegate && [self.uploadImageDelegate respondsToSelector:@selector(uploadFromLibrary:)]) {
            [self.uploadImageDelegate uploadFromLibrary:image];
        } 
    }];
    [_fatherViewController presentViewController:imageVC animated:YES completion:nil];
    
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
        [picker dismissViewControllerAnimated:YES completion:nil];
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        // ** 上传用户头像
        if (self.uploadImageDelegate && [self.uploadImageDelegate respondsToSelector:@selector(uploadImageToServerWithImage:)]) {
            [self.uploadImageDelegate uploadImageToServerWithImage:image];
        }
    }
- (void)delImage{
    if (self.uploadImageDelegate && [self.uploadImageDelegate respondsToSelector:@selector(deleteImage:)]) {
        [self.uploadImageDelegate deleteImage:self.tag];
    }
}
    @end
    
