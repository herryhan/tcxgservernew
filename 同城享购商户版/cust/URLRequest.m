//
//  URLRequest.m
//  外汇
//
//  Created by 庄园 on 17/11/4.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "URLRequest.h"
#import "keepData.h"
#import "LoginViewController.h"

@implementation URLRequest

//#define BASEURL @"http://192.168.124.2:9876/web/api/"

#define BASEURL @"http://ha.tongchengxianggou.com/api/"
#define BASEIMAGEURL @"http://pic.tongchengxianggou.com:9909/api/"

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 15.0f;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];

    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
           
            [mgr.operationQueue cancelAllOperations];
            failure(task,error);
            NSLog(@"%@",error);
            
        }
    }];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr;
    //如果locate为0则用默认的URL去请求
    
    if ([keepData getLocateUrl].length==0) {
        mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
    }else{
        mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[keepData getLocateUrl]]]];
    }
    
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 10000.0f;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //申明请求的数据是json类型
   // mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain",@"application/json",@"text/html",@"text/json",nil];
   
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
                success(task, responseObject);
        }
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        if (failure) {
            [mgr.operationQueue cancelAllOperations];
            failure(task,error);
        }  
    }];
}

//上传图片、音频、视频文件
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray name:(NSArray *)nameArray success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr;
    
    if ([keepData getLocateUrl].length==0) {
        
        mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
    }else{
        mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/",[keepData getLocateUrl]]]];
    }
    

  mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];

    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (formDataArray.count ==2 ) {
            for (int i = 0; i<formDataArray.count; i++) {
                for (int j = 0; j<[(NSArray *)formDataArray[i] count]; j++) {
                    
                    NSData *data = UIImagePNGRepresentation(formDataArray[i][j]);
                    [formData appendPartWithFileData:data name:nameArray[i][j] fileName:[NSString stringWithFormat:@"%@.png",nameArray[i][j]] mimeType:@"image/png"];
                }
            }
        }else{
            for (int i = 0; i<formDataArray.count; i++) {
                NSData *data = UIImageJPEGRepresentation(formDataArray[i], 2);
                [formData appendPartWithFileData:data name:nameArray[i] fileName:[NSString stringWithFormat:@"%@.png",nameArray[i]] mimeType:@"image/png"];
            }
        }
      
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
                success(task, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            [mgr.operationQueue cancelAllOperations];
            failure(task,error);
        }
    }];
    
}

+ (void)postWithImageURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASEIMAGEURL]];
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 100.0f;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    // mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain",@"application/json",@"text/html",@"text/json",nil];
    
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success){
            success(task, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            [mgr.operationQueue cancelAllOperations];
            failure(task,error);
        }
        
    }];
}

@end
