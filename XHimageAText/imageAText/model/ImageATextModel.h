//
//  ImageATextModel.h
//  XHimageAText
//
//  Created by XH on 16/11/21.
//  Copyright © 2016年 huoniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@class ImageATextCommentModel;
@interface ImageATextModel : NSObject

@property (nonatomic,strong) NSArray * recent_comments;

@property (nonatomic,strong) NSArray * top_comments;

@end

@interface ImageATextCommentModel : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *user_profile_image_url;
@property (nonatomic, copy) NSString *platform;
@property (nonatomic, copy) NSString *platformid;
@property (nonatomic, copy) NSString *user_profile_url;
@property (nonatomic, copy) NSString *avatar_url;

@property (nonatomic, assign) BOOL user_verified;

@property (nonatomic, assign) NSInteger create_time;
@property (nonatomic, assign) NSInteger user_bury;
/** 用户ID*/
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger is_digg;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger share_type;
@property (nonatomic, assign) NSInteger group_id;
@property (nonatomic, assign) NSInteger comment_id;
@property (nonatomic, strong) NSArray <ImageATextCommentModel *>*reply_comments;

@end
